""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" README: Toggle paste mode. The only paste toggle: 'pastetoggle' is left
" unset, since bracketed paste covers pasting in Insert mode.
nnoremap <leader>pp :set paste!<CR>

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
" README: :w!! writes the file through sudo; Enter runs it. vim-eunuch's
" :SudoWrite when it is loaded, otherwise the buffer is piped to sudo tee.
if exists('g:loaded_eunuch')
  cnoremap w!! SudoWrite
else
  cnoremap w!! w !sudo tee > /dev/null %
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add blank lines above or below without entering Insert mode; a count adds
" that many.
nnoremap <Leader>O :<C-U>call append(line('.') - 1, repeat([''], v:count1))<CR>
nnoremap <Leader>o :<C-U>call append(line('.'), repeat([''], v:count1))<CR>

" Substitute across the buffer, cursor left between the slashes. Normal mode
" only: vim-surround maps Visual-mode S.
nnoremap S :%s//g<Left><Left>

nnoremap <silent> <Leader>y :if exists('syntax_on') <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif<CR>

nnoremap <Leader>b :ls<CR>:buffer<Space>

" Yank to the end of the line, like D and C.
nnoremap Y y$

" Repeat, then put the cursor back where the change started. vim-repeat maps
" . to its <Plug>(RepeatDot) the first time a plugin calls it, which would
" silently replace this mapping, so its autoload file is loaded now and .
" goes through it; without vim-repeat, through the built-in repeat.
runtime autoload/repeat.vim

if exists('g:loaded_repeat')
  nmap . <Plug>(RepeatDot)`[
else
  nnoremap . .`[
endif

function! s:AppendModeline() abort
  let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  call append(0, substitute(&commentstring, '%s', l:modeline, ''))
endfunction

nnoremap <silent> <Leader>ml :call <SID>AppendModeline()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Manual formatting with ALE
nmap <leader>fb <Plug>(ale_fix)

command! QuickfixToggle call quickfixtoggle#toggle()

nnoremap <leader>q] <Cmd>cnext<CR>
nnoremap <leader>q[ <Cmd>cprevious<CR>
nnoremap <leader>qf <Cmd>QuickfixToggle<CR>
