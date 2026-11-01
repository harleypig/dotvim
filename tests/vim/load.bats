#!/usr/bin/env bats

# Every settings file loads without raising an error: the whole config at
# startup, with and without Node.js, then each file under the late settings'
# after/ftplugin directory, one test per file. Each of those files is also
# checked to load only through the filetype plugin mechanism, and the last
# tests check what the ftplugins leave behind for other filetypes.
#
# The harness is the one in coc.bats: headless Vim on this checkout's .vimrc,
# HOME and the XDG directories inside the test's temp directory, and a PATH
# holding only stubs, so each test decides whether node is "installed".

bats_load_library bats-support
bats_load_library bats-assert

ftplugin_dir="$BATS_TEST_DIRNAME/../../.vim/pack/zzz-settings/start/settings/after/ftplugin"

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  repo="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  stubs="$BATS_TEST_TMPDIR/bin"
  tripped="$BATS_TEST_TMPDIR/tripped"
  report="$BATS_TEST_TMPDIR/report"
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/home"

  if git -C "$repo" submodule status | grep -q '^-'; then
    fail "a plugin submodule is not checked out"
  fi

  ln -s "$(type -P sh)" "$stubs/sh"
}

#-----------------------------------------------------------------------------
with_node() {
  printf '#!/bin/sh\necho "node $*" >> "%s"\n' "$tripped" > "$stubs/node"
  chmod +x "$stubs/node"
}

#-----------------------------------------------------------------------------
# start_vim [VIM ARGS...] - run Vim, then write the error message, the
# message history and the scripts it sourced to $report and load it as
# $output. Vim's exit status is left in $vim_status; in Ex mode it is
# non-zero when any command raised an error.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  cat > "$tmp/report.vim" <<EOF
redir! > $report
echo 'errmsg=' . v:errmsg
messages
scriptnames
redir END
qa!
EOF

  vim_status=0

  timeout 30 env -i \
    HOME="$tmp/home" PATH="$stubs" TERM=dumb \
    XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config" \
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
    XDG_CACHE_HOME="$tmp/cache" \
    "$vim" -N -u "$repo/.vimrc" -es "$@" -S "$tmp/report.vim" \
    || vim_status=$?

  run cat "$report"
}

#-----------------------------------------------------------------------------
# The message history names the file and line of every error, so a failure
# here shows which settings file raised it.
#
# v:errmsg is not checked here: an error inside silent! sets it without ever
# reaching the user. Vim 9.1.0016's own syntax/sh.vim does exactly that
# (sil! delc ShFoldIfDoFor), so checking it would fail the sh and bats
# filetypes on Ubuntu 24.04 for a file that is not ours.
assert_no_error_message() {
  refute_output --partial 'Error detected while processing'
  refute_line --regexp '^E[0-9]+:'
}

##############################################################################
#-----------------------------------------------------------------------------
@test "without node, Vim starts with no error message at all" {
  start_vim

  assert_no_error_message
  assert_line 'errmsg='
  assert_equal "$vim_status" 0
}

#-----------------------------------------------------------------------------
@test "with node, Vim starts with no error message at all" {
  with_node
  start_vim --cmd 'let g:coc_start_at_startup = 0'

  assert_no_error_message
  assert_line 'errmsg='
  assert_equal "$vim_status" 0
  refute [ -e "$tripped" ]
}

