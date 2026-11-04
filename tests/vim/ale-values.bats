#!/usr/bin/env bats

# The values our two ale.vim files give ALE. The early file's must already
# be set when ALE's plugin starts loading, since ALE fills in a default for
# any it does not find; the late file's global linters and fixers must
# still be whole after a buffer of every filetype we have an ftplugin for
# has been opened (#77 - one ftplugin wiped another's fixers).
# ale-settings.bats and ale-linters.bats check the LSP switch and that each
# linter name is one ALE defines.
#
# Vim runs headless through helpers/vim.bash.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

ftplugin_dir="$BATS_TEST_DIRNAME/../../.vim/pack/zzz-settings/start/settings/after/ftplugin"

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture

  [[ -f $repo/.vim/pack/300-intellisense/start/ale/plugin/ale.vim ]] \
    || fail "ALE submodule is not checked out"
}

#-----------------------------------------------------------------------------
# run_vim [VIM ARGS...] - run Vim, then the Vim script read from stdin with
# its messages redirected to $report, and load $report as $output.
run_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  {
    echo "redir! > $report"
    echo 'messages clear'
    cat
    echo "for s:line in split(execute('messages'), \"\\n\")"
    echo "  echo 'message: ' . s:line"
    echo 'endfor'
    echo 'redir END'
    echo 'qa!'
  } > "$tmp/test.vim"

  headless_vim -- "$@" -S "$tmp/test.vim" || true

  run cat "$report"

  # Errors are read from the message history, as load.bats reads them:
  # CI's Vim 9.1.0016 writes the errors a silent! hides in its own
  # syntax/sh.vim to the redirect, and sets v:errmsg from them, though
  # they never reach the history.
  refute_line --regexp '^message: (Error detected while processing|E[0-9]+:)'
}

##############################################################################
#-----------------------------------------------------------------------------
# The values are read by an autocmd that fires as ALE's plugin/ale.vim is
# about to be sourced, so a value set any later reads as unset.
@test "the early ALE settings are in place before ALE loads" {
  local names="'ale_lint_on_text_changed', 'ale_lint_on_insert_leave',
    \\ 'ale_virtualtext_cursor', 'ale_disable_lsp', 'ale_linters_explicit',
    \\ 'ale_fix_on_save', 'ale_set_loclist', 'ale_set_quickfix'"

  cat > "$BATS_TEST_TMPDIR/early.vim" <<EOF
let g:early = {}
autocmd SourcePre */start/ale/plugin/ale.vim
  \\ for s:name in [$names]
  \\ | let g:early[s:name] = get(g:, s:name, 'unset')
  \\ | endfor
EOF

  run_vim --cmd "source $BATS_TEST_TMPDIR/early.vim" <<'EOF'
echo 'loaded=' . exists('g:loaded_ale')
for [s:name, s:value] in sort(items(g:early))
  echo s:name . '=' . string(s:value)
endfor
EOF

  assert_line 'loaded=1'
  assert_line "ale_lint_on_text_changed='always'"
  assert_line 'ale_lint_on_insert_leave=1'
  assert_line "ale_virtualtext_cursor='disabled'"
  assert_line 'ale_disable_lsp=1'
  assert_line 'ale_linters_explicit=1'
  assert_line 'ale_fix_on_save=1'
  assert_line 'ale_set_loclist=0'
  assert_line 'ale_set_quickfix=1'
}

#-----------------------------------------------------------------------------
@test "the late ale.vim's global linters and fixers" {
  run_vim <<'EOF'
echo 'linters=' . string(sort(items(g:ale_linters)))
echo 'fixers=' . string(g:ale_fixers)
EOF

  assert_line "linters=[['awk', ['gawk']], ['dockerfile', ['hadolint']], ['ps1', ['powershell']], ['sql', ['sqlint']], ['systemd', ['systemd-analyze']]]"
  assert_line "fixers={'*': ['remove_trailing_lines', 'trim_whitespace'], 'sql': ['sqlformat']}"
}

#-----------------------------------------------------------------------------
# The filetypes are the names of our ftplugin files, so a new one is
# covered without being listed here. Each gets a window of its own: leaving
# a java buffer unloaded runs Vim's own java ftplugin clean-up, which raises
# errors that are not ours.
@test "every ftplugin leaves the global linters and fixers whole" {
  local file filetypes=()

  for file in "$ftplugin_dir"/*.vim; do
    [[ -f $file ]] || continue
    file=${file##*/}
    filetypes+=("'${file%.vim}'")
  done

  ((${#filetypes[@]} > 0)) || fail "no ftplugin found in $ftplugin_dir"

  local list
  list=$(IFS=,; echo "${filetypes[*]}")

  run_vim <<EOF
for s:ft in [$list]
  new
  execute 'setlocal filetype=' . s:ft
  echo 'opened=' . s:ft
endfor
echo 'linters=' . string(sort(items(g:ale_linters)))
echo 'star=' . string(get(g:ale_fixers, '*', 'missing'))
echo 'sql=' . string(get(g:ale_fixers, 'sql', 'missing'))
EOF

  assert_line 'opened=java'
  assert_line 'opened=yaml'
  assert_line "linters=[['awk', ['gawk']], ['dockerfile', ['hadolint']], ['ps1', ['powershell']], ['sql', ['sqlint']], ['systemd', ['systemd-analyze']]]"
  assert_line "star=['remove_trailing_lines', 'trim_whitespace']"
  assert_line "sql=['sqlformat']"
}
