#!/usr/bin/env bats

# The small fixes of #44 - small tidy-ups in the late settings: functions
# kept script-local, mappings kept to the modes they work in, autocmds that
# do not stack when re-sourced, settings kept to the buffer, and branches
# left for plugins that are not installed.
#
# Vim runs headless through helpers/vim.bash, whose PATH holds only a shell,
# so CoC stays off unless a test adds node.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture

  settings="$repo/.vim/pack/zzz-settings/start/settings"

  [[ -f $repo/.vim/pack/300-intellisense/start/coc/plugin/coc.vim ]] \
    || fail "coc.nvim submodule is not checked out"
}

#-----------------------------------------------------------------------------
# stub NAME - put an executable NAME on PATH that does nothing.
stub() {
  printf '#!/bin/sh\n' > "$stubs/$1"
  chmod +x "$stubs/$1"
}

#-----------------------------------------------------------------------------
# start_vim [VIM ARGS...] - run Vim, then the Vim commands read from stdin
# with their output redirected to $report, and load it as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  {
    echo "redir! > $report"
    cat
    echo 'redir END'
    echo 'qa!'
  } > "$tmp/report.vim"

  headless_vim -- "$@" -S "$tmp/report.vim" || true

  run cat "$report"
}

##############################################################################
#-----------------------------------------------------------------------------
@test "CoC's Tab and Ctrl-Space mappings call only what is installed" {
  stub node
  start_vim --cmd 'let g:coc_start_at_startup = 0' << 'EOF'
echo 'tab=' . maparg('<Tab>', 'i')
echo 'space=' . maparg('<C-@>', 'i')
echo 'global=' . exists('*CheckBackspace')
EOF

  assert_line --regexp '^tab=.*<SNR>[0-9]+_CheckBackspace\(\)'
  refute_output --partial 'copilot'
  assert_line 'space=coc#refresh()'
  assert_line 'global=0'
}

#-----------------------------------------------------------------------------
@test "re-sourcing help.vim does not add its autocmds again" {
  start_vim << EOF
let s:before = execute('autocmd FileType help')
source $settings/plugin/help.vim
echo 'same=' . (execute('autocmd FileType help') ==# s:before)
echo 'count=' . len(filter(split(s:before, "\n"), 'v:val =~# "nmap\\\\|wincmd"'))
EOF

  assert_line 'same=1'
  assert_line 'count=3'
}

#-----------------------------------------------------------------------------
@test "<Leader>pp toggles paste in Normal mode only, without remapping" {
  start_vim << 'EOF'
echo 'normal=' . maparg('<Leader>pp', 'n', 0, 1).noremap
echo 'visual=' . maparg('<Leader>pp', 'v')
EOF

  assert_line 'normal=1'
  assert_line 'visual='
}

#-----------------------------------------------------------------------------
@test "xdg-settings deletes old backups and keeps new ones" {
  local backup="$BATS_TEST_TMPDIR/state/vim/backup"
  mkdir -p "$backup"
  touch -d '100 days ago' "$backup/old"
  touch "$backup/new"

  start_vim << 'EOF'
echo 'global=' . exists('*CleanOldFiles')
EOF

  assert_line 'global=0'
  [[ ! -e $backup/old ]] || fail 'a 100-day-old backup was kept'
  [[ -e $backup/new ]] || fail 'a new backup was deleted'
}

#-----------------------------------------------------------------------------
@test "words added with zg go to the spell directory under XDG_DATA_HOME" {
  start_vim << 'EOF'
echo 'spellfile=' . &spellfile
EOF

  assert_line "spellfile=$BATS_TEST_TMPDIR/data/vim/spell/en.utf-8.add"
}

#-----------------------------------------------------------------------------
@test "setting the yaml filetype again lists yamllint once" {
  start_vim << 'EOF'
set filetype=yaml
set filetype=yaml
echo 'linters=' . string(b:ale_linters)
EOF

  assert_line "linters=['yamllint']"
}

#-----------------------------------------------------------------------------
@test "isort's poetry option is set for the Python buffer only" {
  stub isort
  start_vim << 'EOF'
set filetype=python
echo 'buffer=' . get(b:, 'ale_python_isort_auto_poetry', '')
echo 'global=' . exists('g:ale_python_isort_auto_poetry')
EOF

  assert_line 'buffer=1'
  assert_line 'global=0'
}

#-----------------------------------------------------------------------------
@test "shfmt's options are set for the sh buffer only" {
  start_vim << 'EOF'
set filetype=sh
echo 'buffer=' . get(b:, 'ale_sh_shfmt_options', '')
echo 'global=' . exists('g:ale_sh_shfmt_options')
EOF

  assert_line --partial 'buffer=--indent 2 '
  assert_line 'global=0'
}

#-----------------------------------------------------------------------------
@test "the gutter toggles are Normal-mode, non-remapping and script-local" {
  start_vim << 'EOF2'
for s:keys in ['<Leader>ln', '<Leader>signs']
  let s:noremap = maparg(s:keys, 'n', 0, 1).noremap
  echo s:keys . ' noremap=' . s:noremap . ' rhs=' . maparg(s:keys, 'n')
  echo s:keys . ' visual=' . maparg(s:keys, 'v')
endfor
echo 'global=' . exists('*ToggleLineNumbers') . exists('*ToggleSigns')
EOF2

  assert_line --regexp '^<Leader>ln noremap=1 rhs=.*<SNR>[0-9]+_ToggleLineNumbers\(\)'
  assert_line --regexp '^<Leader>signs noremap=1 rhs=.*<SNR>[0-9]+_ToggleSigns\(\)'
  assert_line '<Leader>ln visual='
  assert_line '<Leader>signs visual='
  assert_line 'global=00'
}

#-----------------------------------------------------------------------------
@test "<Leader>ln cycles absolute, relative, both, none" {
  start_vim << 'EOF2'
for s:i in range(4)
  execute "normal \\ln"
  echo 'step' . s:i . '=' . &number . &relativenumber
endfor
EOF2

  assert_line 'step0=01'
  assert_line 'step1=11'
  assert_line 'step2=00'
  assert_line 'step3=10'
}

#-----------------------------------------------------------------------------
@test "<Leader>signs hides the sign column and brings it back" {
  start_vim << 'EOF2'
execute "normal \\signs"
echo 'hidden=' . &signcolumn
execute "normal \\signs"
echo 'shown=' . &signcolumn
EOF2

  assert_line 'hidden=no'
  assert_line 'shown=number'
}
