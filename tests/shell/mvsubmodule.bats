#!/usr/bin/env bats

# bin/mvsubmodule moves and commits a git submodule, so every test runs it
# inside a throwaway repository in the per-test temp directory, holding one
# submodule cloned from a local bare repository. Git reads no global or
# system configuration.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  script="$BATS_TEST_DIRNAME/../../bin/mvsubmodule"
  stubs="$BATS_TEST_TMPDIR/bin"
  mkdir -p "$stubs"

  local tool
  for tool in bash git mkdir; do
    ln -s "$(type -P "$tool")" "$stubs/$tool"
  done

  export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
  export GIT_AUTHOR_NAME=test GIT_AUTHOR_EMAIL=test@example.invalid
  export GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@example.invalid

  # A local path as a submodule URL needs the file transport allowed.
  export GIT_CONFIG_COUNT=1
  export GIT_CONFIG_KEY_0=protocol.file.allow GIT_CONFIG_VALUE_0=always

  remote="$BATS_TEST_TMPDIR/remotes/surround.git"
  git init -q "$BATS_TEST_TMPDIR/src"
  git -C "$BATS_TEST_TMPDIR/src" commit -q --allow-empty -m init
  git clone -q --bare "$BATS_TEST_TMPDIR/src" "$remote"

  repo="$BATS_TEST_TMPDIR/repo"
  git init -q "$repo"
  cd "$repo" || return 1

  git submodule -q add --name surround "$remote" \
    .vim/pack/100-core/start/surround
  git commit -q -m 'add surround'
}

#-----------------------------------------------------------------------------
mvsubmodule() {
  run env PATH="$stubs" "$script" "$@"
}

#-----------------------------------------------------------------------------
commits() {
  git rev-list --count HEAD
}

#-----------------------------------------------------------------------------
path_of() {
  git config -f .gitmodules "submodule.$1.path"
}

##############################################################################
@test "moves the submodule to the named package and commits it" {
  mvsubmodule surround 200-lang
  assert_success

  assert_equal "$(path_of surround)" .vim/pack/200-lang/start/surround
  [[ -e .vim/pack/200-lang/start/surround/.git ]] \
    || fail 'submodule checkout did not move'
  [[ ! -e .vim/pack/100-core/start/surround ]] \
    || fail 'old path still exists'
  assert_equal "$(commits)" 2
  [[ -z $(git status --porcelain) ]] \
    || fail "uncommitted: $(git status --porcelain)"
}

@test "fails without committing for a name not in .gitmodules" {
  mvsubmodule abolish 200-lang
  assert_failure
  assert_output --partial 'abolish not found in .gitmodules'
  assert_equal "$(commits)" 1
}

@test "does nothing for a submodule already in the package" {
  mvsubmodule surround 100-core
  assert_success
  assert_output --partial 'surround is already in'
  assert_equal "$(path_of surround)" .vim/pack/100-core/start/surround
  assert_equal "$(commits)" 1
}

@test "commits nothing when git mv fails" {
  # A file where the submodule would land makes git mv refuse the move.
  mkdir -p .vim/pack/200-lang/start
  echo stray > .vim/pack/200-lang/start/surround

  mvsubmodule surround 200-lang
  assert_failure
  assert_equal "$(path_of surround)" .vim/pack/100-core/start/surround
  assert_equal "$(commits)" 1
  [[ -z $(git diff --cached --name-only) ]] \
    || fail "staged: $(git diff --cached --name-only)"
}

@test "fails without committing when given no package" {
  mvsubmodule surround
  assert_failure
  assert_output --partial 'must pass new path'
  assert_equal "$(commits)" 1
}

@test "fails without committing when given no arguments" {
  mvsubmodule
  assert_failure
  assert_output --partial 'must pass name of submodule'
  assert_equal "$(commits)" 1
}
