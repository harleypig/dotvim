" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

" See http://nvie.com/posts/how-i-boosted-my-vim/ for more ideas

set nocompatible

" Stuff found in various places:
"   http://got-ravings.blogspot.com

" See .vim/after/ftplugin/perl.vim for perl specific settings.

"let &runtimepath = '/root/harleypig/.vim,' . &runtimepath . ',/root/harleypig/.vim/after'

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
helptags ~/.vim/doc

" Automatically reload this file when it's saved.
if !exists( "autoload_vimrc" )

  let autoload_vimrc = 1
  autocmd BufWritePost .vimrc source %

endif

" set verbose=0

colorscheme freya
set background=dark

filetype plugin indent on
syntax on

" Sort this section by doing the following (it will ignore the 'set no' or
" 'set   ' and sort by keywords :

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,6)cmp substr$b,6}@a'

"set   spell
set nocopyindent
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
set nowrap

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,4)cmp substr$b,4}@a'

set backupdir=/tmp,~/tmp
set clipboard+=unnamed
set directory=/tmp,~/tmp
set display=uhex,lastline
set encoding=utf-8
set formatoptions=tcroq1
set history=1000
set listchars=tab:>\
set mouse=
set numberwidth=5
set pastetoggle=<S-F1>
set path=.,$HOME
set report=1
set scrolloff=9999999
set shiftwidth=2
set shortmess=a
set softtabstop=2
set tabstop=2
set undolevels=1000
set updatetime=3000
set virtualedit=block
set whichwrap=b,s,<,>,[,]
set wildignore+=*/CVS/
set wildignore+=*/SVN/
set wildmode=list:longest,full

" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

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

" http://use.perl.org/~Ovid/journal/36297
autocmd FileType {vim,help} setlocal keywordprg=:help

source ~/.vim/statusline.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins Installed

" ShowMarks  http://www.vim.org/scripts/script.php?script_id=152
"            http://github.com/vim-scripts/showmarks
"            In .vim/bundle/showmarks

" let g:showmarks_hlline_lower=1

" VCSCommand http://www.vim.org/scripts/script.php?script_id=90
"            http://repo.or.cz/w/vcscommand.git
"            In .vim/bundle/vcscommand

" For statusline (VCSCommandGetStatusLine)
let g:VCSCommandEnableBufferSetup=1

" Syntastic  http://www.vim.org/scripts/script.php?script_id=2736
"            http://github.com/scrooloose/syntastic/
"            In .vim/bundle/syntastic

" Surround   http://www.vim.org/scripts/script.php?script_id=1697
"            http://github.com/tpope/vim-surround
"            In .vim/bundle/surround

" Align      http://www.vim.org/scripts/script.php?script_id=294
"            http://github.com/vim-scripts/Align
"            In .vim/bundle/align

" AutoAlign  http://www.vim.org/scripts/script.php?script_id=884
"            http://github.com/vim-scripts/AutoAlign
"            In .vim/bundle/autoalign

" Vim-Perl   http://github.com/petdance/vim-perl
"            In .vim/bundle/perl

" Pathogen http://github.com/tpope/vim-pathogen
"   http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
"   http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
"   In .vim/bundle/pathogen

" Github http://github.com/thinca/vim-github
"        In .vim/bundle/github

" PerlCritic https://github.com/mattfoster/vim-Perl-Critic
"            In .vim/bundle/perlcritic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins To Checkout

" AutoComplPop http://www.vim.org/scripts/script.php?script_id=1879
" Snipmate http://www.vim.org/scripts/script.php?script_id=2540
" PerlOmni http://www.vim.org/scripts/script.php?script_id=2852

