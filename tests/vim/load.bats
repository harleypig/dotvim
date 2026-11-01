#!/usr/bin/env bats

# Every settings file loads without raising an error: the whole config at
# startup, with and without Node.js, then each file under the late settings'
# after/ftplugin directory, one test per file.
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
# The message history names the file and line of every error, so this runs
# before any check that would print less, and a failure shows which settings
# file raised it.
assert_no_error_message() {
  refute_output --partial 'Error detected while processing'
  refute_line --regexp '^E[0-9]+:'
  assert_line 'errmsg='
}

##############################################################################
#-----------------------------------------------------------------------------
@test "without node, Vim starts with no error message at all" {
  start_vim

  assert_no_error_message
  assert_equal "$vim_status" 0
}

#-----------------------------------------------------------------------------
@test "with node, Vim starts with no error message at all" {
  with_node
  start_vim --cmd 'let g:coc_start_at_startup = 0'

  assert_no_error_message
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
test_ftplugin() {
  local ft=$1

  start_vim -c 'messages clear' -c 'let v:errmsg = ""' \
    -c "set filetype=$ft"

  assert_line --regexp "/zzz-settings/start/settings/after/ftplugin/$ft\.vim$"
  assert_no_error_message
}

# One test per file, registered from the directory listing. If the glob
# matches nothing it stays literal and registers a test for "*", which fails
# rather than leaving the suite silently empty.
for file in "$ftplugin_dir"/*.vim; do
  ft=${file##*/}
  ft=${ft%.vim}
  bats_test_function --description "ftplugin $ft loads with no error message" \
    -- test_ftplugin "$ft"
done
