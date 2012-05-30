" Sort this section by doing the following (it will ignore the 'set no' or
" 'set   ' and sort by keywords :

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,6)cmp substr$b,6}@a'

set   autoindent
set nocopyindent
set nocursorline
set   expandtab
set nohidden
set   hlsearch
set   ignorecase
set   incsearch
set   linebreak
set   list
set   magic
set   number
set   showcmd
set   showmatch
set   smartcase
set   smartindent
set   terse
set   title
set   wildmenu
"set   spell

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,4)cmp substr$b,4}@a'

set background=dark
set backupdir=/tmp,~/tmp
set clipboard+=unnamed
set directory=/tmp,~/tmp
set display=uhex,lastline
set encoding=utf-8
set formatoptions=tcroq1
set history=1000
set listchars=
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
set viminfo=h,%10,'50,s1000
set virtualedit=block
set whichwrap=b,s,<,>,[,]
set wildignore+=*/.git/
set wildignore+=*/CVS/
set wildignore+=*/SVN/
set wildmode=list:longest,full
set wrapmargin=2
