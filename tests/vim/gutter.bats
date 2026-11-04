#!/usr/bin/env bats

# What the late gutter.vim sets at startup, and the sign-column toggle's
# branch that tidy.bats does not reach: with line numbers off, the signs
# come back in a column of their own rather than in the number column.
# tidy.bats checks both toggles' mappings, the line-number cycle, and the
# sign toggle with numbers on.
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
# Vim's own SignColumn has a grey background; ours has none.
@test "at startup: a sign column, narrow line numbers, no sign background" {
  run_vim <<'EOF'
echo 'signcolumn=' . &signcolumn
echo 'number=' . &number
echo 'numberwidth=' . &numberwidth
let s:id = synIDtrans(hlID('SignColumn'))
echo 'background=' . synIDattr(s:id, 'bg', 'gui') . '/' . synIDattr(s:id, 'bg', 'cterm')
EOF

  assert_line 'signcolumn=yes'
  assert_line 'number=1'
  assert_line 'numberwidth=1'
  assert_line 'background=/'
}

#-----------------------------------------------------------------------------
@test "with line numbers off, <Leader>signs brings back a column of its own" {
  run_vim <<'EOF'
set nonumber norelativenumber
execute "normal \\signs"
echo 'hidden=' . &signcolumn
execute "normal \\signs"
echo 'shown=' . &signcolumn
EOF

  assert_line 'hidden=no'
  assert_line 'shown=yes'
}

#-----------------------------------------------------------------------------
@test "with only relative numbers on, <Leader>signs uses the number column" {
  run_vim <<'EOF'
set nonumber relativenumber signcolumn=no
execute "normal \\signs"
echo 'shown=' . &signcolumn
EOF

  assert_line 'shown=number'
}

#-----------------------------------------------------------------------------
@test "<Leader>signs hides signs shown in the number column" {
  run_vim <<'EOF'
set signcolumn=number
execute "normal \\signs"
echo 'hidden=' . &signcolumn
EOF

  assert_line 'hidden=no'
}
