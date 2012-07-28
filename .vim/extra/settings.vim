" Sort this section by doing the following (it will ignore the 'set no' or
" 'set   ' and sort by keywords :

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,6)cmp substr$b,6}@a'

set   autoread
set nocursorline
set   expandtab
set nohidden
set   linebreak
set   list
set   magic
set   number
set   showcmd
set   showmatch
set   terse
set   title
set   wildmenu
"set   spell

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,4)cmp substr$b,4}@a'

set background=dark
set backupdir=/tmp,~/tmp
set backspace=indent,eol,start
set clipboard+=unnamed
set directory=/tmp,~/tmp
set display=uhex,lastline
set encoding=utf-8
set history=1000
set listchars=
set matchpairs+=<:>
set mouse=
set numberwidth=5
set pastetoggle=<Leader>paste
set path=.,$HOME
set report=1
set scrolloff=9999999
set shiftwidth=2
set shortmess=a
set softtabstop=2
set tabstop=2
set textwidth=132
set undolevels=1000
set updatecount=10
set updatetime=3000
set viminfo=h,%10,'50,s1000,/1000,:1000
set virtualedit=block
set whichwrap=b,s,<,>,[,]
set wildignore+=*/.git/
set wildignore+=*/CVS/
set wildignore+=*/SVN/
set wildmode=list:longest,full

" Search
set   ignorecase
set   incsearch
set   smartcase
set   hlsearch

" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/95139#95139
" Comment to this answer: Instead of manually typing nohlsearch, try mapping
" it. Ctrl-L already redraws the screen, so I make it also and remove search
" highlighting: ... pydave Feb 23 at 19:04
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Smart wrapping
set   formatoptions=tcroq1
set   wrapmargin=2
set   autoindent
set   smartindent
set nocopyindent

