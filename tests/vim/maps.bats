#!/usr/bin/env bats

# What the late maps.vim maps: the w!! sudo write, with vim-eunuch loaded
# and without it.
#
# The harness is the one in coc.bats: headless Vim on this checkout's .vimrc,
# HOME and the XDG directories inside the test's temp directory, and a PATH
# holding only a stub directory.

bats_load_library bats-support
bats_load_library bats-assert

maps="$BATS_TEST_DIRNAME/../../.vim/pack/zzz-settings/start/settings/plugin/maps.vim"

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  repo="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  stubs="$BATS_TEST_TMPDIR/bin"
  report="$BATS_TEST_TMPDIR/report"
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/home"

  [[ -f $repo/.vim/pack/100-core/start/vim-eunuch/plugin/eunuch.vim ]] \
    || fail "vim-eunuch submodule is not checked out"

  ln -s "$(type -P sh)" "$stubs/sh"
}

#-----------------------------------------------------------------------------
# start_vim [VIM ARGS...] - run Vim, then write the mappings the tests
# inspect to $report and load it as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  cat > "$tmp/report.vim" <<EOF
redir! > $report
echo 'errmsg=' . v:errmsg
echo 'eunuch=' . exists('g:loaded_eunuch')
echo 'sudowrite_cmd=' . exists(':SudoWrite')
echo 'sudo_map=' . maparg('w!!', 'c')
redir END
qa!
EOF

  timeout 30 env -i \
    HOME="$tmp/home" PATH="$stubs" TERM=dumb \
    XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config" \
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
    XDG_CACHE_HOME="$tmp/cache" \
    "$vim" -N -u "$repo/.vimrc" -es "$@" -S "$tmp/report.vim" || true

  run cat "$report"
}

##############################################################################
#-----------------------------------------------------------------------------
@test "with vim-eunuch loaded, w!! becomes eunuch's :SudoWrite" {
  start_vim

  assert_line 'eunuch=1'
  assert_line 'sudowrite_cmd=2'
  assert_line 'sudo_map=SudoWrite'
}

#-----------------------------------------------------------------------------
# eunuch cannot be kept from loading without changing the packpath, so
# maps.vim is sourced again with its guard variable gone.
@test "without vim-eunuch, w!! writes through sudo tee, keeping the buffer" {
  start_vim -c 'unlet g:loaded_eunuch' -c 'cunmap w!!' -c "source $maps"

  assert_line 'eunuch=0'
  assert_line 'sudo_map=w !sudo tee > /dev/null %'
}
