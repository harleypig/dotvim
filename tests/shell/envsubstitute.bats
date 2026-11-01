#!/usr/bin/env bats

# envsubstitute must finish when it starts with SIGPIPE ignored, as GitHub's
# runners start every step: a pipeline that reads an endless source and
# relies on SIGPIPE to stop it never ends there. Each run is bounded by
# timeout so a hang fails the test instead of stalling the suite.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  script="$BATS_TEST_DIRNAME/../../bin/envsubstitute"
}

#-----------------------------------------------------------------------------
# run_nopipe ARGS... - run envsubstitute with SIGPIPE ignored, for at most
# ten seconds. timeout exits 124 when it has to stop the script.
run_nopipe() {
  run timeout 10 bash -c "trap '' PIPE; exec \"\$@\"" _ "$script" "$@"
}

##############################################################################
@test "help finishes with SIGPIPE ignored" {
  run_nopipe --help
  assert_success
  assert_line --index 0 --partial 'Usage: envsubstitute'
}

@test "substitution finishes with SIGPIPE ignored" {
  export PRJNAME=test123
  run_nopipe '/path/to/%PRJNAME%/'
  assert_success
  assert_output '/path/to/test123/'
}

@test "an unset variable is left as written when warnings are off" {
  unset MISSING
  export NO_WARN=1
  run_nopipe '/path/%MISSING%/%MISSING%/'
  assert_success
  assert_output '/path/%MISSING%/%MISSING%/'
}
