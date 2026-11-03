#!/usr/bin/env bats

# bin/update-coc-extensions rewrites the g:coc_global_extensions list in the
# .vimrc of the directory it runs in. Every test runs it in a per-test temp
# directory holding a copy of a small .vimrc, with COC_EXTENSIONS_DIR
# pointing at a fake extensions directory, so the real CoC install is never
# read and the real .vimrc is never written; one test rewrites a copy of it.

bats_load_library bats-support
bats_load_library bats-assert

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  script="$BATS_TEST_DIRNAME/../../bin/update-coc-extensions"
  stubs="$BATS_TEST_TMPDIR/bin"
  tripped="$BATS_TEST_TMPDIR/tripped"
  mkdir -p "$stubs"

  local tool
  for tool in bash cat jq perl; do
    ln -s "$(type -P "$tool")" "$stubs/$tool"
  done

  for tool in curl git npm; do
    printf '#!/bin/sh\necho "%s $*" >> "%s"\n' "$tool" "$tripped" \
      > "$stubs/$tool"
    chmod +x "$stubs/$tool"
  done

  export COC_EXTENSIONS_DIR="$BATS_TEST_TMPDIR/extensions"
  mkdir -p "$COC_EXTENSIONS_DIR"

  cd "$BATS_TEST_TMPDIR" || return 1

  cat > .vimrc << 'VIMRC'
set nocompatible

let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-old',
  \]

set number
VIMRC

  cp .vimrc original.vimrc
}

#-----------------------------------------------------------------------------
# installed NAME... - the fake CoC install holds these extensions.
installed() {
  local name deps=

  for name in "$@"; do
    deps+="${deps:+,}\"$name\": \">=0.0.0\""
  done

  printf '{"dependencies": {%s}}\n' "$deps" \
    > "$COC_EXTENSIONS_DIR/package.json"
}

#-----------------------------------------------------------------------------
update() {
  run env PATH="$stubs" HOME="$BATS_TEST_TMPDIR" \
    COC_EXTENSIONS_DIR="$COC_EXTENSIONS_DIR" "$script"
}

##############################################################################
@test "rewrites the list from the installed extensions" {
  installed coc-sh coc-json @yaegassy/coc-ansible
  update
  assert_success

  assert_equal "$(< .vimrc)" "$(cat << 'VIMRC'
set nocompatible

let g:coc_global_extensions = [
  \ '@yaegassy/coc-ansible',
  \ 'coc-json',
  \ 'coc-sh',
  \]

set number
VIMRC
)"

  [[ ! -e $tripped ]] || fail "unexpected call: $(< "$tripped")"
}

@test "leaves .vimrc alone when nothing is installed" {
  installed
  update
  assert_failure
  assert_output --partial 'No CoC extensions'
  assert_equal "$(< .vimrc)" "$(< original.vimrc)"
}

@test "leaves .vimrc alone when there is no package.json" {
  update
  assert_failure
  assert_output --partial 'package.json'
  assert_equal "$(< .vimrc)" "$(< original.vimrc)"
}

@test "fails without writing when .vimrc has no extensions list" {
  installed coc-json
  printf 'set number\n' > .vimrc
  update
  assert_failure
  assert_output --partial 'g:coc_global_extensions'
  assert_equal "$(< .vimrc)" 'set number'
}

@test "fails without writing when there is no .vimrc to rewrite" {
  installed coc-json
  rm .vimrc
  update
  assert_failure
  assert_output --partial 'No writable .vimrc here'
  [[ ! -e .vimrc ]] || fail '.vimrc was created'
}

@test "reads the extensions from ~/.config/coc/extensions by default" {
  installed coc-default
  mkdir -p .config/coc
  mv "$COC_EXTENSIONS_DIR" .config/coc/extensions
  run env -u COC_EXTENSIONS_DIR PATH="$stubs" HOME="$BATS_TEST_TMPDIR" \
    "$script"
  assert_success
  grep -qF "  \\ 'coc-default'," .vimrc || fail "list not rewritten: $(< .vimrc)"
}

@test "rewrites the list in the repository's own .vimrc" {
  # A copy of the real .vimrc, so a change to how its list is laid out that
  # the script no longer matches fails here, not the next time it is run.
  cp "$BATS_TEST_DIRNAME/../../.vimrc" .vimrc
  cp .vimrc original.vimrc
  installed coc-only
  update
  assert_success

  local entry="^  \\\\ '"
  local entries
  entries=$(grep -c "$entry" .vimrc)
  assert_equal "$entries" 1
  grep -qF "  \\ 'coc-only'," .vimrc || fail 'coc-only not in the list'

  # Outside the list's entries, nothing changed.
  assert_equal "$(grep -v "$entry" .vimrc)" "$(grep -v "$entry" original.vimrc)"
}
