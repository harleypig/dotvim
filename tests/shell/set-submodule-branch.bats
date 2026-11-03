#!/usr/bin/env bats

# bin/set-submodule-branch reads each submodule's remote and edits
# .gitmodules, so every test runs it inside a throwaway repository in the
# per-test temp directory, holding submodules cloned from local bare
# repositories whose HEAD is main. Git reads no global or system
# configuration, so a repository it creates starts on master unless told.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/git-fixture

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  script="$BATS_TEST_DIRNAME/../../bin/set-submodule-branch"
  stubs="$BATS_TEST_TMPDIR/bin"
  mkdir -p "$stubs"

  local tool
  for tool in bash cut git grep rev; do
    ln -s "$(type -P "$tool")" "$stubs/$tool"
  done

  git_fixture main
}

#-----------------------------------------------------------------------------
# add_submodule NAME: add and commit submodule NAME from a bare remote of
# its own, then detach its checkout so a later checkout of main shows.
add_submodule() {
  local remote

  remote=$(bare_remote "$1")
  git submodule -q add --name "$1" "$remote" "$(path_of_name "$1")"
  git -C "$(path_of_name "$1")" checkout -q --detach
  git commit -q -m "add $1"
}

#-----------------------------------------------------------------------------
path_of_name() {
  echo ".vim/pack/100-core/start/$1"
}

#-----------------------------------------------------------------------------
set_submodule_branch() {
  run env PATH="$stubs" "$script"
}

#-----------------------------------------------------------------------------
branch_of() {
  git config -f .gitmodules "submodule.$1.branch"
}

#-----------------------------------------------------------------------------
checked_out() {
  git -C "$(path_of_name "$1")" symbolic-ref -q --short HEAD
}

##############################################################################
@test "records and checks out the remote's default branch" {
  add_submodule surround

  set_submodule_branch
  assert_success

  assert_equal "$(branch_of surround)" main
  assert_equal "$(checked_out surround)" main
}

@test "leaves a submodule that already has a branch alone" {
  add_submodule surround
  git config -f .gitmodules submodule.surround.branch x

  set_submodule_branch
  assert_success

  assert_equal "$(git config -f .gitmodules --get-all \
    submodule.surround.branch)" x
  [[ -z $(checked_out surround) ]] || fail 'the submodule was checked out'
}

@test "reports a missing submodule path and carries on" {
  add_submodule abolish
  add_submodule surround
  rm -rf "$(path_of_name abolish)"

  set_submodule_branch
  assert_success
  assert_output --partial 'ignoring abolish'

  [[ -z $(branch_of abolish) ]] || fail 'abolish was given a branch'
  assert_equal "$(branch_of surround)" main
  assert_equal "$(checked_out surround)" main
}

@test "fails when the remote cannot be read" {
  add_submodule surround
  mv "$BATS_TEST_TMPDIR/remotes/surround.git" "$BATS_TEST_TMPDIR/gone.git"

  set_submodule_branch
  assert_failure
  assert_output --partial 'no default branch found for surround'
  [[ -z $(branch_of surround) ]] || fail 'a branch was recorded'
}

@test "fails when the remote's HEAD names no branch" {
  add_submodule surround
  git -C "$BATS_TEST_TMPDIR/remotes/surround.git" \
    symbolic-ref HEAD refs/heads/nothing

  set_submodule_branch
  assert_failure
  assert_output --partial 'no default branch found for surround'
  [[ -z $(branch_of surround) ]] || fail 'a branch was recorded'
}
