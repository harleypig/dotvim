#!/usr/bin/env bats

# Every script in bin/ answers -h and --help with usage text and does
# nothing else. Several of them change git submodules, install packages or
# reach the network, so each runs with PATH holding only a few harmless
# real tools and tripwire stubs for the rest: a tripwire that fires means
# the script went on to do its real work.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  bindir="$BATS_TEST_DIRNAME/../../bin"
  stubs="$BATS_TEST_TMPDIR/bin"
  tripped="$BATS_TEST_TMPDIR/tripped"
  mkdir -p "$stubs"

  local tool
  for tool in bash cat fold head tr; do
    ln -s "$(type -P "$tool")" "$stubs/$tool"
  done

  for tool in apt-get curl cut dnf dpkg git grep jq mkdir mkreadme npm \
    perl pip pipx python3 rev rm rpm sed sudo; do
    printf '#!/bin/sh\necho "%s $*" >> "%s"\n' "$tool" "$tripped" \
      > "$stubs/$tool"
    chmod +x "$stubs/$tool"
  done

  cd "$BATS_TEST_TMPDIR" || return 1
}

#-----------------------------------------------------------------------------
# assert_help SCRIPT - both help flags print the same usage text, exit 0,
# and touch none of the tripwires.
assert_help() {
  local flag first=

  for flag in -h --help; do
    run env PATH="$stubs" "$bindir/$1" "$flag"
    assert_success
    assert_line --index 0 --partial "Usage: $1"
    refute_output --partial 'command not found'
    [[ -z $first ]] && first="$output"
    assert_equal "$output" "$first"
  done

  [[ ! -e $tripped ]] || fail "help ran real work: $(< "$tripped")"
}

##############################################################################
@test "addsubmodule has help" { assert_help addsubmodule; }
@test "check-setup has help" { assert_help check-setup; }
@test "dump-maps has help" { assert_help dump-maps; }
@test "envsubstitute has help" { assert_help envsubstitute; }
@test "mvsubmodule has help" { assert_help mvsubmodule; }
@test "post-clone has help" { assert_help post-clone; }
@test "rmsubmodule has help" { assert_help rmsubmodule; }
@test "set-submodule-branch has help" { assert_help set-submodule-branch; }
@test "update-coc-extensions has help" { assert_help update-coc-extensions; }

@test "every script in bin/ has a help test" {
  local script

  for script in "$bindir"/*; do
    grep -q "assert_help ${script##*/};" "$BATS_TEST_FILENAME" \
      || fail "no help test for ${script##*/}"
  done
}
