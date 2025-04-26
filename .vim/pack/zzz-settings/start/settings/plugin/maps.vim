""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is a setting, but I'm putting it here because it's actings as
" a mapping.
"set   pastetoggle=<Leader>pp

" README: Toggle paste mode.
map <leader>pp :set paste!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" README: Open terminal in a new window below the current window. Will not be
" included in a sessions file.
map <leader>tt :botright terminal ++norestore<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/95139#95139
" Comment to this answer: Instead of manually typing nohlsearch, try mapping
" it. Ctrl-L already redraws the screen, so I make it also and remove search
" highlighting: ... pydave Feb 23 at 19:04
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Requires vim-eunuch.
if exists('g:loaded_eunuch')
  " Use Sudowrite instead of write.
  cmap w!! :call Sudowrite()
else
  cmap w!! %!sudo tee > /dev/null %
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Manual formatting with ALE
nmap <leader>fb <Plug>(ale_fix)

" CoC diagnostics navigation
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

command! QuickfixToggle call quickfixtoggle#toggle()

nnoremap <leader>q] <Cmd>cnext<CR>
nnoremap <leader>q[ <Cmd>cprevious<CR>
nnoremap <leader>qf <Cmd>QuickfixToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If Aider is installed, then map <leader>aid to open a terminal window at the
" bottom, running aider.
"
"if executable('aider')
"  function! OpenAiderTerminal()
"    let l:repo_root = system('git rev-parse --show-toplevel')
"    let l:repo_root = substitute(l:repo_root, '\n\+$', '', '')
"    "let l:current_file = expand('%:p')
"
"    "if l:current_file != '' && l:repo_root != ''
"    "  let l:relative_file_path = l:current_file[l:repo_root != '/' ? len(l:repo_root) + 1 : len(l:repo_root):]
"    "else
"    "  let l:relative_file_path = ''
"    "endif
"
"    if v:shell_error == 0 && !empty(l:repo_root)
"      execute 'lcd ' . l:repo_root
"    endif
"
"    "execute 'botright terminal aider ++close ++norestore aider ' . l:relative_file_path
"    execute 'botright terminal ++close ++norestore aider'
"  endfunction
"
"  nnoremap <silent> <leader>adr :call OpenAiderTerminal()<CR>
"endif
