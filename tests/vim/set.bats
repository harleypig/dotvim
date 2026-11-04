#!/usr/bin/env bats

# Options the late set.vim sets that are not checked elsewhere: diff uses
# the patience algorithm.
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
# start_vim - run Vim, then write the options the tests inspect to $report
# and load it as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  cat > "$tmp/report.vim" <<EOF
redir! > $report
echo 'errmsg=' . v:errmsg
echo 'diffopt=' . &diffopt
redir END
qa!
EOF

  headless_vim -S "$tmp/report.vim" || true

  run cat "$report"
}

##############################################################################
#-----------------------------------------------------------------------------
# Patience matches unique lines first, so a moved or repeated block is less
# often split into a confusing interleave of small hunks.
@test "diff uses the patience algorithm, keeping Vim's other diff options" {
  start_vim

  assert_line 'errmsg='
  assert_line --regexp '^diffopt=(.*,)?algorithm:patience(,.*)?$'
  assert_line --regexp '^diffopt=(.*,)?internal(,.*)?$'
}
