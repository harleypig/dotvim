#!/usr/bin/env bats

# Starts headless Vim on this checkout's .vimrc, never the installed one,
# with HOME and the XDG directories inside the test's temp directory.
# PATH holds only a stub directory, so whether node is "installed" is up to
# each test. The node stub is a tripwire: CoC is told not to start its
# server, so nothing should ever run it, and nothing reaches the network.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  repo="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  stubs="$BATS_TEST_TMPDIR/bin"
  tripped="$BATS_TEST_TMPDIR/tripped"
  report="$BATS_TEST_TMPDIR/report"
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/home"

  [[ -f $repo/.vim/pack/300-intellisense/start/coc/plugin/coc.vim ]] \
    || fail "coc.nvim submodule is not checked out"

  ln -s "$(type -P sh)" "$stubs/sh"
}

#-----------------------------------------------------------------------------
with_node() {
  printf '#!/bin/sh\necho "node $*" >> "%s"\n' "$tripped" > "$stubs/node"
  chmod +x "$stubs/node"
}

#-----------------------------------------------------------------------------
# start_vim [VIM ARGS...] - run Vim, then write what the tests inspect to
# $report and load it as $output. Vim's exit status is left in $vim_status;
# in Ex mode it is non-zero when any command raised an error.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  # Vim takes at most ten -c / --cmd arguments, so the report is a script.
  cat > "$tmp/report.vim" <<EOF
redir! > $report
echo 'errmsg=' . v:errmsg
messages
echo 'line=[' . getline(1) . ']'
echo 'coc_plugin=' . exists(':CocStart')
echo 'tab_map=' . maparg('<Tab>', 'i')
echo 'ale_plugin=' . exists(':ALEInfo')
echo 'ale_fix_map=' . maparg('<leader>fb', 'n')
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

##############################################################################
#-----------------------------------------------------------------------------
@test "Tab at the start of a line inserts whitespace without an error" {
  with_node
  start_vim --cmd 'let g:coc_start_at_startup = 0' \
    -c 'call feedkeys("i\<Tab>\<Esc>", "xt")'

  assert_equal "$vim_status" 0
  assert_line 'errmsg='
  assert_line --partial 'tab_map=coc#pum#visible()'
  assert_line --regexp '^line=\[\s+\]$'
  refute [ -e "$tripped" ]
}

#-----------------------------------------------------------------------------
@test "without node, Vim starts with no errors and no CoC warning" {
  start_vim

  assert_equal "$vim_status" 0
  assert_line 'errmsg='
  refute_output --partial 'coc.nvim'
}

#-----------------------------------------------------------------------------
@test "without node, CoC and its mappings are not loaded" {
  start_vim

  assert_line 'coc_plugin=0'
  assert_line 'tab_map='
}

#-----------------------------------------------------------------------------
@test "without node, ALE and the rest of the config still load" {
  start_vim

  assert_line 'ale_plugin=2'
  assert_line 'ale_fix_map=<Plug>(ale_fix)'
}

#-----------------------------------------------------------------------------
@test "with node, CoC and its mappings are loaded" {
  with_node
  start_vim --cmd 'let g:coc_start_at_startup = 0'

  assert_equal "$vim_status" 0
  assert_line 'coc_plugin=2'
  assert_line --partial 'tab_map=coc#pum#visible()'
  refute [ -e "$tripped" ]
}
