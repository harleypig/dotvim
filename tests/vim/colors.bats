#!/usr/bin/env bats

# The colours our settings give highlight groups, read back as the GUI
# colours: set.vim turns on termguicolors, so a terminal shows a group's
# guifg and guibg and ignores its ctermfg and ctermbg. Whether Vim then draws
# them is Vim's to test.
#
# The harness is the one in statusline.bats: headless Vim on this checkout's
# .vimrc, HOME and the XDG directories inside the test's temp directory, and
# a PATH holding only a stub directory.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  repo="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  stubs="$BATS_TEST_TMPDIR/bin"
  report="$BATS_TEST_TMPDIR/report"
  file="$BATS_TEST_TMPDIR/file.txt"
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/home"

  [[ -f $repo/.vim/pack/300-intellisense/start/ale/plugin/ale.vim ]] \
    || fail "ALE submodule is not checked out"

  ln -s "$(type -P sh)" "$stubs/sh"
  printf 'text\n' > "$file"
}

#-----------------------------------------------------------------------------
# run_vim - open $file in Vim, run the Vim script read from stdin with its
# messages redirected to $report, and load $report as $output.
run_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  {
    echo "redir! > $report"
    echo 'function! Gui(group)'
    echo "  let l:id = synIDtrans(hlID(a:group))"
    echo "  return synIDattr(l:id, 'bg', 'gui') . '/' . synIDattr(l:id, 'fg', 'gui')"
    echo 'endfunction'
    cat
    echo 'redir END'
    echo 'qa!'
  } > "$tmp/test.vim"

  timeout 30 env -i \
    HOME="$tmp/home" PATH="$stubs" TERM=dumb \
    XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config" \
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
    XDG_CACHE_HOME="$tmp/cache" \
    "$vim" -N -u "$repo/.vimrc" -es "$file" -S "$tmp/test.vim" || true

  run cat "$report"
}

##############################################################################
#-----------------------------------------------------------------------------
# Red while statusline.vim sets only ctermbg and ctermfg, which termguicolors
# hides (#144 - terminal-only colours never show).
@test "the statusline has GUI colours at startup, in Insert mode and in the command-line window" {
  run_vim <<'EOF'
echo 'startup=' . Gui('StatusLine')
doautocmd InsertEnter
echo 'insert=' . Gui('StatusLine')
doautocmd InsertLeave
echo 'insert_left=' . Gui('StatusLine')
doautocmd CmdwinEnter
echo 'cmdwin=' . Gui('StatusLine')
doautocmd CmdwinLeave
echo 'cmdwin_left=' . Gui('StatusLine')
EOF

  assert_line 'startup=Black/White'
  assert_line 'insert=Yellow/Blue'
  assert_line 'insert_left=Black/White'
  assert_line 'cmdwin=Gray/Red'
  assert_line 'cmdwin_left=Black/White'
}

#-----------------------------------------------------------------------------
@test "the diagnostic groups have the palette's GUI colours" {
  run_vim <<'EOF'
for s:group in ['ALEErrorSign', 'CocErrorSign', 'DiagnosticError',
  \ 'ALEWarningSign', 'CocWarningSign', 'DiagnosticWarning',
  \ 'ALEInfoSign', 'CocInfoSign', 'DiagnosticInfo', 'CocHintSign']
  echo s:group . '=' . Gui(s:group)
endfor
EOF

  assert_line 'ALEErrorSign=DarkRed/White'
  assert_line 'CocErrorSign=DarkRed/White'
  assert_line 'DiagnosticError=DarkRed/White'
  assert_line 'ALEWarningSign=Gold/Black'
  assert_line 'CocWarningSign=Gold/Black'
  assert_line 'DiagnosticWarning=Gold/Black'
  assert_line 'ALEInfoSign=RoyalBlue/White'
  assert_line 'CocInfoSign=RoyalBlue/White'
  assert_line 'DiagnosticInfo=RoyalBlue/White'
  assert_line 'CocHintSign=LightGrey/Black'
}

