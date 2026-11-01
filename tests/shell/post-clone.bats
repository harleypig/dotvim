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
# stub_failing NAME - an executable on the test PATH that fails.
stub_failing() {
  printf '#!/bin/sh\nexit 1\n' > "$stubs/$1"
  chmod +x "$stubs/$1"
}

#-----------------------------------------------------------------------------
# stub_apt - apt-get and dpkg, with every system package already installed.
stub_apt() {
  stub apt-get
  stub dpkg
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
  assert_failure

  # The system packages are the lines between the "Could not detect" warning
  # and the next section heading.
  local listed dupes
  listed=$(awk '/Could not detect package manager/ { on = 1; next }
    /==>/ { on = 0 }
    on && /- / { print $NF }' <<< "$output")
  [[ -n $listed ]] || fail 'no system packages listed'

  dupes=$(sort <<< "$listed" | uniq -d)
  [[ -z $dupes ]] || fail "listed more than once: $dupes"
}

@test "does not claim npm installed when the install failed" {
  post_clone
  assert_output --partial 'npm installation failed'
  refute_output --partial 'npm installed successfully'
}

@test "reports npm installed once when nvm installs it" {
  cat > "$BATS_TEST_TMPDIR/config/shell-startup/nodejs" << NODEJS
nvm() { printf '#!/bin/sh\\n' > "$stubs/npm"; chmod +x "$stubs/npm"; }
NODEJS
  ln -s "$(type -P chmod)" "$stubs/chmod"
  stub_apt
  post_clone
  assert_success
  refute_output --partial 'npm installation failed'

  local said
  said=$(grep -c 'npm installed successfully' <<< "$output")
  assert_equal "$said" 1
}

@test "reports success and exits zero when every step succeeds" {
  stub npm
  stub_apt
  post_clone
  assert_success
  assert_output --partial 'Setup completed successfully!'
  assert_output --partial 'All required packages have been installed.'
}

@test "does not report success when an npm package fails to install" {
  # npm list says nothing is installed, and npm install fails.
  stub_failing npm
  stub_apt
  post_clone
  assert_failure
  refute_output --partial 'Setup completed successfully!'
  refute_output --partial 'All required packages have been installed.'
  assert_output --partial 'npm package: yarn'
}

@test "does not report success when the system packages fail to install" {
  stub npm
  stub apt-get
  stub_failing dpkg
  stub_failing sudo
  post_clone
  assert_failure
  refute_output --partial 'Setup completed successfully!'
  assert_output --partial 'system packages: jq'
}

@test "does not report success when no package manager is found" {
  stub npm
  post_clone
  assert_failure
  refute_output --partial 'Setup completed successfully!'
  assert_output --partial 'system packages: no apt-get or dnf found'
}

@test "a missing pipx alone does not fail the setup" {
  stub npm
  stub_apt
  post_clone
  assert_success
  assert_output --partial 'pipx not found'
}

@test "does not report success when the submodules fail to update" {
  stub npm
  stub_apt
  stub_failing git
  post_clone
  assert_failure
  refute_output --partial 'Setup completed successfully!'
  assert_output --partial 'git submodules'
}

@test "does not report success when a pipx package fails to install" {
  stub npm
  stub_apt
  stub_failing pipx
  ln -s "$(type -P grep)" "$stubs/grep"
  post_clone
  assert_failure
  refute_output --partial 'Setup completed successfully!'
  assert_output --partial 'pipx package: vint'
}
