#!/usr/bin/env bats

# What our settings tell CoC and ALE about language servers, prose and
# Markdown linting, and diagnostic colours.
#
# coc-settings.json is JSON with comments, which CoC reads and Vim's
# json_decode() does not, so the coc-settings tests drop the whole-line
# comments it uses and decode the rest. A file that still fails to decode
# fails the test, never passes it.
#
# The other tests run Vim headless through helpers/vim.bash.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture

  [[ -f $repo/.vim/pack/300-intellisense/start/ale/plugin/ale.vim ]] \
    || fail "ALE submodule is not checked out"
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

    headless_vim "$@" -S "$tmp/check.vim"
  ) || true

  run cat "$report"
}

##############################################################################
#-----------------------------------------------------------------------------
@test "coc-settings starts no language server an extension provides" {
  coc_setting 'sort(keys(s.languageserver))'

  # coc-docker starts docker-langserver and coc-html the HTML language
  # server, so neither is started by hand. terraform-ls has no extension.
  assert_line 'value=["terraform"]'
}

#-----------------------------------------------------------------------------
@test "coc-html is told about Mustache templates as well as its defaults" {
  coc_setting "s['html.filetypes']"

  assert_line \
    'value=["html","handlebars","htmldjango","blade","html.mustache"]'
}

#-----------------------------------------------------------------------------
@test "proselint is run with its 0.16 check command, reading stdin" {
  coc_setting 's["diagnostic-languageserver.linters"].proselint.args'

  # No --config: proselint finds a project's proselint.json, or the user's
  # own, by itself.
  assert_line 'value=["check"]'
}

#-----------------------------------------------------------------------------
@test "Markdown gets only the global fixers, never prettier" {
  cat > "$BATS_TEST_TMPDIR/body.vim" <<'EOF'
echo 'markdown=' . string(get(g:ale_fixers, 'markdown', 'unset'))
echo 'star=' . string(g:ale_fixers['*'])
EOF

  start_vim "$BATS_TEST_TMPDIR/body.vim"

  assert_line 'markdown='"'"'unset'"'"
  assert_line "star=['remove_trailing_lines', 'trim_whitespace']"
}

#-----------------------------------------------------------------------------
@test "markdownlint is given the nearest .markdownlint.yaml from any cwd" {
  local project="$BATS_TEST_TMPDIR/project"
  mkdir -p "$project/docs" "$BATS_TEST_TMPDIR/elsewhere"
  : > "$project/.markdownlint.yaml"
  : > "$project/docs/page.md"

  cat > "$BATS_TEST_TMPDIR/body.vim" <<'EOF'
echo 'ft=' . &filetype
echo 'opts=' . get(b:, 'ale_markdown_markdownlint_options', 'unset')
EOF

  workdir="$BATS_TEST_TMPDIR/elsewhere" \
    start_vim "$BATS_TEST_TMPDIR/body.vim" "$project/docs/page.md"

  assert_line 'ft=markdown'
  assert_line "opts=--config '$project/.markdownlint.yaml'"
}

#-----------------------------------------------------------------------------
@test "markdownlint keeps its defaults where no .markdownlint.yaml exists" {
  mkdir -p "$BATS_TEST_TMPDIR/bare"
  : > "$BATS_TEST_TMPDIR/bare/page.md"

  cat > "$BATS_TEST_TMPDIR/body.vim" <<'EOF'
echo 'ft=' . &filetype
echo 'opts=' . get(b:, 'ale_markdown_markdownlint_options', 'unset')
EOF

  start_vim "$BATS_TEST_TMPDIR/body.vim" "$BATS_TEST_TMPDIR/bare/page.md"

  assert_line 'ft=markdown'
  assert_line 'opts=unset'
}

#-----------------------------------------------------------------------------
@test "ALE's virtual text keeps ALE's own colours while it is switched off" {
  cat > "$BATS_TEST_TMPDIR/body.vim" <<'EOF'
echo 'virtualtext=' . g:ale_virtualtext_cursor
for group in ['Error', 'Warning', 'Info']
  echo group . '=' . synIDattr(hlID('ALEVirtualText' . group), 'bg', 'cterm')
endfor
EOF

  start_vim "$BATS_TEST_TMPDIR/body.vim"

  assert_line 'virtualtext=disabled'
  assert_line 'Error='
  assert_line 'Warning='
  assert_line 'Info='
}
