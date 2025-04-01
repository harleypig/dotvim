" ----------------------------------------------------------------------------
" File Handling

set   autoread            " automatically read file when changed outside of Vim
set   encoding=utf-8      " character encoding used in Vim
set   history=1000        " number of command-lines that are remembered
set   undolevels=1000     " maximum number of changes that can be undone
set   updatecount=10      " after this many characters flush swap file
set   updatetime=1000     " time in msec after which the swap file will be updated

" ----------------------------------------------------------------------------
" UI Settings

set nocursorline          " don't highlight the screen line of the cursor
set nohidden              " don't keep buffers loaded when abandoned
set   list                " show <Tab> and <EOL>
set   listchars=tab:\ \   " list of strings used for list mode
set   showcmd             " show (partial) command in the last line of the screen
set   showmatch           " when inserting a bracket, briefly jump to its match
set   termguicolors       " use GUI colors for the terminal
set   terse               " shorten some messages
set   title               " show info in the window title
set   wildmenu            " command-line completion shows a list of matches
"set   spell              " enable spell checking

" ----------------------------------------------------------------------------
" Visual Preferences

set   background=dark     " background color brightness
set   hlsearch            " highlight all matches for the last used search pattern

" ----------------------------------------------------------------------------
" Editing Behavior

set   clipboard+=unnamed  " use the * register in addition to the unnamed register
set   matchpairs+=<:>     " pairs of characters that "%" can match
set   mouse=              " disable mouse usage
set   path=.,$HOME        " list of directories searched with "gf" etc.
"set   pastetoggle=<leader>pt  " key sequence to toggle paste mode
set   report=1            " threshold for reporting number of lines changed
set   shortmess=a         " use abbreviations in messages
set   virtualedit=block   " allow virtual editing in Visual block mode

" ----------------------------------------------------------------------------
" File Navigation

set   wildignore+=*/.git/ " patterns to ignore when expanding wildcards
set   wildignore+=*/CVS/
set   wildignore+=*/SVN/
set   wildmode=list:longest,full  " specifies how command line completion works

" ----------------------------------------------------------------------------
" Text Wrapping

set   formatoptions=tcroq1  " how automatic formatting works
set   wrapmargin=2          " margin from the right where wrapping starts
set   backspace=indent,eol,start  " how backspace works at start of line
set   textwidth=78          " maximum width of text being inserted

" ----------------------------------------------------------------------------
" Indenting

set   autoindent      " automatically set the indent of a new line
set   smartindent     " do clever autoindenting
set nocopyindent      " don't copy indent structure from previous line
set   shiftwidth=2    " number of spaces used for each step of (auto)indent
set   softtabstop=2   " number of spaces to insert for a <Tab>
set   expandtab       " use spaces when <Tab> is inserted
set   tabstop=2       " number of spaces a <Tab> in the text stands for

" ----------------------------------------------------------------------------
" Terminal Settings

" See http://www.shallowsky.com/linux/noaltscreen.html for an explanation of
" set t_ti= t_te=

set   t_te=
set   t_ti=

" ----------------------------------------------------------------------------
" Movement

set   whichwrap=b,s,<,>,[,] " list of flags specifying which commands wrap to another line
set noautochdir             " change to directory of file in buffer
set   wrapscan              " search commands wrap around the end of the buffer
set   incsearch             " show match for partly typed search command
set   magic                 " change the way backslashes are used in search patterns
set   ignorecase            " ignore case when using a search pattern
set   smartcase             " override 'ignorecase' when pattern has upper case characters

" ----------------------------------------------------------------------------
" Display

set   scroll=11             " number of lines to scroll for CTRL-U and CTRL-D
set   scrolloff=999999      " number of screen lines to show around the cursor
set   wrap                  " long lines wrap
set   linebreak             " wrap long lines at a character in 'breakat'
set   display=uhex,lastline " include "lastline" to show the last line even if it doesn't fit
set   foldlevelstart=99     " start editing with all folds opened
set   concealcursor=nc      " modes in which text in the cursor line can be concealed
