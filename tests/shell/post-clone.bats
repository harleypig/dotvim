#!/usr/bin/env bats

# bin/post-clone updates submodules, reaches the network and installs
# packages through sudo, so every test runs it with PATH holding only stubs:
# git and curl do nothing, and neither apt-get nor dnf is present, which
# makes the script list the system packages instead of installing them.
# XDG_CONFIG_HOME points at a temp directory, where nvm's installer would
# put nvm, holding an nvm.sh that defines an nvm that installs nothing.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  script="$BATS_TEST_DIRNAME/../../bin/post-clone"
  stubs="$BATS_TEST_TMPDIR/bin"
  calls="$BATS_TEST_TMPDIR/calls"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/config/nvm"

  ln -s "$(type -P bash)" "$stubs/bash"

  local tool
  for tool in curl git; do
    printf '#!/bin/sh\nexit 0\n' > "$stubs/$tool"
    chmod +x "$stubs/$tool"
  done

  printf 'nvm() { :; }\n' > "$BATS_TEST_TMPDIR/config/nvm/nvm.sh"

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
# stub_apt - apt-get and dpkg-query, with every system package already
# installed.
stub_apt() {
  stub apt-get
  printf '#!/bin/sh\necho "install ok installed"\n' > "$stubs/dpkg-query"
  chmod +x "$stubs/dpkg-query"
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
  run env -u NVM_DIR PATH="$stubs" HOME="$BATS_TEST_TMPDIR" \
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
  cat > "$BATS_TEST_TMPDIR/config/nvm/nvm.sh" << NVM
nvm() { printf '#!/bin/sh\\n' > "$stubs/npm"; chmod +x "$stubs/npm"; }
NVM
  ln -s "$(type -P chmod)" "$stubs/chmod"
  stub_apt
  post_clone
  assert_success
  refute_output --partial 'npm installation failed'

  local said
  said=$(grep -c 'npm installed successfully' <<< "$output")
  assert_equal "$said" 1
}

@test "loads nvm from NVM_DIR when it is set" {
  mkdir -p "$BATS_TEST_TMPDIR/elsewhere"
  mv "$BATS_TEST_TMPDIR/config/nvm/nvm.sh" "$BATS_TEST_TMPDIR/elsewhere"
  printf 'nvm() { echo "nvm $*" >> "%s"; }\n' "$calls" \
    > "$BATS_TEST_TMPDIR/elsewhere/nvm.sh"
  stub_apt
  run env NVM_DIR="$BATS_TEST_TMPDIR/elsewhere" PATH="$stubs" \
    HOME="$BATS_TEST_TMPDIR" XDG_CONFIG_HOME="$BATS_TEST_TMPDIR/config" \
    "$script"
  called '^nvm install --lts$'
}

@test "loads nvm from ~/.nvm when XDG_CONFIG_HOME is unset" {
  mkdir -p "$BATS_TEST_TMPDIR/.nvm"
  printf 'nvm() { echo "nvm $*" >> "%s"; }\n' "$calls" \
    > "$BATS_TEST_TMPDIR/.nvm/nvm.sh"
  stub_apt
  run env -u NVM_DIR -u XDG_CONFIG_HOME PATH="$stubs" \
    HOME="$BATS_TEST_TMPDIR" "$script"
  called '^nvm install --lts$'
}

@test "reports a missing nvm.sh as a failure, without a shell error" {
  rm "$BATS_TEST_TMPDIR/config/nvm/nvm.sh"
  stub_apt
  post_clone
  assert_failure
  assert_output --partial "nvm.sh"
  refute_output --partial 'No such file'
  refute_output --partial 'command not found'
  assert_output --partial 'npm: Node.js install through nvm'
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
  assert_output --partial 'npm package: prettier'
}

@test "does not report success when the system packages fail to install" {
  stub npm
  stub apt-get
  stub_failing dpkg-query
  stub_failing sudo
  post_clone
  assert_failure
  refute_output --partial 'Setup completed successfully!'
  assert_output --partial 'system packages: gawk jq'
}

