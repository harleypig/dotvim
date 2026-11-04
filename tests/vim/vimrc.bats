#!/usr/bin/env bats

# Where .vimrc finds the rest of the configuration: the checkout named by
# XDG_DOTVIM, or, with XDG_DOTVIM unset or empty, the checkout .vimrc itself
# is in, through a symlink if it was reached through one (#137 - unset
# XDG_DOTVIM loaded none of the settings).
#
# The harness is the one in coc.bats: headless Vim, HOME and the XDG
# directories inside the test's temp directory, and a PATH holding only a
# stub directory. Silent Ex mode reads no vimrc of its own accord, so the
# symlink case names ~/.vimrc with -u, as a plain `vim` would find it.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  repo="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  stubs="$BATS_TEST_TMPDIR/bin"
  report="$BATS_TEST_TMPDIR/report"
  home="$BATS_TEST_TMPDIR/home"
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$home"

  ln -s "$(type -P sh)" "$stubs/sh"
}

#-----------------------------------------------------------------------------
# start_vim VIMRC [VAR=VALUE...] - run Vim on VIMRC with the given variables
# in its environment besides HOME, PATH, TERM and the XDG state and data
# directories, then load what it reports as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"
  local vimrc=$1
  shift

  cat > "$tmp/report.vim" <<EOF
redir! > $report
echo 'errmsg=' . v:errmsg
echo 'rtp0=' . split(&runtimepath, ',')[0]
echo 'pp0=' . split(&packpath, ',')[0]
echo 'late=' . exists(':QuickfixToggle')
redir END
qa!
EOF

  timeout 30 env -i \
    HOME="$home" PATH="$stubs" TERM=dumb \
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" "$@" \
    "$vim" -N -u "$vimrc" -es -S "$tmp/report.vim" || true

  run cat "$report"
}

#-----------------------------------------------------------------------------
# assert_loaded_from DIR - the configuration in DIR is first on the
# runtimepath and packpath, and the late settings loaded without an error.
assert_loaded_from() {
  local dir=$1

  assert_line 'errmsg='
  assert_line "rtp0=$dir/.vim"
  assert_line "pp0=$dir/.vim"
  assert_line 'late=2'
}

##############################################################################
#-----------------------------------------------------------------------------
@test "with XDG_DOTVIM set, .vimrc loads the configuration it names" {
  start_vim "$repo/.vimrc" XDG_DOTVIM="$repo"

  assert_loaded_from "$repo"
}

#-----------------------------------------------------------------------------
@test "with XDG_DOTVIM unset, .vimrc loads the checkout it is in" {
  start_vim "$repo/.vimrc"

  assert_loaded_from "$repo"
}

#-----------------------------------------------------------------------------
@test "with XDG_DOTVIM empty, .vimrc loads the checkout it is in" {
  start_vim "$repo/.vimrc" XDG_DOTVIM=

  assert_loaded_from "$repo"
}

#-----------------------------------------------------------------------------
@test "a ~/.vimrc symlinked to .vimrc loads the checkout, not ~" {
  ln -s "$repo/.vimrc" "$home/.vimrc"

  start_vim "$home/.vimrc"

  assert_loaded_from "$repo"
}
