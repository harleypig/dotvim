#!/usr/bin/env bats

# bin/check-setup decides what to report from what `command -v` finds, so
# every test runs it with PATH pointing only at a per-test stub directory.
# Results never depend on what is installed on the machine running them.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  script="$BATS_TEST_DIRNAME/../../bin/check-setup"
  stubs="$BATS_TEST_TMPDIR/bin"
  mkdir -p "$stubs"

  # Real tools the script itself shells out to.
  local tool
  for tool in grep head sed sort; do
    ln -s "$(type -P "$tool")" "$stubs/$tool"
  done
}

#-----------------------------------------------------------------------------
# stub NAME [OUTPUT] - an executable on the test PATH that prints OUTPUT.
stub() {
  printf '#!/bin/sh\nprintf "%%s\\n" "%s"\n' "${2-}" > "$stubs/$1"
  chmod +x "$stubs/$1"
}

#-----------------------------------------------------------------------------
check_setup() {
  run env PATH="$stubs" "$script"
}

#-----------------------------------------------------------------------------
# on_os NAME - run as though /etc/os-release named NAME.
on_os() {
  printf 'NAME="%s"\n' "$1" > "$BATS_TEST_TMPDIR/os-release"
  export CHECK_SETUP_OS_RELEASE="$BATS_TEST_TMPDIR/os-release"
}

##############################################################################
@test "registers every check without a declare error" {
  check_setup
  refute_output --partial 'cannot convert'
}

@test "reports node missing when it is not on PATH" {
  check_setup
  assert_output --partial 'node not installed:'
}

@test "reports npm missing when node is present without it" {
  stub node v20.0.0
  check_setup
  assert_output --partial 'npm not installed:'
  refute_output --partial 'node not installed:'
}

@test "warns when node is older than CoC requires" {
  stub node v12.0.0
  stub npm
  check_setup
  assert_output --partial 'Node.js version 12.0.0 found'
}

@test "says nothing about node when node and npm are current" {
  stub node v20.0.0
  stub npm
  check_setup
  refute_output --partial 'node'
  refute_output --partial 'npm'
}

@test "reports ansible-lint missing when ansible is present" {
  stub ansible
  check_setup
  assert_output --partial 'ansible-lint not installed:'
  assert_output --partial 'ansible also depends on yamllint'
}

@test "skips the ansible check when ansible is absent" {
  check_setup
  refute_output --partial 'ansible'
}

@test "reports docker linters missing when docker is present" {
  stub docker
  check_setup
  assert_output --partial 'docker_lint not installed:'
  assert_output --partial 'hadolint not installed:'
}

@test "runs every check, in name order" {
  stub ansible
  stub docker
  check_setup
  assert_line --index 0 --partial 'ansible-lint not installed:'
  assert_line --partial 'hadolint not installed:'
  assert_line --index -1 --partial 'node not installed:'
}

@test "names the OS when it knows no package for it" {
  on_os 'Fedora Linux'
  check_setup
  assert_line 'node not installed: no package name known for Fedora Linux'
}

@test "carries no package name over from an earlier check" {
  on_os 'Fedora Linux'
  stub ansible
  check_setup
  assert_line --partial 'ansible-lint not installed:'
  assert_line \
    'ansible-language-server not installed: no package name known for Fedora Linux'
}

@test "still gives the package and command on a known OS" {
  on_os 'Arch Linux'
  stub docker
  check_setup
  assert_line 'hadolint not installed: trizen -S hadolint'
  assert_line 'node not installed: trizen -S nodejs'
}
