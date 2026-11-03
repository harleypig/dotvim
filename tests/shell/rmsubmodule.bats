#!/usr/bin/env bats

# bin/rmsubmodule removes and commits a git submodule, so every test runs it
# inside a throwaway repository in the per-test temp directory, holding
# submodules cloned from a local bare repository. Git reads no global or
# system configuration.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/git-fixture

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  script="$BATS_TEST_DIRNAME/../../bin/rmsubmodule"
  stubs="$BATS_TEST_TMPDIR/bin"
  mkdir -p "$stubs"

  local tool
  for tool in bash git grep rm sed; do
    ln -s "$(type -P "$tool")" "$stubs/$tool"
  done

  git_fixture
  remote=$(bare_remote surround)
}

#-----------------------------------------------------------------------------
# add_submodule NAME PATH: add and commit a submodule from the bare remote.
add_submodule() {
  git submodule -q add --name "$1" "$remote" "$2"
  git commit -q -m "add $1"
}

#-----------------------------------------------------------------------------
rmsubmodule() {
  run env PATH="$stubs" "$script" "$@"
}

#-----------------------------------------------------------------------------
commits() {
  git rev-list --count HEAD
}

#-----------------------------------------------------------------------------
# assert_gone NAME: nothing of submodule NAME is left in the repository.
assert_gone() {
  [[ -z $(git config -f .gitmodules --get-regexp "^submodule\\.$1\\." \
    2> /dev/null) ]] || fail ".gitmodules still has $1: $(< .gitmodules)"
  [[ ! -e .git/modules/$1 ]] || fail ".git/modules/$1 still exists"
  [[ -z $(git config --local --get-regexp "^submodule\\.$1\\.") ]] \
    || fail ".git/config still has $1"
}

##############################################################################
@test "removes the submodule, its .git/modules entry and its config" {
  add_submodule surround .vim/pack/100-core/start/surround
  [[ -d .git/modules/surround ]] || fail 'fixture has no .git/modules entry'

  rmsubmodule surround
  assert_success

  assert_gone surround
  [[ ! -e .vim/pack/100-core/start/surround ]] || fail 'checkout remains'
  assert_equal "$(commits)" 2
  [[ -z $(git status --porcelain) ]] \
    || fail "uncommitted: $(git status --porcelain)"
}

@test "removes the .git/modules entry of a submodule named unlike its path" {
  add_submodule abolish .vim/pack/100-core/start/vim-abolish
  [[ -d .git/modules/abolish ]] || fail 'fixture has no .git/modules entry'

  rmsubmodule abolish
  assert_success
  assert_gone abolish
  assert_equal "$(commits)" 2
}

@test "leaves another submodule's .git/modules entry alone" {
  # Named so its .git/modules entry matches the basename of abolish's path.
  add_submodule vim-abolish .vim/pack/200-lang/start/other
  add_submodule abolish .vim/pack/100-core/start/vim-abolish

  rmsubmodule abolish
  assert_success
  [[ -d .git/modules/vim-abolish ]] \
    || fail ".git/modules/vim-abolish was removed"
}

@test "succeeds for a submodule that was never initialised" {
  add_submodule surround .vim/pack/100-core/start/surround

  # A fresh clone has the submodule in .gitmodules and nothing in
  # .git/config or .git/modules.
  git clone -q "$repo" "$BATS_TEST_TMPDIR/clone"
  cd "$BATS_TEST_TMPDIR/clone" || return 1
  [[ -z $(git config --local --get-regexp '^submodule\.') ]] \
    || fail 'fixture clone has submodule config'

  rmsubmodule surround
  assert_success
  assert_gone surround
  assert_equal "$(commits)" 2
}

@test "fails without committing for a name not in .gitmodules" {
  add_submodule surround .vim/pack/100-core/start/surround

  rmsubmodule abolish
  assert_failure
  assert_output --partial 'abolish is not a submodule'
  assert_equal "$(commits)" 1
  [[ -d .git/modules/surround ]] || fail 'another submodule was touched'
}

@test "fails without committing when git rm fails" {
  add_submodule surround .vim/pack/100-core/start/surround
  git config -f .gitmodules submodule.ghost.path nowhere
  git commit -q -am 'add a ghost entry'

  rmsubmodule ghost
  assert_failure
  assert_output --partial 'Problem removing ghost'
  assert_equal "$(commits)" 2
}

@test "fails when given no submodule" {
  rmsubmodule
  assert_failure
  assert_output --partial 'Must pass submodule to be removed.'
}
