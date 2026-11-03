#!/usr/bin/env bats

# The late settings' after/plugin/helptags.vim builds a doc directory's help
# tags only when they are missing or older than a file beside them, so a
# startup with current tags writes nothing.
#
# Each test works on a doc directory of its own, under the temporary HOME's
# .vim, which Vim's default 'runtimepath' includes. It is created by the test,
# so no tags file from an earlier run can satisfy a check: each test states
# what the directory holds before Vim starts.
#
# The harness is the one in coc.bats: headless Vim on this checkout's .vimrc,
# HOME and the XDG directories inside the test's temp directory, and a PATH
# holding only stubs.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  repo="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  stubs="$BATS_TEST_TMPDIR/bin"
  doc="$BATS_TEST_TMPDIR/home/.vim/doc"
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$doc"

  ln -s "$(type -P sh)" "$stubs/sh"

  printf '*dotvim-demo*\tA help file for the helptags tests.\n' \
    > "$doc/dotvim-demo.txt"
}

#-----------------------------------------------------------------------------
# start_vim - start Vim and quit. Its exit status is left in $vim_status; in
# Ex mode it is non-zero when any command raised an error.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  vim_status=0

  timeout 30 env -i \
    HOME="$tmp/home" PATH="$stubs" TERM=dumb \
    XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config" \
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
    XDG_CACHE_HOME="$tmp/cache" \
    "$vim" -N -u "$repo/.vimrc" -es -c 'qa!' \
    || vim_status=$?
}

#-----------------------------------------------------------------------------
# old_tags - a tags file that helptags would never write, so its surviving a
# startup shows nothing rewrote it.
old_tags() {
  printf 'not-rebuilt\tdotvim-demo.txt\t/*not-rebuilt*\n' > "$doc/tags"
}

##############################################################################
#-----------------------------------------------------------------------------
@test "a doc directory with no tags file gets one at startup" {
  [[ ! -e $doc/tags ]] || fail "the doc directory already has a tags file"

  start_vim

  assert_equal "$vim_status" 0
  run cat "$doc/tags"
  assert_output --partial '/*dotvim-demo*'
}

#-----------------------------------------------------------------------------
@test "tags newer than every doc file are left alone" {
  old_tags
  touch -d '-2 hours' "$doc/dotvim-demo.txt"

  start_vim

  assert_equal "$vim_status" 0
  run cat "$doc/tags"
  assert_output --partial 'not-rebuilt'
}

#-----------------------------------------------------------------------------
@test "tags older than a doc file are rebuilt" {
  old_tags
  touch -d '-2 hours' "$doc/tags"

  start_vim

  assert_equal "$vim_status" 0
  run cat "$doc/tags"
  assert_output --partial '/*dotvim-demo*'
  refute_output --partial 'not-rebuilt'
}
