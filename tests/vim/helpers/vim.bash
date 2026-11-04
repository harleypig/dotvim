# The headless Vim the Vim configuration's tests share: Vim in silent Ex
# mode on this checkout's .vimrc, never the installed one, with HOME and the
# XDG directories inside the per-test temp directory and a PATH holding only
# a stub directory, so nothing outside the test is read or written and
# nothing reaches the network.

#-----------------------------------------------------------------------------
# vim_fixture - set $repo, $vim, $vimrc, $home, $stubs (holding only sh),
# $report and the $vim_env headless_vim runs in, and create $home and
# $stubs. Call from setup; a test file may change $vimrc or $vim_env after.
vim_fixture() {
  local tmp="$BATS_TEST_TMPDIR"

  # The checkout this file is in, whichever test file loaded it.
  repo="$(cd "${BASH_SOURCE[0]%/*}/../../.." && pwd)"

  vim="$(type -P vim)"
  vimrc="$repo/.vimrc"
  home="$tmp/home"
  stubs="$tmp/bin"
  # shellcheck disable=SC2034  # read by the test files, not here
  report="$tmp/report"
  mkdir -p "$stubs" "$home"

  ln -s "$(type -P sh)" "$stubs/sh"

  vim_env=(
    HOME="$home" PATH="$stubs" TERM=dumb
    XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config"
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state"
    XDG_CACHE_HOME="$tmp/cache"
  )
}

#-----------------------------------------------------------------------------
# vim_env_unset NAME... - drop NAME from $vim_env, so headless_vim runs with
# it unset rather than set to anything.
vim_env_unset() {
  local name kept=() pair

  for pair in "${vim_env[@]}"; do
    for name in "$@"; do
      [[ ${pair%%=*} == "$name" ]] && continue 2
    done

    kept+=("$pair")
  done

  vim_env=("${kept[@]}")
}

#-----------------------------------------------------------------------------
# with_node - put a node stub on $stubs that records each run in $tripped.
# CoC is told not to start its server wherever a test uses it, so the stub
# is a tripwire: a $tripped file means something ran node.
with_node() {
  tripped="$BATS_TEST_TMPDIR/tripped"

  printf '#!/bin/sh\necho "node $*" >> "%s"\n' "$tripped" > "$stubs/node"
  chmod +x "$stubs/node"
}

#-----------------------------------------------------------------------------
# headless_vim [VAR=VALUE...] [--] [VIM ARGS...] - run Vim on $vimrc in
# $vim_env plus the given variables, which win over $vim_env's, and return
# Vim's exit status: in Ex mode it is non-zero when any command raised an
# error. It is killed after 30 seconds, so a Vim waiting on input fails the
# test instead of hanging the suite.
headless_vim() {
  local extra=()

  while [[ ${1-} == *=* && ${1-} != -* ]]; do
    extra+=("$1")
    shift
  done

  [[ ${1-} == -- ]] && shift

  timeout 30 env -i "${vim_env[@]}" "${extra[@]}" \
    "$vim" -N -u "$vimrc" -es "$@"
}
