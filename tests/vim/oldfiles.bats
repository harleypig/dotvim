#!/usr/bin/env bats

# Settings merged out of OLD_FILES/ into the late settings (#4 - merge or
# remove OLD_FILES). The harness is the one in coc.bats and load.bats:
# headless Vim on this checkout's .vimrc, HOME and the XDG directories inside
# the test's temp directory, and a PATH holding only a shell, so CoC stays
# off and nothing reaches the network.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  repo="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  stubs="$BATS_TEST_TMPDIR/bin"
  report="$BATS_TEST_TMPDIR/report"
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/home"

  ln -s "$(type -P sh)" "$stubs/sh"
}

#-----------------------------------------------------------------------------
# fold_text RANGE LINE... - fill a buffer with the given lines, fold RANGE
# of them into one manual fold, and load the text Vim shows for the closed
# fold as $output, along with the 'foldtext' option and any error.
fold_text() {
  local tmp="$BATS_TEST_TMPDIR"
  local range=$1 list='' line
  shift

  for line in "$@"; do
    list+="'$line', "
  done

  cat > "$tmp/fold.vim" <<EOF
call setline(1, [$list])
setlocal foldmethod=manual nonumber
${range}fold
redir! > $report
echo 'foldtext=' . &foldtext
echo 'text=[' . foldtextresult(foldclosed(line('$'))) . ']'
echo 'errmsg=' . v:errmsg
redir END
qa!
EOF

  timeout 30 env -i \
    HOME="$tmp/home" PATH="$stubs" TERM=dumb \
    XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config" \
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
    XDG_CACHE_HOME="$tmp/cache" \
    "$vim" -N -u "$repo/.vimrc" -es -S "$tmp/fold.vim" || true

  run cat "$report"
}

##############################################################################
#-----------------------------------------------------------------------------
@test "a closed fold shows its first line, its size and its level" {
  fold_text % 'first' 'second' 'third' 'fourth'

  assert_line 'foldtext=CustomFoldText()'
  assert_line --regexp '^text=\[first\.+ 4 lines \[100\.0%\] \+--\]$'
  assert_line 'errmsg='
}

#-----------------------------------------------------------------------------
@test "a fold starting with blank lines shows its first non-blank line" {
  fold_text % '' '   ' 'body' 'more'

  assert_line --regexp '^text=\[body\.+ 4 lines '
  assert_line 'errmsg='
}

#-----------------------------------------------------------------------------
# A fold of blank lines has no non-blank line to show, and must not borrow
# one from outside the fold.
@test "a fold of only blank lines shows no text from outside it" {
  fold_text 2,\$ 'outside' '' '' ''

  assert_line --regexp '^text=\[\.+ 3 lines '
  assert_line 'errmsg='
}
