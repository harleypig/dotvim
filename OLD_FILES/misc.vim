" Not loaded by Vim. What is left of the old misc.vim waits for two files
" that had other changes open when the rest was merged or removed (#4 - merge
" or remove OLD_FILES): the mappings go to the late settings' maps.vim, the
" diffopt line to set.vim. Delete this file, and OLD_FILES/, once they move.

" Add blank lines above or below without entering insert mode; a count adds
" that many.
nnoremap <Leader>O :<C-U>call append(line('.') - 1, repeat([''], v:count1))<CR>
nnoremap <Leader>o :<C-U>call append(line('.'), repeat([''], v:count1))<CR>

" Substitute across the buffer, cursor left between the slashes. The old
" visual-mode twin is dropped: vim-surround maps visual S.
nnoremap S :%s//g<Left><Left>

nnoremap <silent> <Leader>y :if exists('syntax_on') <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif<CR>

nnoremap <Leader>b :ls<CR>:buffer<Space>

" Yank to the end of the line, like D and C.
nnoremap Y y$

" Repeat, then put the cursor back where the change started.
nnoremap . .`[

function! AppendModeline() abort
  let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  call append(0, substitute(&commentstring, '%s', l:modeline, ''))
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

set diffopt+=algorithm:patience
