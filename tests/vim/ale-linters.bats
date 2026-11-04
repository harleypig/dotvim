#!/usr/bin/env bats

# Every linter our settings name for ALE is one the checked-out ALE defines,
# and none of them is an LSP linter while ALE's LSP support is switched off,
# so no configured linter is silently skipped. The global list in the late
# ale.vim is checked whole, and each ftplugin's buffer-local list with its
# filetype set.
#
# Vim runs headless through helpers/vim.bash.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture

  [[ -f $repo/.vim/pack/300-intellisense/start/ale/plugin/ale.vim ]] \
    || fail "ALE submodule is not checked out"
}

#-----------------------------------------------------------------------------
# start_vim SCRIPT - run Vim, source SCRIPT after startup, and load what it
# wrote to $report as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  # Check FILETYPE NAMES reports each name ALE does not define for the
  # filetype as bad=, and each LSP linter, which ALE skips while
  # g:ale_disable_lsp is set, as lsp=. ALE matches a configured name against
  # a linter's name and its aliases, over the filetypes it resolves to.
  cat > "$tmp/check.vim" <<EOF
redir! > $report

function! Check(ft, names) abort
  let l:linters = ale#linter#GetAll(ale#linter#ResolveFiletype(a:ft))

  for l:name in a:names
    let l:found = filter(copy(l:linters),
    \ {_, l -> index([l.name] + l.aliases, l:name) >= 0})

    if empty(l:found)
      echo 'bad=' . a:ft . ':' . l:name

    elseif get(l:found[0], 'lsp', '') isnot# '' && g:ale_disable_lsp
      echo 'lsp=' . a:ft . ':' . l:name
    endif
  endfor

  echo 'checked=' . a:ft
endfunction
EOF

  cat "$1" >> "$tmp/check.vim"
  printf 'redir END\nqa!\n' >> "$tmp/check.vim"

  headless_vim -S "$tmp/check.vim" || true

  run cat "$report"
}

#-----------------------------------------------------------------------------
# assert_buffer_linters FILETYPE - set FILETYPE on an empty buffer and check
# the b:ale_linters our ftplugin for it leaves there.
assert_buffer_linters() {
  cat > "$BATS_TEST_TMPDIR/body.vim" <<EOF
set filetype=$1
for s:name in get(b:, 'ale_linters', [])
  echo 'linter=' . s:name
endfor
call Check('$1', get(b:, 'ale_linters', []))
EOF

  start_vim "$BATS_TEST_TMPDIR/body.vim"

  assert_line "checked=$1"
  refute_line --partial 'bad='
  refute_line --partial 'lsp='
}

##############################################################################
#-----------------------------------------------------------------------------
@test "every linter in g:ale_linters is one ALE defines" {
  cat > "$BATS_TEST_TMPDIR/body.vim" <<'EOF'
echo 'filetypes=' . len(g:ale_linters)
for [s:ft, s:names] in items(g:ale_linters)
  call Check(s:ft, s:names)
endfor
EOF

  start_vim "$BATS_TEST_TMPDIR/body.vim"

  # Guards against a vacuous pass: the loop ran over a non-empty list.
  refute_line 'filetypes=0'
  assert_line --partial 'checked='
  refute_line --partial 'bad='
  refute_line --partial 'lsp='
}

#-----------------------------------------------------------------------------
@test "the hcl ftplugin names no linter ALE lacks" {
  assert_buffer_linters hcl
}

#-----------------------------------------------------------------------------
@test "the vim ftplugin names no linter ALE would skip" {
  assert_buffer_linters vim
  assert_line 'linter=vint'
}

#-----------------------------------------------------------------------------
@test "the terraform ftplugin names no linter ALE lacks" {
  assert_buffer_linters terraform
  assert_line 'linter=tflint'
}

#-----------------------------------------------------------------------------
@test "the yaml ftplugin names no linter ALE lacks" {
  assert_buffer_linters yaml
  assert_line 'linter=yamllint'
}
