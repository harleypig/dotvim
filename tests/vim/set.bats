#!/usr/bin/env bats

# The options the late set.vim sets, read after a full startup on an empty
# buffer, so a later settings file that sets one again is caught too. One
# test per section of set.vim.
#
# The Terminal Settings section is not tested: Vim in silent Ex mode loads
# no termcap, so t_ti and t_te are empty whatever set.vim does.
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

#-----------------------------------------------------------------------------
# start_vim OPTION... - run Vim, then write v:errmsg, whether this Vim has a
# working 'clipboard' option, and each OPTION's value as OPTION=VALUE to
# $report, and load it as $output.
start_vim() {
  local tmp="$BATS_TEST_TMPDIR" option

  {
    echo "redir! > $report"
    echo "echo 'errmsg=' . v:errmsg"
    echo "echo 'has_clipboard=' . exists('+clipboard')"

    for option in "$@"; do
      echo "echo '$option=' . &$option"
    done

    echo 'redir END'
    echo 'qa!'
  } > "$tmp/report.vim"

  headless_vim -S "$tmp/report.vim" || true

  run cat "$report"

  assert_line 'errmsg='
}

##############################################################################
#-----------------------------------------------------------------------------
# Patience matches unique lines first, so a moved or repeated block is less
# often split into a confusing interleave of small hunks.
@test "diff uses the patience algorithm, keeping Vim's other diff options" {
  start_vim diffopt

  assert_line --regexp '^diffopt=(.*,)?algorithm:patience(,.*)?$'
  assert_line --regexp '^diffopt=(.*,)?internal(,.*)?$'
}

#-----------------------------------------------------------------------------
@test "file handling: autoread, utf-8, long history and undo, frequent swap" {
  start_vim autoread encoding history undolevels updatecount updatetime

  assert_line 'autoread=1'
  assert_line 'encoding=utf-8'
  assert_line 'history=1000'
  assert_line 'undolevels=1000'
  assert_line 'updatecount=10'
  assert_line 'updatetime=1000'
}

#-----------------------------------------------------------------------------
@test "UI: list with blank tabs, GUI colours, no cursorline or hidden" {
  start_vim cursorline hidden list listchars showcmd showmatch \
    termguicolors title wildmenu background hlsearch

  assert_line 'cursorline=0'
  assert_line 'hidden=0'
  assert_line 'list=1'
  assert_line 'listchars=tab:  '
  assert_line 'showcmd=1'
  assert_line 'showmatch=1'
  assert_line 'termguicolors=1'
  assert_line 'title=1'
  assert_line 'wildmenu=1'
  assert_line 'background=dark'
  assert_line 'hlsearch=1'
}

#-----------------------------------------------------------------------------
@test "editing: unnamed clipboard, <> pairs, no mouse, path of . and HOME" {
  start_vim clipboard matchpairs mouse path report shortmess virtualedit

  # A Vim built without +clipboard, as CI's is, has no working 'clipboard'
  # option: set.vim's line does nothing there and the option reads empty.
  if [[ " ${lines[*]} " == *' has_clipboard=1 '* ]]; then
    assert_line --regexp '^clipboard=(.*,)?unnamed(,.*)?$'
  else
    assert_line 'clipboard='
  fi

  assert_line --regexp '^matchpairs=(.*,)?<:>$'
  assert_line --regexp '^matchpairs=(.*,)?\(:\)(,.*)?$'
  assert_line 'mouse='
  assert_line "path=.,$home"
  assert_line 'report=1'
  assert_line 'shortmess=a'
  assert_line 'virtualedit=block'
}

#-----------------------------------------------------------------------------
@test "navigation: VCS directories ignored, list-then-full completion" {
  start_vim wildignore wildmode

  assert_line --regexp '^wildignore=(.*,)?\*/\.git/(,.*)?$'
  assert_line --regexp '^wildignore=(.*,)?\*/CVS/(,.*)?$'
  assert_line --regexp '^wildignore=(.*,)?\*/SVN/(,.*)?$'
  assert_line 'wildmode=list:longest,full'
}

#-----------------------------------------------------------------------------
@test "wrapping: format options, backspace over everything, 78 columns" {
  start_vim formatoptions backspace textwidth

  assert_line 'formatoptions=tcroq1'
  assert_line 'backspace=indent,eol,start'
  assert_line 'textwidth=78'
}

#-----------------------------------------------------------------------------
@test "indenting: two spaces, expanded, smart but not copied" {
  start_vim autoindent smartindent copyindent shiftwidth softtabstop \
    expandtab tabstop

  assert_line 'autoindent=1'
  assert_line 'smartindent=1'
  assert_line 'copyindent=0'
  assert_line 'shiftwidth=2'
  assert_line 'softtabstop=2'
  assert_line 'expandtab=1'
  assert_line 'tabstop=2'
}

#-----------------------------------------------------------------------------
@test "movement: wrapping keys, smart-case incremental search" {
  start_vim whichwrap autochdir wrapscan incsearch magic ignorecase \
    smartcase

  assert_line 'whichwrap=b,s,<,>,[,]'
  assert_line 'autochdir=0'
  assert_line 'wrapscan=1'
  assert_line 'incsearch=1'
  assert_line 'magic=1'
  assert_line 'ignorecase=1'
  assert_line 'smartcase=1'
}

#-----------------------------------------------------------------------------
# scrolloff that large keeps the cursor line in the middle of the window.
@test "display: centred cursor, wrapped at word breaks, folds open" {
  start_vim scrolloff wrap linebreak display foldlevelstart concealcursor

  assert_line 'scrolloff=999999'
  assert_line 'wrap=1'
  assert_line 'linebreak=1'
  assert_line 'display=uhex,lastline'
  assert_line 'foldlevelstart=99'
  assert_line 'concealcursor=nc'
}
