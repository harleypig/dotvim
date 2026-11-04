#!/usr/bin/env bats

# The late autoload/quickfixtoggle.vim, and the command and mappings
# maps.vim gives it and the quickfix list: the toggle opens the quickfix
# window and leaves the cursor where it was, closes it when it is open, and
# is not fooled by a location list; <Leader>q] and <Leader>q[ step through
# the list.
#
# Vim runs headless through helpers/vim.bash.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture
}

#-----------------------------------------------------------------------------
# run_vim - run Vim, then the Vim script read from stdin with its messages
# redirected to $report, and load $report as $output. The script may call
# Windows(), which reports the open windows, one letter each - q for
# quickfix, l for a location list, w for any other - and the cursor's
# window in upper case.
run_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  {
    echo "redir! > $report"
    cat <<'EOF'
function! Windows() abort
  let l:out = ''
  for l:win in getwininfo()
    let l:kind = l:win.loclist ? 'l' : l:win.quickfix ? 'q' : 'w'
    let l:out .= l:win.winnr == winnr() ? toupper(l:kind) : l:kind
  endfor
  return l:out
endfunction
EOF
    cat
    echo "echo 'errmsg=' . v:errmsg"
    echo 'redir END'
    echo 'qa!'
  } > "$tmp/test.vim"

  headless_vim -S "$tmp/test.vim" || true

  run cat "$report"

  assert_line 'errmsg='
}

##############################################################################
#-----------------------------------------------------------------------------
@test "the toggle opens quickfix and leaves the cursor in its window" {
  run_vim <<'EOF'
echo 'before=' . Windows()
call quickfixtoggle#toggle()
echo 'after=' . Windows()
EOF

  assert_line 'before=W'
  assert_line 'after=Wq'
}

#-----------------------------------------------------------------------------
# From the lower of two windows, so a toggle that always went back to the
# first window would be caught.
@test "the toggle returns to whichever window it was called from" {
  run_vim <<'EOF'
split
wincmd j
echo 'before=' . Windows()
call quickfixtoggle#toggle()
echo 'after=' . Windows()
EOF

  assert_line 'before=wW'
  assert_line 'after=wWq'
}

#-----------------------------------------------------------------------------
@test "a second toggle closes the quickfix window" {
  run_vim <<'EOF'
call quickfixtoggle#toggle()
call quickfixtoggle#toggle()
echo 'after=' . Windows()
EOF

  assert_line 'after=W'
}

#-----------------------------------------------------------------------------
# A location list window is a quickfix window to getwininfo(), with loclist
# set as well, so the toggle must not read it as the quickfix list.
@test "with only a location list open, the toggle opens quickfix" {
  run_vim <<'EOF'
call setloclist(0, [{'filename': 'a', 'lnum': 1, 'text': 'x'}])
lopen
wincmd p
echo 'before=' . Windows()
call quickfixtoggle#toggle()
echo 'after=' . Windows()
call quickfixtoggle#toggle()
echo 'closed=' . Windows()
EOF

  assert_line 'before=Wl'
  assert_line --regexp '^after=(Wlq|Wql)$'
  assert_line 'closed=Wl'
}

#-----------------------------------------------------------------------------
@test ":QuickfixToggle and <Leader>qf both toggle the quickfix window" {
  run_vim <<'EOF'
QuickfixToggle
echo 'command=' . Windows()
QuickfixToggle
execute "normal \\qf"
echo 'mapping=' . Windows()
execute "normal \\qf"
echo 'closed=' . Windows()
echo 'noremap=' . maparg('<Leader>qf', 'n', 0, 1).noremap
EOF

  assert_line 'noremap=1'
  assert_line 'command=Wq'
  assert_line 'mapping=Wq'
  assert_line 'closed=W'
}

#-----------------------------------------------------------------------------
@test "<Leader>q] and <Leader>q[ step forward and back through quickfix" {
  run_vim <<'EOF'
call setqflist(map(range(1, 3),
  \ {_, n -> {'bufnr': bufnr(''), 'lnum': n, 'text': 'entry ' . n}}))
call setline(1, ['one', 'two', 'three'])
cfirst
execute "normal \\q]"
echo 'next=' . getqflist({'idx': 0}).idx
execute "normal \\q]"
execute "normal \\q["
echo 'previous=' . getqflist({'idx': 0}).idx
echo 'noremap=' . maparg('<Leader>q]', 'n', 0, 1).noremap
  \ . maparg('<Leader>q[', 'n', 0, 1).noremap
EOF

  assert_line 'next=2'
  assert_line 'previous=2'
  assert_line 'noremap=11'
}
