
" !!! See what you can rip off from vim-sensible!
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim

" Sort this section by doing the following (it will ignore the 'set no' or
" 'set   ' and sort by keywords :

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,6)cmp substr$b,6}@a'

set   autoread
set nocursorline
set   expandtab
set nohidden
"set   list " This overrides SpaceHi, so don't set it.
set   number
set   showcmd
set   showmatch
set   terse
set   title
set   wildmenu
"set   spell

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,4)cmp substr$b,4}@a'

set   background=dark
set   backupdir=/tmp,~/tmp
set   clipboard+=unnamed
set   directory=/tmp,~/tmp
set   encoding=utf-8
set   history=1000
"set   listchars=
set   matchpairs+=<:>
set   mouse=
set   numberwidth=5
set   pastetoggle=<Leader>paste
set   path=.,$HOME
set   report=1
set   shortmess=a
set   softtabstop=2
set   tabstop=2
set   undolevels=1000
set   updatecount=10
set   updatetime=3000
set   viminfo=h,%10,'50,s1000,/1000,:1000
set   virtualedit=block
set   wildignore+=*/.git/
set   wildignore+=*/CVS/
set   wildignore+=*/SVN/
set   wildmode=list:longest,full

set   hlsearch

" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/95139#95139
" Comment to this answer: Instead of manually typing nohlsearch, try mapping
" it. Ctrl-L already redraws the screen, so I make it also and remove search
" highlighting: ... pydave Feb 23 at 19:04
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

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

"===========================================================================================
" Refactor starts here

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
set   concealcursor=nc
