" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

" See http://nvie.com/posts/how-i-boosted-my-vim/ for more ideas

" Lookit this:
" http://www.gregsexton.org/2011/04/enhancing-window-movement-and-positioning-in-vim/
" https://github.com/gmarik/vundle - replacement for pathogen?

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

"set t_Co=256
colorscheme desert
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
"set listchars=tab:>\
"set listchars=tab:\ \
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

" Gently lifted from http://mg.pov.lt/vim/vimrc
" Show ↪ at the beginning of wrapped lines
if has("linebreak")
  let &sbr = nr2char(8618) . ' '
endif

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
vnoremap <F2> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>"'))))'

" Add blank lines without going into insert mode
" http://stackoverflow.com/questions/3170348/insert-empty-lines-without-entering-insert-mode
map <Leader>O :<C-U>call append(line(".") -1, repeat([''], v:count1))<CR>
map <Leader>o :<C-U>call append(line("."), repeat([''], v:count1))<CR>

" He got tired of typing this over and over again too.
" https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>

" http://vimbits.com/bits/323
" list buffers and switch to a buffer quickly
nmap <leader>b :ls<CR>:buffer<Space>

" http://vimbits.com/bits/11
" make Y consistent with D, C, A, etc.
map Y y$

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

" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/95139#95139
" Comment to this answer: Instead of manually typing nohlsearch, try mapping
" it. Ctrl-L already redraws the screen, so I make it also and remove search
" highlighting: ... pydave Feb 23 at 19:04
nnoremap <silent> <C-l> :nohl<CR><C-l>

" http://vimbits.com/bits/380
" This changes the behavior of the very useful . command to leave the cursor at the point where it was before editing started.
nnoremap . .`[

" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
fu! CustomFoldText()

  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile

  if fs > v:foldend
      let line = getline(v:foldstart)
  else
      let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let lineCount = line("$")
  let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))

  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr

endf
set foldtext=CustomFoldText()

source ~/.vim/statusline.vim
source ~/.vim/plugininfo.vim

"http://geekblog.oneandoneis2.org/index.php/2012/02/15/cuz-multiple-steps-into-one-is-cool
