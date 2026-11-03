#!/usr/bin/env bats

# The sh ftplugin's options for ALE's shfmt fixer (#81 - the shfmt fixer
# did nothing). ALE pipes the buffer to shfmt on stdin, so the command ALE
# builds for an sh buffer is run that way here, through the real shfmt.
#
# Vim itself runs in the harness from coc.bats: headless, on this checkout's
# .vimrc, with HOME and the XDG directories inside the test's temp directory
# and a PATH holding only stubs. Only the command it reports is run with the
# test's own PATH, which is where shfmt has to be.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  type -P shfmt > /dev/null \
    || skip "shfmt is not on PATH; the test runs the fixer's command with it"

  repo="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"
  stubs="$BATS_TEST_TMPDIR/bin"
  script="$BATS_TEST_TMPDIR/script.sh"
  command_file="$BATS_TEST_TMPDIR/command"
  vim="$(type -P vim)"
  mkdir -p "$stubs" "$BATS_TEST_TMPDIR/home"

  local ale="$repo/.vim/pack/300-intellisense/start/ale"
  [[ -f $ale/autoload/ale/fixers/shfmt.vim ]] \
    || fail "ALE submodule is not checked out"

  ln -s "$(type -P sh)" "$stubs/sh"
}

#-----------------------------------------------------------------------------
# fixer_command FILE - open FILE in Vim and write the command ALE's shfmt
# fixer builds for its buffer to $command_file, with %s filled in by the
# file's name as ALE fills it.
fixer_command() {
  local tmp="$BATS_TEST_TMPDIR"

  cat > "$tmp/command.vim" <<EOF
let s:command = ale#fixers#shfmt#Fix(bufnr(''))['command']
call writefile([substitute(s:command, '%s', shellescape(expand('%:p')), 'g')],
  \\ '$command_file')
qa!
EOF

  timeout 30 env -i \
    HOME="$tmp/home" PATH="$stubs" TERM=dumb \
    XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config" \
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
    XDG_CACHE_HOME="$tmp/cache" \
    "$vim" -N -u "$repo/.vimrc" -es "$1" -S "$tmp/command.vim" \
    || true

  [[ -s $command_file ]] || fail "Vim wrote no fixer command"
}

##############################################################################
#-----------------------------------------------------------------------------
# Red if --write comes back (shfmt refuses stdin and exits 1) or --indent 2
# is dropped (shfmt indents with tabs).
@test "the sh fixer's shfmt command formats stdin with two-space indents" {
  printf 'if true; then\necho hi\nfi\n' > "$script"

  fixer_command "$script"

  run sh -c "$(< "$command_file")" < "$script"

  assert_success
  assert_output "$(printf 'if true; then\n  echo hi\nfi')"
}
