#!/usr/bin/env bats

# The pieces of the late after/plugin/statusline.vim's statusline, called
# directly: each branch of YASL_BufferInfo() and YASL_Warnings(), the
# boundaries YASL_FileSize() rounds at, and the statusline that puts them
# together. statusline.bats checks how the warnings refresh and how
# YASL_LinterStatus() formats ALE's counts.
#
# Vim runs headless through helpers/vim.bash.

bats_load_library bats-support
bats_load_library bats-assert
load helpers/vim

##############################################################################
#-----------------------------------------------------------------------------
setup() {
  vim_fixture

  file="$BATS_TEST_TMPDIR/file.txt"
}

#-----------------------------------------------------------------------------
# run_vim [VIM ARGS...] - run Vim, then the Vim script read from stdin with
# its messages redirected to $report, and load $report as $output.
run_vim() {
  local tmp="$BATS_TEST_TMPDIR"

  {
    echo "redir! > $report"
    cat
    echo "echo 'errmsg=' . v:errmsg"
    echo 'redir END'
    echo 'qa!'
  } > "$tmp/test.vim"

  headless_vim -- "$@" -S "$tmp/test.vim" || true

  run cat "$report"

  assert_line 'errmsg='
}

#-----------------------------------------------------------------------------
# sized BYTES - make $file BYTES long.
sized() {
  : > "$file"
  truncate -s "$1" "$file"
}

##############################################################################
#-----------------------------------------------------------------------------
@test "the buffer info shows the number, filetype and a plain buffer's state" {
  run_vim <<'EOF'
echo 'empty=' . YASL_BufferInfo()
setlocal filetype=text
echo 'filetype=' . YASL_BufferInfo()
call setline(1, 'changed')
echo 'modified=' . YASL_BufferInfo()
for s:n in range(2, 12)
  execute 'badd' 'buffer' . s:n
endfor
buffer! 2
echo 'one_digit=' . YASL_BufferInfo()
buffer! 12
echo 'two_digits=' . YASL_BufferInfo()
EOF

  assert_line 'empty=[01 none -]'
  assert_line 'filetype=[01 text -]'
  assert_line 'modified=[01 text +]'
  assert_line 'one_digit=[02 none -]'
  assert_line 'two_digits=[12 none -]'
}

#-----------------------------------------------------------------------------
# Not modifiable is checked first, so it shows alone even on a read-only
# buffer with changes.
@test "the buffer info marks read-only and unmodifiable buffers" {
  run_vim <<'EOF'
setlocal readonly
echo 'readonly=' . YASL_BufferInfo()
call setline(1, 'changed')
echo 'modified_readonly=' . YASL_BufferInfo()
setlocal nomodifiable
echo 'not_modifiable=' . YASL_BufferInfo()
EOF

  assert_line 'readonly=[01 none RO]'
  assert_line 'modified_readonly=[01 none +RO]'
  assert_line 'not_modifiable=[01 none X]'
}

#-----------------------------------------------------------------------------
@test "the file size is blank, bytes, or KiB, until 1 MiB is too big" {
  local bytes

  for bytes in 0 1 1023 1024 1048575 1048576; do
    sized "$bytes"
    cp "$file" "$BATS_TEST_TMPDIR/$bytes"
  done

  run_vim <<EOF
echo 'unsaved=' . YASL_FileSize()
for s:bytes in [0, 1, 1023, 1024, 1048575, 1048576]
  execute 'edit' fnameescape('$BATS_TEST_TMPDIR/' . s:bytes)
  echo s:bytes . '=' . YASL_FileSize()
endfor
EOF

  assert_line 'unsaved='
  assert_line '0='
  assert_line '1=1'
  assert_line '1023=1023'
  assert_line '1024=1k'
  assert_line '1048575=1023k'
  assert_line '1048576=TooDamnBig!'
}

#-----------------------------------------------------------------------------
@test "a clean buffer has no warnings" {
  printf 'text\n' > "$file"

  run_vim "$file" <<'EOF'
echo 'warnings=' . YASL_Warnings()
EOF

  assert_line 'warnings='
}

#-----------------------------------------------------------------------------
@test "a file not in unix format or not utf-8 is flagged" {
  printf 'text\r\n' > "$file"

  run_vim "$file" <<'EOF'
echo 'format=' . YASL_Warnings()
setlocal fileformat=unix fileencoding=latin1
echo 'encoding=' . YASL_Warnings()
setlocal fileencoding=utf-8
echo 'utf8=' . YASL_Warnings()
EOF

  assert_line 'format=*dos*'
  assert_line 'encoding=*latin1*'
  assert_line 'utf8='
}

#-----------------------------------------------------------------------------
# Each check is cleared before the next, since the indent result is kept
# until CursorHold.
@test "indenting that does not match expandtab is flagged" {
  printf '  spaces\n' > "$file"

  run_vim "$file" <<'EOF'
setlocal noexpandtab
echo 'spaces_noet=' . YASL_Warnings()
call setline(1, "\ttab")
setlocal expandtab
unlet b:statusline_tab_warning
echo 'tabs_et=' . YASL_Warnings()
setlocal noexpandtab
unlet b:statusline_tab_warning
echo 'tabs_noet=' . YASL_Warnings()
EOF

  assert_line 'spaces_noet=[&et]'
  assert_line 'tabs_et=[&et]'
  assert_line 'tabs_noet='
}

#-----------------------------------------------------------------------------
@test "a help buffer gets no indent or trailing-space warning" {
  printf '\tone  \n  two\n' > "$file"

  run_vim "$file" <<'EOF'
setlocal filetype=help
echo 'help=' . YASL_Warnings()
EOF

  assert_line 'help='
}

#-----------------------------------------------------------------------------
@test "paste mode is flagged, after the other warnings" {
  printf '\tone  \n  two\n' > "$file"

  run_vim "$file" <<'EOF'
setlocal fileformat=mac
set paste
echo 'all=' . YASL_Warnings()
EOF

  assert_line 'all=*mac* [mixed indenting] [trailing space] [PASTE]'
}

#-----------------------------------------------------------------------------
@test "the statusline is always shown and puts the pieces together" {
  run_vim <<'EOF'
echo 'laststatus=' . &laststatus
echo 'statusline=' . &statusline
EOF

  assert_line 'laststatus=2'
  assert_line --regexp '^statusline=%\{YASL_BufferInfo\(\)\}%#warningmsg#%\(%\{YASL_Warnings\(\)\}%\)%\{%YASL_LinterStatus\(\)%\}%\*\[.*%\{YASL_FileSize\(\)\}\]'
}
