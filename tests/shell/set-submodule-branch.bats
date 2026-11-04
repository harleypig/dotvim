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

@test "reports a missing submodule path, carries on, and fails" {
  add_submodule abolish
  add_submodule surround
  rm -rf "$(path_of_name abolish)"

  set_submodule_branch
  assert_failure
  assert_output --partial 'ignoring abolish'

  [[ -z $(branch_of abolish) ]] || fail 'abolish was given a branch'
  assert_equal "$(branch_of surround)" main
  assert_equal "$(checked_out surround)" main
}

@test "commits the branch it records, and nothing else" {
  add_submodule surround
  echo staged > other
  git add other

  set_submodule_branch
  assert_success
  assert_equal "$(git show HEAD:.gitmodules \
    | git config -f - submodule.surround.branch)" main
  [[ -z $(git status --porcelain .gitmodules) ]] \
    || fail ".gitmodules left uncommitted: $(git diff .gitmodules)"
  assert_equal "$(git diff --cached --name-only)" other
}

@test "commits the gitlink the checkout moved, with the branch" {
  add_submodule surround
  # A local main one commit ahead of the recorded one, so checking it out
  # moves the submodule's HEAD and so its gitlink.
  local sub
  sub=$(path_of_name surround)
  git -C "$sub" checkout -q main
  git -C "$sub" commit -q --allow-empty -m ahead
  git -C "$sub" checkout -q --detach HEAD~1

  set_submodule_branch
  assert_success
  assert_equal "$(git rev-parse "HEAD:$sub")" "$(git -C "$sub" rev-parse HEAD)"
  [[ -z $(git status --porcelain "$sub") ]] \
    || fail "gitlink left uncommitted: $(git status --porcelain "$sub")"
}

@test "records no branch when the checkout fails" {
  add_submodule surround
  # With no local or remote-tracking main, git checkout main has nothing to
  # check out, though the remote still names main as its HEAD.
  git -C "$(path_of_name surround)" branch -q -D main
  git -C "$(path_of_name surround)" update-ref -d refs/remotes/origin/main

  set_submodule_branch
  assert_failure
  assert_output --partial 'surround'
  [[ -z $(branch_of surround) ]] || fail 'a branch was recorded'
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
