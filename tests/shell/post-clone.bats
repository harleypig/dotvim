#!/usr/bin/env bats

# bin/post-clone updates submodules, reaches the network and installs
# packages through sudo, so every test runs it with PATH holding only stubs:
# git and curl do nothing, and neither apt-get nor dnf is present, which
# makes the script list the system packages instead of installing them.
# XDG_CONFIG_HOME points at a temp directory whose nodejs startup file
# defines an nvm that installs nothing.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  script="$BATS_TEST_DIRNAME/../../bin/post-clone"
  stubs="$BATS_TEST_TMPDIR/bin"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/config/shell-startup"

  ln -s "$(type -P bash)" "$stubs/bash"

  local tool
  for tool in curl git; do
    printf '#!/bin/sh\nexit 0\n' > "$stubs/$tool"
    chmod +x "$stubs/$tool"
  done

  printf 'nvm() { :; }\n' > "$BATS_TEST_TMPDIR/config/shell-startup/nodejs"

  cd "$BATS_TEST_TMPDIR" || return 1
}

#-----------------------------------------------------------------------------
# stub NAME - an executable on the test PATH that succeeds and does nothing.
stub() {
  printf '#!/bin/sh\nexit 0\n' > "$stubs/$1"
  chmod +x "$stubs/$1"
}

#-----------------------------------------------------------------------------
post_clone() {
  run env PATH="$stubs" HOME="$BATS_TEST_TMPDIR" \
    XDG_CONFIG_HOME="$BATS_TEST_TMPDIR/config" "$script"
}

##############################################################################
@test "lists each system package once" {
  stub npm
  post_clone
  assert_success

  local packer
  packer=$(grep -c -- '- packer$' <<< "$output")
  assert_equal "$packer" 1
}

@test "does not claim npm installed when the install failed" {
  post_clone
  assert_output --partial 'npm installation failed'
  refute_output --partial 'npm installed successfully'
}
