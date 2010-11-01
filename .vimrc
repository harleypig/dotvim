" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

" Automatically reload this file when it's saved.
if !exists( "autoload_vimrc" )

  let autoload_vimrc = 1
  autocmd BufWritePost ~/.vimrc source ~/.vimrc

endif

" set verbose=0

colorscheme freya
set background=dark

filetype plugin indent on
syntax on

helptags ~/.vim/doc

" Sort this section by doing the following (it will ignore the 'set no' or
" 'set   ' and sort by keywords :

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,6)cmp substr$b,6}@a'

set nocompatible
set   linebreak
set   magic
set   number
set   showcmd
set   showmatch
set   terse
set   title
set   wildmenu
set nowrap

set backupdir=/tmp,~/tmp
set clipboard+=unnamed
set directory=/tmp,~/tmp
set display=uhex,lastline
set encoding=utf-8
set history=1000
set mouse=
set pastetoggle=<S-F1>
set report=1
set scrolloff=9999999
set shortmess=a
set undolevels=1000
set updatetime=3000
set virtualedit=block
set whichwrap=b,s,<,>,[,]
set wildignore+=*/CVS/
set wildignore+=*/SVN/
set wildmode=list:longest,full

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous stuff

" Forget to sudo to edit a file? Use w!!
" via http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/96492#96492
cmap w!! %!sudo tee > /dev/null %

" Sort visually selected text by word
" c d a f e => a c d e f
" http://stackoverflow.com/questions/1327978/sorting-words-not-lines-in-vim
vnoremap <F2> d:execute 'normal i' . join(sort(split(getreg('"'))), '')<CR>"'))))'

" Add blank lines without going into insert mode
" http://stackoverflow.com/questions/3170348/insert-empty-lines-without-entering-insert-mode
map <Leader>O :<C-U>call append(line(".") -1, repeat([''], v:count1))<CR>
map <Leader>o :<C-U>call append(line("."), repeat([''], v:count1))<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the statusline
"   broken up for ease of manipulation and readability.

" Builtin
set statusline =%02n%m%r%h%w%y

" From vcscommand
set statusline+=%{VCSCommandGetStatusLine()}

" Builtin
set statusline+=[%02l/%02L\ %p%%][%c%V][%03b:%02B]

" End of Left Aligned, Begin of Right Aligned
set statusline+=%=

" From syntastic
set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%*

" Builtin
set statusline+=\ %F

set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins Installed

" ShowMarks  http://www.vim.org/scripts/script.php?script_id=152
"            http://github.com/vim-scripts/showmarks

let g:showmarks_hlline_lower=1

" VCSCommand http://www.vim.org/scripts/script.php?script_id=90
"            http://repo.or.cz/w/vcscommand.git

" For statusline (VCSCommandGetStatusLine)
let g:VCSCommandEnableBufferSetup=1

" Syntastic  http://www.vim.org/scripts/script.php?script_id=2736
"            http://github.com/scrooloose/syntastic/

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" Surround   http://www.vim.org/scripts/script.php?script_id=1697
"            http://github.com/tpope/vim-surround

" Align      http://www.vim.org/scripts/script.php?script_id=294
"            http://github.com/vim-scripts/Align

" AutoAlign  http://www.vim.org/scripts/script.php?script_id=884
"            http://github.com/vim-scripts/AutoAlign

" Vim-Perl   http://github.com/petdance/vim-perl

" See after/ftplugin/perl.vim for filetype specific settings.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins To Be Installed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check these plugins out

" Compare AutoClose
"   http://www.vim.org/scripts/script.php?script_id=1849 http://github.com/vim-scripts/Autoclose
"   http://www.vim.org/scripts/script.php?script_id=2009 http://github.com/vim-scripts/AutoClose--Alves

" Repeat http://www.vim.org/scripts/script.php?script_id=2136
"        http://github.com/tpope/vim-repeat

" Compare TVO with VOoM

" TVO    http://www.vim.org/scripts/script.php?script_id=517
"        http://github.com/vim-scripts/TVO--The-Vim-Outliner
"          http://github.com/vim-scripts/vimoutliner-colorscheme-fix

" VOoM   http://www.vim.org/scripts/script.php?script_id=2657
"        http://github.com/vim-scripts/VOoM

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rip off code from these projects for my own use

" Timestamp
" http://github.com/vim-scripts/timestamp
" http://github.com/vim-scripts/timestamp.vim

" Whitespace
" Turn trailing whitespace red: http://github.com/vim-scripts/trailing-whitespace.vim
" Auto trim trailing whitespace: http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/103606#103606
"   done in .vim/after/ftplugin/perl.vim Does it work? Do other places need it?

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ScrollColors - colorscheme scroller, chooser and browser
" http://www.vim.org/scripts/script.php?script_id=1488
"map <silent><Leader>nc :NEXTCOLOR<CR>
"map <silent><Leader>pc :PREVCOLOR<CR>

" CSApprox - Make gvim-only colorschemes work transparently in terminal vim
" http://www.vim.org/scripts/script.php?script_id=2390
"set t_Co=256

" bufferlist.vim : simple, fast, and slick non-disturbing buffer list
" http://www.vim.org/scripts/script.php?script_id=1325
"map <silent> <F3> :call BufferList()<CR>
"let g:BufferListWidth = 25
"let g:BufferListMaxWidth = 50
