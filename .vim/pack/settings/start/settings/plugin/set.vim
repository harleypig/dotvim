" iF you are having issues with some language servers, add the following to
" either this file or, preferably, the ftplugin for that filetype.
" See https://github.com/neoclide/coc.nvim/issues/649
"
" set nobackup
" set nowritebackup

" I don't need the -i, apparently my aliases are being loaded now.
"set   shellcmdflag=-ic

set   autoread
set nocursorline
set   expandtab
set nohidden
set   list
set   number
set   showcmd
set   showmatch
set   termguicolors
set   terse
set   title
set   wildmenu
"set   spell

set   background=dark
set   backupdir=/tmp,~/tmp
set   clipboard+=unnamed
set   directory=/tmp,~/tmp
set   encoding=utf-8
set   history=1000
set   listchars=
set   matchpairs+=<:>
set   mouse=
set   numberwidth=5
set   path=.,$HOME
"set   pastetoggle=<leader>pt
set   report=1
set   shortmess=a
set   signcolumn=number
set   softtabstop=2
set   tabstop=2
set   undolevels=1000
set   updatecount=10
set   updatetime=1000
set   viminfo=h,%10,'50,s1000,/1000,:1000
set   virtualedit=block
set   wildignore+=*/.git/
set   wildignore+=*/CVS/
set   wildignore+=*/SVN/
set   wildmode=list:longest,full

set   hlsearch

"===========================================================================================
" Refactor starts here

" Wrapping
set   formatoptions=tcroq1
set   wrapmargin=2
set   backspace=indent,eol,start
set   textwidth=78

" Indenting
set   autoindent
set   smartindent
set nocopyindent
set   shiftwidth=2

" See http://www.shallowsky.com/linux/noaltscreen.html for an explanation of set t_ti= t_te=
set   t_te=
set   t_ti=

" Movement

set   whichwrap=b,s,<,>,[,] " list of flags specifying which commands wrap to another line
set noautochdir             " change to directory of file in buffer
set   wrapscan              " search commands wrap around the end of the buffer
set   incsearch             " show match for partly typed search command
set   magic                 " change the way backslashes are used in search patterns
set   ignorecase            " ignore case when using a search pattern
set   smartcase             " override 'ignorecase' when pattern has upper case characters

" Display

set   scroll=11 " number of lines to scroll for CTRL-U and CTRL-D
set   scrolloff=999999 " number of screen lines to show around the cursor
set   wrap  " long lines wrap
set   linebreak  " wrap long lines at a character in 'breakat'
set   display=uhex,lastline " include "lastline" to show the last line even if it doesn't fit
set   foldlevelstart=99 " start editing with all folds opened
set   concealcursor=nc
