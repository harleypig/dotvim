#!/usr/bin/env bats

# What each file in the late after/ftplugin directory sets for its
# filetype, read from a buffer of that filetype after a full startup.
# Files other tests already cover in full are not repeated here: json in
# load.bats, markdown in ale-settings.bats and intellisense.bats. Linter
# names are checked against ALE in ale-linters.bats.
#
# Vim runs headless through helpers/vim.bash, whose PATH holds only a
# shell, so a test that needs a formatter installed puts a stub of it on
# PATH.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture
}

#-----------------------------------------------------------------------------
# stub NAME - put an executable NAME on PATH that does nothing.
stub() {
  printf '#!/bin/sh\n' > "$stubs/$1"
  chmod +x "$stubs/$1"
}

#-----------------------------------------------------------------------------
# with_filetype FILETYPE - run Vim, set FILETYPE on its empty buffer, then
# run the Vim script read from stdin with its messages redirected to
# $report, and load $report as $output. The script may call Show(NAME),
# which echoes NAME=VALUE for an option (&...), a variable, or 'unset'.
with_filetype() {
  local tmp="$BATS_TEST_TMPDIR"

  {
    echo "redir! > $report"
    cat <<'EOF'
function! Show(name) abort
  let l:value = exists(a:name) ? eval(a:name) : 'unset'
  echo a:name . '=' . (type(l:value) == v:t_string ? l:value : string(l:value))
endfunction
EOF
    echo "setlocal filetype=$1"
    cat
    echo 'redir END'
    echo 'qa!'
  } > "$tmp/test.vim"

  headless_vim -S "$tmp/test.vim" || true

  run cat "$report"

  # Errors are read from what reached the user, not from v:errmsg: CI's
  # Vim 9.1.0016 sets v:errmsg from inside a silent! in its own
  # syntax/sh.vim (see load.bats).
  refute_output --partial 'Error detected while processing'
  refute_line --regexp '^E[0-9]+:'
}

##############################################################################
#-----------------------------------------------------------------------------
@test "hcl: hash comments, syntax folds, the terraform fixer, no linter" {
  with_filetype hcl <<'EOF'
call Show('&l:commentstring')
call Show('&l:foldmethod')
call Show('b:ale_fixers')
call Show('b:ale_linters')
EOF

  assert_line '&l:commentstring=# %s'
  assert_line '&l:foldmethod=syntax'
  assert_line "b:ale_fixers=['terraform']"
  assert_line 'b:ale_linters=unset'
}

#-----------------------------------------------------------------------------
# vim-polyglot's terraform ftplugin runs every ftplugin/hcl.vim, ours
# included, so a terraform buffer gets the comments, folds and fixer from
# hcl.vim as well; only tflint comes from terraform.vim alone.
@test "terraform: hash comments, syntax folds, tflint and the terraform fixer" {
  with_filetype terraform <<'EOF'
call Show('&l:commentstring')
call Show('&l:foldmethod')
call Show('b:ale_fixers')
call Show('b:ale_linters')
EOF

  assert_line '&l:commentstring=# %s'
  assert_line '&l:foldmethod=syntax'
  assert_line "b:ale_fixers=['terraform']"
  assert_line "b:ale_linters=['tflint']"
}

#-----------------------------------------------------------------------------
# coc-java reports Java's problems, so ALE is given no linter for it.
@test "java: no ALE linter, and no fixer without google-java-format" {
  with_filetype java <<'EOF'
call Show('b:ale_linters')
call Show('b:ale_fixers')
call Show('b:ale_fix_on_save')
EOF

  assert_line 'b:ale_linters=[]'
  assert_line 'b:ale_fixers=unset'
  assert_line 'b:ale_fix_on_save=unset'
}

#-----------------------------------------------------------------------------
@test "java: with google-java-format, it fixes the buffer on save" {
  stub google-java-format

  with_filetype java <<'EOF'
call Show('b:ale_linters')
call Show('b:ale_fixers')
call Show('b:ale_fix_on_save')
call Show('g:ale_fixers.java')
EOF

  assert_line 'b:ale_linters=[]'
  assert_line "b:ale_fixers=['google_java_format']"
  assert_line 'b:ale_fix_on_save=1'
  assert_line 'g:ale_fixers.java=unset'
}

#-----------------------------------------------------------------------------
# Vim's own python ftplugin indents by four; ours overrides it.
@test "python: two-space indents, expanded" {
  with_filetype python <<'EOF'
call Show('&l:tabstop')
call Show('&l:softtabstop')
call Show('&l:shiftwidth')
call Show('&l:expandtab')
EOF

  assert_line '&l:tabstop=2'
  assert_line '&l:softtabstop=2'
  assert_line '&l:shiftwidth=2'
  assert_line '&l:expandtab=1'
}

#-----------------------------------------------------------------------------
# load.bats checks that with neither installed python has no fixers key.
@test "python: isort and yapf are fixers when installed, isort first" {
  stub isort
  stub yapf

  with_filetype python <<'EOF'
call Show('g:ale_fixers.python')
EOF

  assert_line "g:ale_fixers.python=['isort', 'yapf']"
}

#-----------------------------------------------------------------------------
@test "python: yapf alone is the only fixer, with no isort option" {
  stub yapf

  with_filetype python <<'EOF'
call Show('g:ale_fixers.python')
call Show('b:ale_python_isort_auto_poetry')
EOF

  assert_line "g:ale_fixers.python=['yapf']"
  assert_line 'b:ale_python_isort_auto_poetry=unset'
}

#-----------------------------------------------------------------------------
# sh-ftplugin.bats runs the shfmt command with the indent; these are the
# rest of the options, kept in step with .editorconfig.
@test "sh: bash syntax, shfmt fixes on save with the editorconfig options" {
  with_filetype sh <<'EOF'
call Show('g:is_bash')
call Show('b:ale_fixers')
call Show('b:ale_fix_on_save')
call Show('b:ale_sh_shfmt_options')
EOF

  assert_line 'g:is_bash=1'
  assert_line "b:ale_fixers=['shfmt']"
  assert_line 'b:ale_fix_on_save=1'
  assert_line 'b:ale_sh_shfmt_options=--indent 2 --simplify --binary-next-line --case-indent --space-redirects '
}

#-----------------------------------------------------------------------------
# Vim's indent/vim.vim reads g:vim_indent for a continuation line's indent.
@test "vim: a continuation line is indented by one shiftwidth" {
  with_filetype vim <<'EOF'
call Show('g:vim_indent')
call Show('b:ale_linters')
EOF

  assert_line "g:vim_indent={'line_continuation': 2}"
  assert_line "b:ale_linters=['vint']"
}

#-----------------------------------------------------------------------------
@test "yaml: yamllint is added to linters the buffer already has" {
  with_filetype '' <<'EOF'
let b:ale_linters = ['spectral']
setlocal filetype=yaml
call Show('b:ale_linters')
EOF

  assert_line "b:ale_linters=['spectral', 'yamllint']"
}

#-----------------------------------------------------------------------------
@test "yaml: an Ansible buffer is linted by yamllint too" {
  with_filetype yaml.ansible <<'EOF'
call Show('b:ale_linters')
EOF

  assert_line --regexp "^b:ale_linters=\[(.*, )?'yamllint'(, .*)?\]$"
}
