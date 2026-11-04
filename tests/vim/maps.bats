#!/usr/bin/env bats

# What the late maps.vim maps: the w!! sudo write, with vim-eunuch loaded
# and without it, the one paste-mode toggle, and the editing mappings.
#
# Vim runs headless through helpers/vim.bash.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

maps="$BATS_TEST_DIRNAME/../../.vim/pack/zzz-settings/start/settings/plugin/maps.vim"

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture

  [[ -f $repo/.vim/pack/100-core/start/vim-eunuch/plugin/eunuch.vim ]] \
    || fail "vim-eunuch submodule is not checked out"
}

#-----------------------------------------------------------------------------
# start_vim [VIM ARGS...] - run Vim, then write the mappings the tests
# inspect to $report and load it as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  cat > "$tmp/report.vim" <<EOF
redir! > $report
echo 'errmsg=' . v:errmsg
echo 'eunuch=' . exists('g:loaded_eunuch')
echo 'sudowrite_cmd=' . exists(':SudoWrite')
echo 'sudo_map=' . maparg('w!!', 'c')
echo 'paste_map=' . maparg('<Leader>pp', 'n')
echo 'pastetoggle=' . &pastetoggle
redir END
qa!
EOF

  headless_vim "$@" -S "$tmp/report.vim" || true

  run cat "$report"
}

##############################################################################
#-----------------------------------------------------------------------------
@test "with vim-eunuch loaded, w!! becomes eunuch's :SudoWrite" {
  start_vim

  assert_line 'eunuch=1'
  assert_line 'sudowrite_cmd=2'
  assert_line 'sudo_map=SudoWrite'
}

#-----------------------------------------------------------------------------
# eunuch cannot be kept from loading without changing the packpath, so
# maps.vim is sourced again with its guard variable gone.
@test "without vim-eunuch, w!! writes through sudo tee, keeping the buffer" {
  start_vim -c 'unlet g:loaded_eunuch' -c 'cunmap w!!' -c "source $maps"

  assert_line 'eunuch=0'
  assert_line 'sudo_map=w !sudo tee > /dev/null %'
}

#-----------------------------------------------------------------------------
@test "<Leader>pp is the one paste-mode toggle" {
  start_vim

  assert_line 'errmsg='
  assert_line 'paste_map=:set paste!<CR>'
  assert_line 'pastetoggle='
}

##############################################################################
# The editing mappings merged out of the old misc.vim (#4 - merge or remove
# OLD_FILES). Each is driven through :normal on a scratch buffer, so the test
# sees what the keys do rather than how they are spelled.

#-----------------------------------------------------------------------------
# edit LINE... - fill a buffer with the given lines, run the Ex commands in
# $keys against it, then load the buffer's lines, the cursor position and
# any error as $output: one "line=" per buffer line, then "cursor=LINE,COL"
# and "errmsg=". $keys runs from a file, so it may hold several lines.
edit() {
  local tmp="$BATS_TEST_TMPDIR"
  local list='' line

  for line in "$@"; do
    list+="'$line', "
  done

  cat > "$tmp/edit.vim" <<EOF
call setline(1, [$list])
call cursor(1, 1)
$keys
redir! > $report
for s:l in getline(1, '\$')
  echo 'line=' . s:l
endfor
echo 'cursor=' . line('.') . ',' . col('.')
echo 'errmsg=' . v:errmsg
redir END
qa!
EOF

  headless_vim -S "$tmp/edit.vim" || true

  run cat "$report"
}

#-----------------------------------------------------------------------------
@test "<Leader>O and <Leader>o add a counted number of blank lines" {
  keys='exe "normal 2\\O" | exe "normal 3\\o"'
  edit 'text'

  local i

  for i in 0 1 3 4 5; do
    assert_line --index "$i" 'line='
  done

  assert_line --index 2 'line=text'
  assert_line --index 6 'cursor=3,1'
  assert_line --index 7 'errmsg='
}

#-----------------------------------------------------------------------------
@test "S substitutes across the buffer, typed between the slashes" {
  keys='exe "normal Sa/b\<CR>"'
  edit 'a a' 'xa'

  assert_line --index 0 'line=b b'
  assert_line --index 1 'line=xb'
  assert_line 'errmsg='
}

#-----------------------------------------------------------------------------
@test "<Leader>y turns syntax highlighting off, then on again" {
  keys='syntax on
let s:states = [exists("g:syntax_on")]
exe "normal \\y" | call add(s:states, exists("g:syntax_on"))
exe "normal \\y" | call add(s:states, exists("g:syntax_on"))
call setline(1, string(s:states))'
  edit ''

  assert_line --index 0 'line=[1, 0, 1]'
  assert_line 'errmsg='
}

#-----------------------------------------------------------------------------
# 'hidden' is off, so the filled buffer is marked unmodified to let it go.
@test "<Leader>b lists the buffers and prompts for one to open" {
  keys='setlocal nomodified | badd second | exe "normal \\b2\<CR>"
call setline(1, bufname("%"))'
  edit ''

  assert_line --index 0 'line=second'
  assert_line 'errmsg='
}

#-----------------------------------------------------------------------------
@test "Y yanks to the end of the line, like D and C" {
  keys='normal wY
call setline(2, getreg("\""))'
  edit 'one two three' ''

  assert_line --index 1 'line=two three'
}

#-----------------------------------------------------------------------------
# cw leaves the cursor on the last character typed; the repeat puts it back
# on the first.
@test ". repeats the change, leaving the cursor where the change started" {
  keys='exe "normal wcwxyz\<Esc>" | normal j.'
  edit 'aaa bbb' 'aaa bbb'

  assert_line --index 1 'line=aaa bbxyz'
  assert_line 'cursor=2,7'
  assert_line 'errmsg='
}

#-----------------------------------------------------------------------------
# vim-repeat maps . the first time a plugin calls it, unless . already goes
# through its <Plug>(RepeatDot); this checks a surround is still repeated,
# and the mapping still ours, after vim-surround has called it.
@test ". keeps repeating vim-surround's changes, and stays ours" {
  keys='normal ysiw"
normal W.
call setline(2, maparg(".", "n"))'
  edit 'aa bb' ''

  assert_line --index 0 'line="aa" "bb"'
  assert_line --index 1 'line=<Plug>(RepeatDot)`['
  assert_line 'cursor=1,6'
  assert_line 'errmsg='
}

#-----------------------------------------------------------------------------
# vim-repeat cannot be kept from loading without changing the packpath, so
# maps.vim is sourced again with it off the runtimepath and its guard gone.
@test "without vim-repeat, . still repeats and returns to the start" {
  keys="set runtimepath-=$repo/.vim/pack/100-core/start/vim-repeat
unlet g:loaded_repeat
nunmap .
source $maps
"'exe "normal wcwxyz\<Esc>" | normal j.
call setline(3, maparg(".", "n"))'
  edit 'aaa bbb' 'aaa bbb' ''

  assert_line --index 1 'line=aaa bbxyz'
  assert_line --index 2 'line=.`['
  assert_line 'cursor=2,7'
}

#-----------------------------------------------------------------------------
@test "<Leader>ml adds a modeline for the buffer's settings at the top" {
  keys='setlocal ts=8 sw=4 tw=72 noexpandtab commentstring=#\ %s
exe "normal \\ml"'
  edit 'body'

  assert_line --index 0 'line=#  vim: set ts=8 sw=4 tw=72 noet :'
  assert_line --index 1 'line=body'
  assert_line 'errmsg='
}
