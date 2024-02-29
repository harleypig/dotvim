"let g:coc_disable_startup_warning = 1

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ exists('b:_copilot') ? copilot#Accept("\<CR>") :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Use <cr> to confirm completion, <c-g>u to break undo chain.
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion if not using copilot.
inoremap <silent><expr> <c-@> exists('b:_copilot') ? "\<C-@>" : coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Navigate through issues using quickfix list
nmap <silent> c[ :cprevious<CR>
nmap <silent> c] :cnext<CR>




