#!/usr/bin/env bats

# What the late xdg-settings.vim does beyond where it points Vim, which
# xdg.bats checks: at startup it deletes backup, undo, swap and view files
# older than 90 days and a viminfo older than 180, and leaves everything
# else alone; and it sets how backups and viminfo are kept.
#
# Each test ages its files with touch before Vim starts and checks them
# while Vim is still running, since Vim writes a fresh viminfo as it exits.
#
# Vim runs headless through helpers/vim.bash.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture

  state="$BATS_TEST_TMPDIR/state/vim"
}

#-----------------------------------------------------------------------------
# aged DAYS PATH... - create each PATH, and its directory, last modified
# DAYS days ago.
aged() {
  local days=$1 path
  shift

  for path in "$@"; do
    mkdir -p "${path%/*}"
    touch -d "$days days ago" "$path"
  done
}

#-----------------------------------------------------------------------------
# start_vim PATH... - run Vim, and write to $report, while it runs, which of
# PATH exist, as kept=PATH or gone=PATH, then each option the tests read;
# load $report as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR" path

  {
    echo "redir! > $report"
    echo "echo 'errmsg=' . v:errmsg"

    for path in "$@"; do
      echo "echo (filereadable('$path') ? 'kept=' : 'gone=') . '$path'"
    done

    echo "echo 'backup=' . &backup"
    echo "echo 'writebackup=' . &writebackup"
    echo "echo 'viminfo=' . &viminfo"
    echo 'redir END'
    echo 'qa!'
  } > "$tmp/report.vim"

  headless_vim -S "$tmp/report.vim" || true

  run cat "$report"

  assert_line 'errmsg='
}

##############################################################################
#-----------------------------------------------------------------------------
@test "backup, undo, swap and view files over 90 days old are deleted" {
  local dir old=() new=()

  for dir in backup undo swap view; do
    old+=("$state/$dir/old")
    new+=("$state/$dir/new")
  done

  aged 100 "${old[@]}"
  aged 10 "${new[@]}"

  start_vim "${old[@]}" "${new[@]}"

  for dir in backup undo swap view; do
    assert_line "gone=$state/$dir/old"
    assert_line "kept=$state/$dir/new"
  done
}

#-----------------------------------------------------------------------------
@test "a viminfo over 180 days old is deleted at startup" {
  aged 200 "$state/viminfo"

  start_vim "$state/viminfo"

  assert_line "gone=$state/viminfo"
}

#-----------------------------------------------------------------------------
# 100 days is past the other directories' limit, so this fails if viminfo is
# given theirs.
@test "a viminfo under 180 days old is kept" {
  aged 100 "$state/viminfo"

  start_vim "$state/viminfo"

  assert_line "kept=$state/viminfo"
}

#-----------------------------------------------------------------------------
@test "old files anywhere else under the state directory are left alone" {
  aged 200 "$state/other/old" "$state/old" "$state/backup/sub/old"

  start_vim "$state/other/old" "$state/old" "$state/backup/sub/old"

  assert_line "kept=$state/other/old"
  assert_line "kept=$state/old"
  assert_line "kept=$state/backup/sub/old"
}

#-----------------------------------------------------------------------------
# A backup is made while writing and deleted after; viminfo keeps 10
# buffers, 50 files' marks, items up to 1000 KiB, and 1000 search and
# command-line history entries.
@test "backups last only while writing; viminfo keeps what it is told to" {
  start_vim

  assert_line 'backup=0'
  assert_line 'writebackup=1'
  assert_line "viminfo=%10,'50,s1000,/1000,:1000"
}
