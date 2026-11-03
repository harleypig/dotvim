#!/usr/bin/env bats

# What the late after/plugin/statusline.vim computes and sets: the warnings
# its YASL_Warnings() returns as a buffer changes, the StatusLine colours
# its mode autocmds set, and the ALE counts YASL_LinterStatus() formats.
# Whether Vim then draws the statusline is Vim's to test.
#
# The harness is the one in coc.bats: headless Vim on this checkout's .vimrc,
# HOME and the XDG directories inside the test's temp directory, and a PATH
# holding only a stub directory.

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
}

#-----------------------------------------------------------------------------
# run_vim - open $file in Vim, run the Vim script read from stdin with its
# messages redirected to $report, and load $report as $output.
run_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  {
    echo "redir! > $report"
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
# Red while the warnings are cached in b: variables nothing clears (#134 -
# warnings never refresh).
@test "the trailing-space warning clears on CursorHold once the space is gone" {
  printf 'text  \n' > "$file"

  run_vim <<'EOF'
echo 'before=' . YASL_Warnings()
%s/\s\+$//
doautocmd CursorHold
echo 'after=' . YASL_Warnings()
EOF

  assert_line 'before=[trailing space]'
  assert_line 'after='
}

#-----------------------------------------------------------------------------
# ALE's fix on save would trim the space this test writes.
@test "the trailing-space warning appears after a write that adds one" {
  printf 'text\n' > "$file"

  run_vim <<'EOF'
let b:ale_fix_on_save = 0
echo 'before=' . YASL_Warnings()
call setline(1, 'text  ')
write
echo 'after=' . YASL_Warnings()
EOF

  assert_line 'before='
  assert_line 'after=[trailing space]'
}

#-----------------------------------------------------------------------------
@test "the indent warning follows the buffer's indenting on CursorHold" {
  printf '\tone\n' > "$file"

  run_vim <<'EOF'
setlocal noexpandtab
echo 'tabs=' . YASL_Warnings()
call append(1, '  two')
doautocmd CursorHold
echo 'mixed=' . YASL_Warnings()
1delete
setlocal expandtab
doautocmd CursorHold
echo 'spaces=' . YASL_Warnings()
EOF

  assert_line 'tabs='
  assert_line 'mixed=[mixed indenting]'
  assert_line 'spaces='
}

#-----------------------------------------------------------------------------
# Red while leaving Insert mode or the command-line window sets the reverse
# of the startup colours (#134 - colours flip after the first Insert).
@test "leaving Insert mode or the command-line window restores startup colours" {
  printf 'text\n' > "$file"

  run_vim <<'EOF'
function! Colors()
  let l:id = hlID('StatusLine')
  return synIDattr(l:id, 'bg', 'cterm') . '/' . synIDattr(l:id, 'fg', 'cterm')
endfunction
let g:startup = Colors()
doautocmd InsertEnter
echo 'insert_differs=' . (Colors() !=# g:startup)
doautocmd InsertLeave
echo 'insert_left=' . (Colors() ==# g:startup)
doautocmd CmdwinEnter
echo 'cmdwin_differs=' . (Colors() !=# g:startup)
doautocmd CmdwinLeave
echo 'cmdwin_left=' . (Colors() ==# g:startup)
EOF

  # Compared, not spelled out: the numbers a colour name maps to depend on
  # the terminal's colour count.
  assert_line 'insert_differs=1'
  assert_line 'insert_left=1'
  assert_line 'cmdwin_differs=1'
  assert_line 'cmdwin_left=1'
}

#-----------------------------------------------------------------------------
# ALE is handed a fixed problem list for the buffer, so this checks only how
# our function adds and formats the counts ALE makes of it.
@test "the ALE counts combine style problems and show in severity order" {
  printf 'text\n' > "$file"

  run_vim <<'EOF'
let s:buf = bufnr('')
let g:ale_buffer_info = {s:buf: {'loclist': []}}
echo 'none=' . YASL_LinterStatus()
let g:ale_buffer_info[s:buf] = {'loclist': [
  \ {'bufnr': s:buf, 'type': 'E'},
  \ {'bufnr': s:buf, 'type': 'E', 'sub_type': 'style'},
  \ {'bufnr': s:buf, 'type': 'W', 'sub_type': 'style'},
  \ {'bufnr': s:buf, 'type': 'W', 'sub_type': 'style'},
  \ {'bufnr': s:buf, 'type': 'I'},
  \ {'bufnr': s:buf, 'type': 'I'},
  \ {'bufnr': s:buf, 'type': 'I'}]}
echo 'some=' . YASL_LinterStatus()
EOF

  assert_line 'none='
  assert_line 'some=[%#DiagnosticError#E2%*%#DiagnosticWarning#W2%*%#DiagnosticInfo#I3%*%#warningmsg#:\qf]'
}
