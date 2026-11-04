#!/usr/bin/env bats

# The sh ftplugin's options for ALE's shfmt fixer (#81 - the shfmt fixer
# did nothing). ALE pipes the buffer to shfmt on stdin, so the command ALE
# builds for an sh buffer is run that way here, through the real shfmt.
#
# Vim itself runs headless through helpers/vim.bash, with a PATH holding only
# stubs. Only the command it reports is run with the test's own PATH, which
# is where shfmt has to be.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  type -P shfmt > /dev/null \
    || skip "shfmt is not on PATH; the test runs the fixer's command with it"

  vim_fixture

  script="$BATS_TEST_TMPDIR/script.sh"
  command_file="$BATS_TEST_TMPDIR/command"

  local ale="$repo/.vim/pack/300-intellisense/start/ale"
  [[ -f $ale/autoload/ale/fixers/shfmt.vim ]] \
    || fail "ALE submodule is not checked out"
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

  headless_vim -- "$1" -S "$tmp/command.vim" || true

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
