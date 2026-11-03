#!/usr/bin/env bats

# What our settings tell CoC and ALE about language servers, prose and
# Markdown linting, and diagnostic colours.
#
# coc-settings.json is JSON with comments, which CoC reads and Vim's
# json_decode() does not, so the coc-settings tests drop the whole-line
# comments it uses and decode the rest. A file that still fails to decode
# fails the test, never passes it.
#
# The other tests use the harness in coc.bats: headless Vim on this
# checkout's .vimrc, HOME and the XDG directories inside the test's temp
# directory, and a PATH holding only a stub directory.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  repo="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  stubs="$BATS_TEST_TMPDIR/bin"
  report="$BATS_TEST_TMPDIR/report"
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/home"

  [[ -f $repo/.vim/pack/300-intellisense/start/ale/plugin/ale.vim ]] \
    || fail "ALE submodule is not checked out"

  ln -s "$(type -P sh)" "$stubs/sh"
}

#-----------------------------------------------------------------------------
# coc_setting EXPR - decode coc-settings.json as s and echo EXPR as JSON.
coc_setting() {
  cat > "$BATS_TEST_TMPDIR/coc.vim" <<EOF
redir! > $report
let s = readfile('$repo/.vim/coc-settings.json')
let s = json_decode(join(filter(s, 'v:val !~# "^\\\\s*//"'), "\\n"))
echo 'value=' . json_encode($1)
redir END
qa!
EOF

  timeout 30 "$vim" -N -u NONE -es -S "$BATS_TEST_TMPDIR/coc.vim" || true

  run cat "$report"
}

#-----------------------------------------------------------------------------
# start_vim SCRIPT [VIM ARGS...] - run Vim on our .vimrc from $workdir,
# source SCRIPT after startup, and load what it wrote to $report as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR" script="$1"
  shift

  { printf 'redir! > %s\n' "$report"
    cat "$script"
    printf 'redir END\nqa!\n'
  } > "$tmp/check.vim"

  (
    cd "${workdir:-$tmp}" || exit 1

    timeout 30 env -i \
      HOME="$tmp/home" PATH="$stubs" TERM=dumb \
      XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config" \
      XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
      XDG_CACHE_HOME="$tmp/cache" \
      "$vim" -N -u "$repo/.vimrc" -es "$@" -S "$tmp/check.vim"
  ) || true

  run cat "$report"
}

##############################################################################
#-----------------------------------------------------------------------------
@test "coc-settings starts no language server an extension provides" {
  coc_setting 'sort(keys(s.languageserver))'

  # coc-docker starts docker-langserver, so it is not started by hand.
  # terraform-ls has no extension.
  assert_line 'value=["html","terraform"]'
}
