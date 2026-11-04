# The throwaway git fixture the submodule scripts' tests share: a source
# repository with one empty commit, bare clones of it standing in for
# plugin remotes, and a superproject to run the script in, all inside the
# per-test temp directory. Git reads no global or system configuration, so
# a repository it creates starts on master unless told otherwise.

#-----------------------------------------------------------------------------
# git_fixture [BRANCH] - isolate git, create the source repository on BRANCH
# (git's default without one) and an empty superproject at $repo, and cd
# into it. Call from setup.
git_fixture() {
  export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
  export GIT_AUTHOR_NAME=test GIT_AUTHOR_EMAIL=test@example.invalid
  export GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@example.invalid

  # A local path as a submodule URL needs the file transport allowed.
  export GIT_CONFIG_COUNT=1
  export GIT_CONFIG_KEY_0=protocol.file.allow GIT_CONFIG_VALUE_0=always

  git init -q ${1:+-b "$1"} "$BATS_TEST_TMPDIR/src"
  git -C "$BATS_TEST_TMPDIR/src" commit -q --allow-empty -m init

  repo="$BATS_TEST_TMPDIR/repo"
  git init -q "$repo"
  cd "$repo" || return 1
}

#-----------------------------------------------------------------------------
# bare_remote NAME - clone the source repository bare to
# $BATS_TEST_TMPDIR/remotes/NAME.git and print that path.
bare_remote() {
  local remote="$BATS_TEST_TMPDIR/remotes/$1.git"

  git clone -q --bare "$BATS_TEST_TMPDIR/src" "$remote"
  echo "$remote"
}