#-----------------------------------------------------------------------------
# test_ftplugin FILETYPE - set the filetype on an empty buffer and check our
# ftplugin file for it was sourced and raised nothing.
#
# The filetype is set directly rather than through a sample file name: git,
# hcl and terraform have no extension that is theirs alone, and this tests
# our file, not filetype detection.
#
# Startup's errors are cleared first and Vim's exit status is not checked, so
# a broken startup file fails the startup tests above, not every one of
# these.
#
# Our file is then sourced a second time on its own, so v:errmsg can catch
# an error it hides with silent!. Checked after the filetype is set it would
# also hold what Vim's own syntax files leave there on some versions (see
# assert_no_error_message). Whether the filetype sourced it is read from
# :scriptnames before that, since the direct source adds it there too.
test_ftplugin() {
  local ft=$1
  local file="$repo/.vim/pack/zzz-settings/start/settings/after/ftplugin/$ft.vim"

  cat > "$BATS_TEST_TMPDIR/ftplugin.vim" <<EOF
messages clear
set filetype=$ft
echomsg 'by_filetype=' . (execute('scriptnames') =~# '/zzz-settings/start/settings/after/ftplugin/$ft\.vim\%(\n\|\$\)')
let v:errmsg = ''
source $file
EOF

  start_vim -S "$BATS_TEST_TMPDIR/ftplugin.vim"

  assert_line 'by_filetype=1'
  assert_no_error_message
  assert_line 'errmsg='
}

#-----------------------------------------------------------------------------
# test_ftplugin_off FILETYPE - with filetype plugins switched off, setting the
# filetype must not source our ftplugin file for it. Syntax stays on, so a
# syntax file that sources ftplugins itself fails this.
#
# json is the exception and has its own tests below: vim-polyglot's JSON
# syntax file sources every ftplugin/json.vim itself, so ours is always read
# and has to stop itself.
test_ftplugin_off() {
  local ft=$1

  cat > "$BATS_TEST_TMPDIR/ftplugin.vim" <<EOF
filetype plugin off
set filetype=$ft
echomsg 'by_filetype=' . (execute('scriptnames') =~# '/zzz-settings/start/settings/after/ftplugin/$ft\.vim\%(\n\|\$\)')
EOF

  start_vim -S "$BATS_TEST_TMPDIR/ftplugin.vim"

  assert_line 'by_filetype=0'
  assert_no_error_message
}

# Tests per file, registered from the directory listing. If the glob matches
# nothing it stays literal and registers tests for "*", which fail rather
# than leaving the suite silently empty.
for file in "$ftplugin_dir"/*.vim; do
  ft=${file##*/}
  ft=${ft%.vim}
  bats_test_function --description "ftplugin $ft loads with no error message" \
    -- test_ftplugin "$ft"

  [[ $ft == json ]] && continue

  bats_test_function \
    --description "ftplugin $ft is not sourced with filetype plugins off" \
    -- test_ftplugin_off "$ft"
done

##############################################################################
#-----------------------------------------------------------------------------
# json_ftplugin_ran FILETYPE [VIM COMMAND] - run the command, set the
# filetype, and report what our json ftplugin would have changed: the
# buffer's foldmethod and the json key in ALE's fixers.
json_ftplugin_ran() {
  cat > "$BATS_TEST_TMPDIR/json.vim" <<EOF
${2:-}
set filetype=$1
echomsg 'foldmethod=' . &l:foldmethod
echomsg 'json_fixers=' . string(get(g:ale_fixers, 'json', 'missing'))
EOF

  start_vim -S "$BATS_TEST_TMPDIR/json.vim"
}

#-----------------------------------------------------------------------------
@test "ftplugin json has no effect with filetype plugins off" {
  json_ftplugin_ran json 'filetype plugin off'

  assert_line 'foldmethod=manual'
  assert_line "json_fixers='missing'"
  assert_no_error_message
}

#-----------------------------------------------------------------------------
# The Dockerfile syntax includes the JSON syntax, which reaches the json
# ftplugin from a buffer that is not JSON.
@test "ftplugin json has no effect in a Dockerfile buffer" {
  json_ftplugin_ran dockerfile

  assert_line 'foldmethod=manual'
  assert_line "json_fixers='missing'"
  assert_no_error_message
}

#-----------------------------------------------------------------------------
# The guard in the json ftplugin must still let it run for JSON.
@test "ftplugin json takes effect in a json buffer" {
  json_ftplugin_ran json

  assert_line 'foldmethod=syntax'
  assert_line "json_fixers=['jq']"
  assert_no_error_message
}
