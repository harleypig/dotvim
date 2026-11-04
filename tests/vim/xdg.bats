#!/usr/bin/env bats

# Where the XDG settings put Vim's state and data: under XDG_STATE_HOME and
# XDG_DATA_HOME when they are set, and under the XDG defaults,
# ~/.local/state and ~/.local/share, when they are not. Either way Vim
# starts without an error, saves undo history there, and leaves nothing in
# the directory it ran in.
#
# Vim runs headless through helpers/vim.bash, with XDG_STATE_HOME and
# XDG_DATA_HOME set only where a test sets them. It runs in an empty
# directory of its own, so anything it creates there is visible.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture
  vim_env_unset XDG_STATE_HOME XDG_DATA_HOME

  cwd="$BATS_TEST_TMPDIR/cwd"
  mkdir -p "$cwd"
}

#-----------------------------------------------------------------------------
# start_vim [VAR=VALUE...] - run Vim in $cwd with the given XDG variables
# added to its environment, then load what it reports as $output.
# Vim's exit status is left in $vim_status; in Ex mode it is non-zero when
# any command raised an error.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  cat > "$tmp/report.vim" <<EOF
redir! > $report
echo 'errmsg=' . v:errmsg
messages
echo 'backupdir=' . &backupdir
echo 'undodir=' . &undodir
echo 'undofile=' . &undofile
echo 'directory=' . &directory
echo 'viewdir=' . &viewdir
echo 'viminfofile=' . &viminfofile
echo 'netrw_home=' . g:netrw_home
redir END
qa!
EOF

  vim_status=0

  (cd "$cwd" && headless_vim "$@" -- -S "$tmp/report.vim") \
    || vim_status=$?

  run cat "$report"
}

#-----------------------------------------------------------------------------
# assert_xdg_dirs STATE DATA - the settings point into STATE and DATA, the
# directories exist, undo history is saved, and Vim raised nothing and left
# $cwd empty.
assert_xdg_dirs() {
  local state=$1 data=$2

  assert_equal "$vim_status" 0
  assert_line 'errmsg='
  refute_output --partial 'Error detected while processing'
  assert_equal "$(ls -A "$cwd")" ''

  assert_line "backupdir=$state/vim/backup"
  assert_line "undodir=$state/vim/undo"
  assert_line 'undofile=1'
  assert_line "directory=$state/vim/swap"
  assert_line "viewdir=$state/vim/view"
  assert_line "viminfofile=$state/vim/viminfo"
  assert_line "netrw_home=$data/vim"

  for dir in backup undo swap view; do
    assert [ -d "$state/vim/$dir" ]
  done

  assert [ -d "$data/vim/spell" ]
}

##############################################################################
#-----------------------------------------------------------------------------
@test "with XDG_STATE_HOME and XDG_DATA_HOME set, Vim uses them" {
  start_vim XDG_STATE_HOME="$BATS_TEST_TMPDIR/state" \
    XDG_DATA_HOME="$BATS_TEST_TMPDIR/data"

  assert_xdg_dirs "$BATS_TEST_TMPDIR/state" "$BATS_TEST_TMPDIR/data"
}

#-----------------------------------------------------------------------------
@test "with XDG_STATE_HOME and XDG_DATA_HOME unset, Vim uses the defaults" {
  start_vim

  assert_xdg_dirs "$home/.local/state" "$home/.local/share"
}

#-----------------------------------------------------------------------------
# The XDG specification treats a variable set to the empty string as unset.
@test "with XDG_STATE_HOME and XDG_DATA_HOME empty, Vim uses the defaults" {
  start_vim XDG_STATE_HOME= XDG_DATA_HOME=

  assert_xdg_dirs "$home/.local/state" "$home/.local/share"
}
