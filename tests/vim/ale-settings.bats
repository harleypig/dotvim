#!/usr/bin/env bats

# What our settings tell ALE once it has loaded: that its LSP support is off,
# and the linters and fixers a Markdown or JSONC buffer is given.
#
# The harness is the one in ale-linters.bats: headless Vim on this checkout's
# .vimrc, HOME and the XDG directories inside the test's temp directory, and
# a PATH holding only a stub directory.

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
# start_vim SCRIPT - run Vim, source SCRIPT after startup, and load what it
# wrote to $report as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  # Check FILETYPE NAMES reports each name ALE does not define for the
  # filetype as bad=. ALE matches a configured name against a linter's name
  # and its aliases, over the filetypes it resolves to.
  cat > "$tmp/check.vim" <<EOF
redir! > $report

echo 'loaded_ale=' . exists('g:loaded_ale')

function! Check(ft, names) abort
  let l:linters = ale#linter#GetAll(ale#linter#ResolveFiletype(a:ft))

  for l:name in a:names
    if empty(filter(copy(l:linters),
    \ {_, l -> index([l.name] + l.aliases, l:name) >= 0}))
      echo 'bad=' . a:ft . ':' . l:name
    endif
  endfor

  echo 'checked=' . a:ft
endfunction
EOF

  cat "$1" >> "$tmp/check.vim"
  printf 'redir END\nqa!\n' >> "$tmp/check.vim"

  timeout 30 env -i \
    HOME="$tmp/home" PATH="$stubs" TERM=dumb \
    XDG_DOTVIM="$repo" XDG_CONFIG_HOME="$tmp/config" \
    XDG_DATA_HOME="$tmp/data" XDG_STATE_HOME="$tmp/state" \
    XDG_CACHE_HOME="$tmp/cache" \
    "$vim" -N -u "$repo/.vimrc" -es -S "$tmp/check.vim" || true

  run cat "$report"

  # Guards against a vacuous pass: every value read below is ALE's.
  assert_line 'loaded_ale=1'
}

##############################################################################
#-----------------------------------------------------------------------------
@test "ALE's LSP support is off once ALE has loaded" {
  # ALE sets g:ale_disable_lsp to 'auto' when it loads unless something set
  # it first, so 1 here means it was set before ALE loaded.
  echo "echo 'disable_lsp=' . string(g:ale_disable_lsp)" \
    > "$BATS_TEST_TMPDIR/body.vim"

  start_vim "$BATS_TEST_TMPDIR/body.vim"

  assert_line 'disable_lsp=1'
}

#-----------------------------------------------------------------------------
@test "a Markdown buffer is linted by markdownlint and proselint" {
  cat > "$BATS_TEST_TMPDIR/body.vim" <<'EOF'
set filetype=markdown
echo 'linters=' . string(get(b:, 'ale_linters', 'unset'))
call Check('markdown', get(b:, 'ale_linters', []))
EOF

  start_vim "$BATS_TEST_TMPDIR/body.vim"

  assert_line "linters=['markdownlint', 'proselint']"
  assert_line 'checked=markdown'
  refute_line --partial 'bad='
}

#-----------------------------------------------------------------------------
@test "the Markdown linters are not set for every buffer" {
  cat > "$BATS_TEST_TMPDIR/body.vim" <<'EOF'
echo 'at_start=' . has_key(g:ale_linters, 'markdown')
set filetype=markdown
echo 'after_markdown=' . has_key(g:ale_linters, 'markdown')
EOF

  start_vim "$BATS_TEST_TMPDIR/body.vim"

  assert_line 'at_start=0'
  assert_line 'after_markdown=0'
}

#-----------------------------------------------------------------------------
@test "a JSONC buffer is fixed by jq" {
  cat > "$BATS_TEST_TMPDIR/body.vim" <<'EOF'
set filetype=jsonc
echo 'fixers=' . string(get(b:, 'ale_fixers',
\ get(g:ale_fixers, 'jsonc', 'unset')))
EOF

  start_vim "$BATS_TEST_TMPDIR/body.vim"

  assert_line "fixers=['jq']"
}
