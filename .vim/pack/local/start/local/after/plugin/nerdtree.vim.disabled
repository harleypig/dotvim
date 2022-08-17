" From, or inspired by, the readme for this project
" https://github.com/preservim/nerdtree

" XXX: Some of this (like the autocmd?) should be moved to a ftplugin file ...

nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFocus<CR>

function! s:syncTree()
  let s:curwnum = winnr()
  NERDTreeFind
  exec s:curwnum . "wincmd w"
endfunction

function! s:syncTreeIf()
  if(winnr("$") > 1)
    call s:syncTree()
  endif
endfunction

autocmd BufEnter * call s:syncTreeIf()

" Automatically close vim if only NERDTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Focus on opened view after starting (instead of NERDTree)
autocmd VimEnter * call s:syncTree()
au VimEnter * :wincmd w

" Auto refresh NERDTree files
autocmd CursorHold,CursorHoldI * if (winnr("$") > 1) | call NERDTreeFocus() | call g:NERDTree.ForCurrentTab().getRoot().refresh() | call g:NERDTree.ForCurrentTab().render() | wincmd w | endif

" Show/Hide NERDTree
:nmap <expr> \a (winnr("$") == 1) ? ':NERDTreeFind<CR>' : ':wincmd o<CR>'

" Prevent this command activation in NERDTree
autocmd FileType nerdtree noremap <buffer> \a <nop>

let NERDTreeShowHidden=1
