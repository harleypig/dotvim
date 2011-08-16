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
"set nowrap

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

iab dbs $DB::single = 1;<ESC>

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

" He got tired of typing this over and over again too.
" https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>

" http://use.perl.org/~Ovid/journal/36297
autocmd FileType {vim,help} setlocal keywordprg=:help

" http://vim.wikia.com/wiki/Modeline_magic
" Append modeline after last line in buffer.

function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :", &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(0, l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

"https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
""=====[ Highlight cursor (plus row and column on request) ]===================
"
"" Inverse highlighting for cursor...
"highlight CursorInverse   term=inverse ctermfg=black ctermbg=white
"call matchadd('CursorInverse', '\%#', 100)
"
"" Need an invisible cursor column to make it update on every cursor move...
"highlight clear CursorColumn
"highlight CursorColumn term=none cterm=none
"set cursorcolumn
"
"" Toggle cursor row highlighting on request...
"highlight CursorLine   term=bold ctermfg=black ctermbg=cyan  cterm=bold
"map <silent> ;r :set cursorline!<CR>
"
"" Toggle cursor column highlighting on request...
"map <silent> ;c :silent call Toggle_CursorColumn('flip')<CR>
"
"" Implement cursor toggle...
"let g:cursorcolumn_visible = 0
"function! Toggle_CursorColumn (requested_state)
"    if a:requested_state == 'off' || g:cursorcolumn_visible && a:requested_state == 'flip'
"        let g:cursorcolumn_visible = 0
"        highlight clear CursorColumn
"        highlight CursorColumn term=none cterm=none
"    else
"        let g:cursorcolumn_visible = 1
"        highlight CursorColumn term=bold ctermfg=black ctermbg=cyan cterm=bold
"    endif
"endfunction
"
""=====[ Highlight spelling errors on request ]===================
"
"set spelllang=en_au
"map <silent> ;s :setlocal invspell<CR>

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

" Pathogen   http://github.com/tpope/vim-pathogen
"            http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
"            http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
"            In .vim/bundle/pathogen

" Github     http://github.com/thinca/vim-github
"            In .vim/bundle/github

" PerlCritic https://github.com/mattfoster/vim-Perl-Critic
"            In .vim/bundle/perlcritic

" VimWiki    http://code.google.com/p/vimwiki/
"            Installed as a vimball
"            git show --pretty="format:" --name-only 98bf498 shows:
"
"            .vim/.VimballRecord
"            .vim/autoload/vimwiki/base.vim
"            .vim/autoload/vimwiki/default.tpl
"            .vim/autoload/vimwiki/diary.vim
"            .vim/autoload/vimwiki/html.vim
"            .vim/autoload/vimwiki/lst.vim
"            .vim/autoload/vimwiki/style.css
"            .vim/autoload/vimwiki/tbl.vim
"            .vim/doc/tags <------------------- file was changed, not added
"            .vim/doc/vimwiki.txt
"            .vim/ftplugin/vimwiki.vim
"            .vim/plugin/vimwiki.vim
"            .vim/syntax/vimwiki.vim
"            .vim/syntax/vimwiki_default.vim
"            .vim/syntax/vimwiki_media.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins To Checkout

" AutoComplPop http://www.vim.org/scripts/script.php?script_id=1879
" Snipmate http://www.vim.org/scripts/script.php?script_id=2540
" PerlOmni http://www.vim.org/scripts/script.php?script_id=2852

