#!/usr/bin/env bats

# What the late help.vim does to a help window: moves it to a vertical split
# on the right, and gives its buffer Enter to follow a link and Ctrl-[ to go
# back. tidy.bats checks that re-sourcing the file adds no autocmds.
#
# The resize to at most 80 columns is not tested: in silent Ex mode every
# window is 80 columns wide or less whatever 'columns' says, so the resize
# never has anything to do.
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
# redirected to $report, and load $report as $output.
run_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  {
    echo "redir! > $report"
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
# Vim's own :help splits horizontally, with the help window on top.
@test "help opens in a vertical split to the right of the other window" {
  run_vim <<'EOF'
help help
echo 'filetype=' . &filetype
echo 'layout=' . winlayout()[0]
echo 'rightmost=' . (winnr() == winnr('$'))
EOF

  assert_line 'filetype=help'
  assert_line 'layout=row'
  assert_line 'rightmost=1'
}

#-----------------------------------------------------------------------------
@test "in a help buffer, Enter follows a link and Ctrl-[ goes back" {
  run_vim <<'EOF'
help help
for s:keys in ['<CR>', '<C-[>']
  let s:map = maparg(s:keys, 'n', 0, 1)
  echo s:keys . '=' . get(s:map, 'rhs', '') . ' buffer=' . get(s:map, 'buffer', 0)
endfor
EOF

  assert_line '<CR>=<C-]> buffer=1'
  assert_line '<C-[>=<C-O> buffer=1'
}

#-----------------------------------------------------------------------------
@test "Enter and Ctrl-[ are left alone outside help buffers" {
  run_vim <<'EOF'
help help
wincmd p
echo 'filetype=' . &filetype
echo '<CR>=' . maparg('<CR>', 'n')
echo '<C-[>=' . maparg('<C-[>', 'n')
EOF

  assert_line 'filetype='
  assert_line '<CR>='
  assert_line '<C-[>='
}
