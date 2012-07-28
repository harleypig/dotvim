"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous stuff

" http://geekblog.oneandoneis2.org/index.php/2012/02/15/cuz-multiple-steps-into-one-is-cool
" http://got-ravings.blogspot.com
" http://nvie.com/posts/how-i-boosted-my-vim/ for more ideas
" https://github.com/amix/vimrc
" https://github.com/gmarik/vundle - replacement for pathogen?
" https://github.com/zendeavor/dotvim
" http://www.gregsexton.org/2011/04/enhancing-window-movement-and-positioning-in-vim/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

" Forget to sudo to edit a file? Use w!!
" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/96492#96492
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

" Toggle syntax highlighting (also from Damian Conway)
nmap <silent> <leader>y : if exists("syntax_on") <BAR> syntax off <BAR> else <BAR> syntax enable <BAR> endif<CR>

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

" :h 2html
" :h TOHtml
let g:html_no_progress   = 1
let g:html_number_lines  = 0
let g:html_dynamic_folds = 1
let g:html_use_xhtml     = 1

" Gently lifted from http://mg.pov.lt/vim/vimrc
" Show ↪ at the beginning of wrapped lines
"if has("linebreak")
"  let &sbr = nr2char(8618) . ' '
"endif

"https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
"=====[ Highlight cursor (plus row and column on request) ]===================
"
" Inverse highlighting for cursor...
"highlight CursorInverse   term=inverse ctermfg=black ctermbg=white
"call matchadd('CursorInverse', '\%#', 100)
"
" Need an invisible cursor column to make it update on every cursor move...
"highlight clear CursorColumn
"highlight CursorColumn term=none cterm=none
"set cursorcolumn
"
" Toggle cursor row highlighting on request...
"highlight CursorLine   term=bold ctermfg=black ctermbg=cyan  cterm=bold
"map <silent> ;r :set cursorline!<CR>
"
" Toggle cursor column highlighting on request...
"map <silent> ;c :silent call Toggle_CursorColumn('flip')<CR>
"
" Implement cursor toggle...
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

"=====[ Highlight spelling errors on request ]===================
"set spelllang=en_us
"nmap <silent> ;s :setlocal invspell<CR>
