#!/usr/bin/env bats

# The text the late fold.vim's script-local CustomFoldText() gives a closed
# fold: its first non-blank line, its size and its level. Vim runs headless
# through helpers/vim.bash, whose PATH holds only a shell, so CoC stays off
# and nothing reaches the network.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture
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
echo 'global=' . exists('*CustomFoldText')
echo 'text=[' . foldtextresult(foldclosed(line('$'))) . ']'
echo 'errmsg=' . v:errmsg
redir END
qa!
EOF

  headless_vim -S "$tmp/fold.vim" || true

  run cat "$report"
}

##############################################################################
#-----------------------------------------------------------------------------
@test "a closed fold shows its first line, its size and its level" {
  fold_text % 'first' 'second' 'third' 'fourth'

  assert_line --regexp '^foldtext=<SNR>[0-9]+_CustomFoldText\(\)$'
  assert_line 'global=0'
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
