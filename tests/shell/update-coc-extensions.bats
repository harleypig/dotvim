#!/usr/bin/env bats

# bin/update-coc-extensions rewrites the g:coc_global_extensions list in the
# .vimrc of the directory it runs in. Every test runs it in a per-test temp
# directory holding a copy of a small .vimrc, with COC_EXTENSIONS_DIR
# pointing at a fake extensions directory, so the real .vimrc and the real
# CoC install are never read or written.

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
