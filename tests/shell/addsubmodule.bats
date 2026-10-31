#!/usr/bin/env bats

# bin/addsubmodule adds and commits git submodules, so every test runs it
# inside a throwaway repository in the per-test temp directory, with a
# local bare repository standing in for the plugin's URL. Git reads no
# global or system configuration, and mkreadme is a tripwire.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  script="$BATS_TEST_DIRNAME/../../bin/addsubmodule"
  stubs="$BATS_TEST_TMPDIR/bin"
  tripped="$BATS_TEST_TMPDIR/tripped"
  mkdir -p "$stubs"

  local tool
  # git-submodule is a shell script that needs basename, sed and uname.
  for tool in basename bash cat git grep ls sed uname; do
    ln -s "$(type -P "$tool")" "$stubs/$tool"
  done

  printf '#!/bin/sh\necho "mkreadme $*" >> "%s"\n' "$tripped" \
    > "$stubs/mkreadme"
  chmod +x "$stubs/mkreadme"

  export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
  export GIT_AUTHOR_NAME=test GIT_AUTHOR_EMAIL=test@example.invalid
  export GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@example.invalid

  # A local path as a submodule URL needs the file transport allowed.
  export GIT_CONFIG_COUNT=1
  export GIT_CONFIG_KEY_0=protocol.file.allow GIT_CONFIG_VALUE_0=always

  remote="$BATS_TEST_TMPDIR/remotes/Surround.vim.git"
  git init -q "$BATS_TEST_TMPDIR/src"
  git -C "$BATS_TEST_TMPDIR/src" commit -q --allow-empty -m init
  git clone -q --bare "$BATS_TEST_TMPDIR/src" "$remote"

  repo="$BATS_TEST_TMPDIR/repo"
  git init -q "$repo"
  mkdir -p "$repo/.vim/pack/100-core/start"
  git -C "$repo" commit -q --allow-empty -m init

  cd "$repo" || return 1
}

#-----------------------------------------------------------------------------
addsubmodule() {
  run env PATH="$stubs" "$script" "$@"
}

#-----------------------------------------------------------------------------
commits() {
  git rev-list --count HEAD
}

##############################################################################
@test "adds the plugin under the named package and commits it" {
  addsubmodule 100-core "$remote"
  assert_success

  assert_equal \
    "$(git config -f .gitmodules submodule.surround.path)" \
    .vim/pack/100-core/start/surround
  assert_equal "$(git config -f .gitmodules submodule.surround.ignore)" dirty
  assert_equal "$(commits)" 2
  [[ -z $(git status --porcelain) ]] \
    || fail "uncommitted: $(git status --porcelain)"
  [[ ! -e $tripped ]] || fail "unexpected call: $(< "$tripped")"
  [[ ! -e README.md ]] || fail 'README.md was written'
}

@test "skips a plugin already in .gitmodules" {
  addsubmodule 100-core "$remote"
  addsubmodule 100-core "$remote"
  assert_success
  assert_equal "$(commits)" 2
}

@test "fails without committing when the submodule cannot be added" {
  addsubmodule 100-core "$BATS_TEST_TMPDIR/remotes/missing.git"
  assert_failure
  assert_equal "$(commits)" 1
  [[ -z $(git config -f .gitmodules --get-regexp '^submodule\.missing\.' \
    2> /dev/null) ]] || fail ".gitmodules has missing: $(< .gitmodules)"
}

@test "refuses a package that does not exist" {
  addsubmodule core "$remote"
  assert_failure
  assert_output --partial '100-core'
  assert_equal "$(commits)" 1
  [[ ! -e .gitmodules ]] || fail '.gitmodules was written'
}

@test "prints usage and fails when given no URL" {
  addsubmodule 100-core
  assert_failure
  assert_line --index 0 --partial 'Usage: addsubmodule'
  assert_equal "$(commits)" 1
}
