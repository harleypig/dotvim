#!/usr/bin/env bats

# bin/mvsubmodule moves and commits a git submodule, so every test runs it
# inside a throwaway repository in the per-test temp directory, holding one
# submodule cloned from a local bare repository. Git reads no global or
# system configuration.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/git-fixture

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

  git_fixture
  remote=$(bare_remote surround)

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

@test "says in its commit message only what it did" {
  mvsubmodule surround 200-lang
  assert_success
  assert_equal "$(git log -1 --format=%s)" 'moved surround to 200-lang'
}

@test "moves a submodule in a linked worktree" {
  # A linked worktree's .git is a file, and git keeps the worktree's
  # submodule directories under the main repository's .git/worktrees.
  git worktree add -q "$BATS_TEST_TMPDIR/wt"
  cd "$BATS_TEST_TMPDIR/wt" || return 1
  git submodule -q update --init

  mvsubmodule surround 200-lang
  assert_success
  assert_equal "$(path_of surround)" .vim/pack/200-lang/start/surround
  git -C .vim/pack/200-lang/start/surround rev-parse -q --verify HEAD \
    > /dev/null || fail 'moved submodule is not a working checkout'
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
