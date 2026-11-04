#!/usr/bin/env bats

# The late diagnostic-colors.vim applies its palette again whenever a
# colour scheme loads, since loading one clears every highlight group.
# colors.bats checks the palette itself at startup.
#
# Vim runs headless through helpers/vim.bash.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture
}

##############################################################################
#-----------------------------------------------------------------------------
@test "the diagnostic colours survive loading a colour scheme" {
  cat > "$BATS_TEST_TMPDIR/test.vim" <<EOF
redir! > $report
colorscheme default
for s:group in ['ALEErrorSign', 'CocWarningSign', 'DiagnosticInfo', 'CocHintSign']
  let s:id = synIDtrans(hlID(s:group))
  echo s:group . '=' . synIDattr(s:id, 'bg', 'gui') . '/' . synIDattr(s:id, 'fg', 'gui')
endfor
echo 'errmsg=' . v:errmsg
redir END
qa!
EOF

  headless_vim -S "$BATS_TEST_TMPDIR/test.vim" || true

  run cat "$report"

  assert_line 'errmsg='
  assert_line 'ALEErrorSign=DarkRed/White'
  assert_line 'CocWarningSign=Gold/Black'
  assert_line 'DiagnosticInfo=RoyalBlue/White'
  assert_line 'CocHintSign=LightGrey/Black'
}
