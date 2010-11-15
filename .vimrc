" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

" Stuff found in various places:
"   http://got-ravings.blogspot.com

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
set nocompatible
set   expandtab
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
set listchars=tab:>\ ,trail:*
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

let g:StatuslineTrailingSpaceText = '\s'
let g:StatuslineExpandTabText = '&et'
let g:StatuslineMixedIndentText = 'mixed-indenting'

set statusline=
set statusline+=[%02n
set statusline+=%(\ %{strlen(&filetype)?&filetype:'none'}%)
set statusline+=%#warningmsg#
set statusline+=%(\ %{&modifiable?&modified?'+':'':'X'}%)
set statusline+=%(\ %{&fileformat!='unix'?'*'.&fileformat.'*':''}%)
set statusline+=%(\ %{(&fileencoding!='utf-8'&&&fileencoding!='')?'*'.&fileencoding.'*':''}%)
set statusline+=%(\ %{StatuslineMixedIndentWarning()}%)
set statusline+=%(\ %{StatuslineTrailingSpaceWarning()}%)
set statusline+=%(\ %{SyntasticStatuslineFlag()}%)
set statusline+=%*]

" Informational
set statusline+=[%02l/%02L\ %p%%\ %{FileSize()}][%c%V][%03b:%02B]
set statusline+=%{VCSCommandGetStatusLine()}
set statusline+=\ %{synIDattr(synID(line('.'),col('.'),1),'name')}
"set statusline+=%{strftime('%D\ %T',getftime(expand('%:p')))}

" Middle (end of left justified, begin right justified)
set statusline+=%=%F

set laststatus=2

" found @ http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
function! FileSize()
  let bytes = getfsize(expand("%:p"))

  if bytes <= 0
    return ''
  else
    return bytes . 'b'
  endif
endfunction

"recalculate the warnings when idle or after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

function! StatuslineMixedIndentWarning()

  if (&filetype == 'help')
    return ''
  endif

  if !exists("g:StatuslineMixedIndentText")
    let g:StatuslineMixedIndentText = '[mixed-indenting]'
  endif

  if !exists("g:StatuslineExpandTabText")
    let g:StatuslineExpandTabText = '[&et]'
  endif

  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning = g:StatuslineMixedIndentText
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = g:StatuslineExpandTabText
    else
      let b:statusline_tab_warning = ''
    endif
  endif

  return b:statusline_tab_warning
endfunction

function! StatuslineTrailingSpaceWarning()

  if (&filetype == 'help')
    return ''
  endif

  if !exists("g:StatuslineTrailingSpaceText")
    let g:StatuslineTrailingSpaceText = ' \s'
  endif

  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = g:StatuslineTrailingSpaceText
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif

  return b:statusline_trailing_space_warning
endfunction

"function! InsertStatuslineColor(mode)
"  if a:mode == 'i'
"    hi statusline ctermbg=0
"  elseif a:mode == 'r'
"    hi statusline ctermbg=3
"  else
"    hi statusline ctermbg=5
"  endif
"endfunction
"
"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi statusline ctermbg=4
"
"hi statusline term=bold cterm=bold ctermfg=3 ctermbg=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins Installed

" ShowMarks  http://www.vim.org/scripts/script.php?script_id=152
"            http://github.com/vim-scripts/showmarks

" let g:showmarks_hlline_lower=1

" VCSCommand http://www.vim.org/scripts/script.php?script_id=90
"            http://repo.or.cz/w/vcscommand.git

" For statusline (VCSCommandGetStatusLine)
let g:VCSCommandEnableBufferSetup=1

" Syntastic  http://www.vim.org/scripts/script.php?script_id=2736
"            http://github.com/scrooloose/syntastic/

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_perl_efm_program='~/.vim/tools/efm_perl.pl'

" Surround   http://www.vim.org/scripts/script.php?script_id=1697
"            http://github.com/tpope/vim-surround

" Align      http://www.vim.org/scripts/script.php?script_id=294
"            http://github.com/vim-scripts/Align

" AutoAlign  http://www.vim.org/scripts/script.php?script_id=884
"            http://github.com/vim-scripts/AutoAlign

" Vim-Perl   http://github.com/petdance/vim-perl

" See after/ftplugin/perl.vim for perl specific settings.
