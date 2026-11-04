#!/usr/bin/env bats

# Options the late set.vim sets that are not checked elsewhere: diff uses
# the patience algorithm.
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
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/home"

  ln -s "$(type -P sh)" "$stubs/sh"
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

  timeout 30 env -i \
    HOME="$tmp/home" PATH="$stubs" TERM=dumb \
    XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config" \
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
    XDG_CACHE_HOME="$tmp/cache" \
    "$vim" -N -u "$repo/.vimrc" -es -S "$tmp/report.vim" || true

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
