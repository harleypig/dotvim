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
  calls="$BATS_TEST_TMPDIR/calls"
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
# recorder NAME [BODY] - an executable on the test PATH that appends its name
# and arguments to $calls, one call per line, then runs BODY (sh), which
# defaults to succeeding.
recorder() {
  printf '#!/bin/sh\necho "%s $*" >> "%s"\n%s\n' "$1" "$calls" "${2:-exit 0}" \
    > "$stubs/$1"
  chmod +x "$stubs/$1"
}

#-----------------------------------------------------------------------------
# called PATTERN - assert some recorded call matches the extended regex.
called() {
  grep -Eq -- "$1" "$calls" \
    || fail "no call matches '$1'; calls were:"$'\n'"$(cat "$calls" 2> /dev/null)"
}

#-----------------------------------------------------------------------------
# not_called PATTERN - assert no recorded call matches the extended regex.
not_called() {
  ! grep -Eq -- "$1" "$calls" 2> /dev/null \
    || fail "unexpected call matching '$1':"$'\n'"$(grep -E -- "$1" "$calls")"
}

#-----------------------------------------------------------------------------
# pipx_lists NAME... - a recording pipx whose list holds these packages, in
# the format pipx itself prints for plain `list` and for `list --short`.
pipx_lists() {
  local name long= short=

  for name in "$@"; do
    long+="   package $name 1.0, installed using Python 3.12\\n"
    short+="$name 1.0\\n"
  done

  recorder pipx "[ \"\$1\" = list ] || exit 0
if [ \"\$2\" = --short ]; then printf '$short'; else printf '$long'; fi"
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
  stub_apt
  post_clone
  assert_failure
  assert_output --partial 'npm installation failed'
  refute_output --partial 'npm installed successfully'
  refute_output --partial 'Setup completed successfully!'
  assert_output --partial 'npm: Node.js install through nvm'
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
  stub pipx
  ln -s "$(type -P grep)" "$stubs/grep"
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

@test "does not report success when dnf fails to install" {
  stub npm
  stub dnf
  stub_failing rpm
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
  assert_output --partial 'Setup completed, but pipx was not found'
  assert_output --partial 'Skipped: ansible proselint vint isort flake8'
  refute_output --partial 'Setup completed successfully!'
  refute_output --partial 'All required packages have been installed.'
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

@test "updates the submodules recursively to their remote branches" {
  recorder git
  stub npm
  stub_apt
  post_clone
  called '^git submodule update --init --recursive --remote$'
}

@test "installs only the npm packages npm does not already list" {
  # npm list -g succeeds for pyright alone, so pyright is skipped.
  recorder npm 'case "$1 $3" in "list pyright") exit 0 ;; list*) exit 1 ;; esac'
  stub_apt
  post_clone
  assert_output --partial 'pyright is already installed'
  not_called '^npm install -g pyright$'
  called '^npm install -g vim-language-server$'
}

@test "installs only the pipx packages pipx does not already list" {
  pipx_lists vint
  ln -s "$(type -P grep)" "$stubs/grep"
  stub npm
  stub_apt
  post_clone
  assert_output --partial 'vint is already installed'
  not_called '^pipx install vint '
  called '^pipx install flake8 --include-deps$'
}

@test "apt-get installs the missing system packages and not the present ones" {
  stub npm
  stub apt-get
  recorder dpkg '[ "$2" = jq ]'
  recorder sudo
  post_clone
  assert_output --partial 'jq is already installed'
  called '^sudo apt-get install -y '
  not_called '^sudo apt-get install .* jq( |$)'
  called '^sudo apt-get install -y .*shellcheck'
  called '^sudo apt-get install -y .*terraform-ls'
}

@test "dnf installs the missing system packages and not the present ones" {
  stub npm
  stub dnf
  recorder rpm '[ "$2" = jq ]'
  recorder sudo
  post_clone
  assert_output --partial 'jq is already installed'
  called '^sudo dnf install -y '
  not_called '^sudo dnf install .* jq( |$)'
  called '^sudo dnf install -y .*shellcheck'
}

@test "calls no package manager when every system package is present" {
  stub npm
  stub_apt
  recorder sudo
  post_clone
  assert_output --partial 'All system packages are already installed'
  not_called '^sudo '
}
