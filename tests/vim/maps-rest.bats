#!/usr/bin/env bats

# The late maps.vim mappings maps.bats and quickfix.bats leave out: the
# terminal split, Ctrl-L clearing search highlighting, and ALE's fixer.
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
# The terminal is not started: what it does is Vim's.
@test "<Leader>tt opens a terminal across the bottom, left out of sessions" {
  run_vim <<'EOF'
echo 'tt=' . maparg('<Leader>tt', 'n')
EOF

  assert_line 'tt=:botright terminal ++norestore<CR>'
}

#-----------------------------------------------------------------------------
@test "Ctrl-L clears search highlighting as well as redrawing" {
  run_vim <<'EOF'
call setline(1, 'needle')
let @/ = 'needle'
set hlsearch
echo 'before=' . v:hlsearch
execute "normal \<C-L>"
echo 'after=' . v:hlsearch
echo 'rhs=' . maparg('<C-L>', 'n')
EOF

  assert_line 'before=1'
  assert_line 'after=0'
  assert_line 'rhs=:nohlsearch<CR><C-L>'
}

#-----------------------------------------------------------------------------
@test "<Leader>fb runs ALE's fixers on the buffer" {
  run_vim <<'EOF'
echo 'fb=' . maparg('<Leader>fb', 'n')
echo 'plug=' . !empty(maparg('<Plug>(ale_fix)', 'n'))
EOF

  assert_line 'fb=<Plug>(ale_fix)'
  assert_line 'plug=1'
}