@test "does not report success when dnf fails to install" {
  stub npm
  stub dnf
  stub_failing rpm
  stub_failing sudo
  post_clone
  assert_failure
  refute_output --partial 'Setup completed successfully!'
  assert_output --partial 'system packages: gawk jq'
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
  assert_output --partial 'Skipped: ansible yamllint ansible-lint proselint vint isort yapf flake8 sqlparse'
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
  # npm list -g succeeds for prettier alone, so prettier is skipped.
  recorder npm 'case "$1 $3" in "list prettier") exit 0 ;; list*) exit 1 ;; esac'
  stub_apt
  post_clone
  assert_output --partial 'prettier is already installed'
  not_called '^npm install -g prettier$'
  called '^npm install -g markdownlint-cli$'
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
  recorder dpkg-query '[ "$3" = jq ] && echo "install ok installed"'
  recorder sudo
  post_clone
  assert_output --partial 'jq is already installed'
  called '^sudo apt-get install -y '
  not_called '^sudo apt-get install .* jq( |$)'
  called '^sudo apt-get install -y .*shellcheck'
}

@test "asks no package manager for terraform, which neither apt nor dnf carries" {
  stub npm
  stub apt-get
  stub_failing dpkg-query
  recorder sudo
  post_clone
  called '^sudo apt-get install -y '
  not_called '^sudo apt-get install .*terraform'
}

@test "apt-get installs a package that was removed but left its configuration" {
  # dpkg -l lists such a package, and exits zero, though it is not
  # installed; only its status says so.
  stub npm
  stub apt-get
  stub dpkg
  recorder dpkg-query 'if [ "$3" = jq ]; then echo "deinstall ok config-files"
else echo "install ok installed"; fi'
  recorder sudo
  post_clone
  refute_output --partial 'jq is already installed'
  called '^sudo apt-get install -y jq$'
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

@test "a pipx package whose name prefixes an installed one is still installed" {
  pipx_lists ansible-core
  ln -s "$(type -P grep)" "$stubs/grep"
  stub npm
  stub_apt
  post_clone
  refute_output --partial 'ansible is already installed'
  called '^pipx install ansible --include-deps$'
}

@test "installs the linters and fixers the settings configure, and no others" {
  recorder npm '[ "$1" != list ]'
  pipx_lists
  ln -s "$(type -P grep)" "$stubs/grep"
  stub apt-get
  stub_failing dpkg-query
  recorder sudo
  post_clone

  local tool
  for tool in markdownlint-cli prettier; do
    called "^npm install -g $tool\$"
  done

  for tool in ansible ansible-lint flake8 isort proselint sqlparse vint \
    yamllint yapf; do
    called "^pipx install $tool --include-deps\$"
  done

  for tool in gawk jq shellcheck shfmt; do
    called "^sudo apt-get install -y( .*)? $tool( |\$)"
  done

  # Bundled by the CoC extension that uses it, or used by nothing configured.
  for tool in @ansible/ansible-language-server bash-language-server \
    diagnostic-languageserver dockerfile-language-server-nodejs eslint \
    pyright vim-language-server yarn; do
    not_called "^npm install -g $tool\$"
  done

  not_called '^sudo apt-get install .*packer'
}

@test "names the configured tools no package manager installs" {
  stub npm
  stub_apt
  post_clone

  local tool
  for tool in hadolint sqlint terraform terraform-ls tflint; do
    assert_output --partial "- $tool:"
  done
}

@test "prints the failure heading in red" {
  stub npm
  post_clone
  assert_failure
  assert_output --partial $'\033[0;31mSetup did not complete'
}

@test "prints the missing-pipx heading in yellow" {
  stub npm
  stub_apt
  post_clone
  assert_success
  assert_output --partial $'\033[0;33mSetup completed, but pipx was not found'
}
