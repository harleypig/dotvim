" Have we been loaded yet?
" Are we in compatible mode?
" Does the shfmt executable exist?
" No? Return.

if exists("g:loaded_shfmt") || &compatible || ! executable('shfmt')
  finish
endif

let s:save_cpoptions = &cpoptions
set cpoptions&vim

let s:switches = join(['-w', '-s', '-i', '2', '-bn', '-ci', '-sr'])

function! s:shFormat()
  let l:filename = @%
  let l:end = line('$')
  let l:l = 1

  for l:line in getline(0, end)
    let l:line = substitute(l:line, '^#$', '', 'e')
    let l:line = substitute(l:line, '^\s\+#$', '', 'e')
    let l:line = substitute(l:line, '^\s\+#\s\+$', '', 'e')
    let l:line = substitute(l:line, '#\s\+$', '', 'e')
    let l:line = substitute(l:line, '\s\+$', '', 'e')
    call setline(l:l, l:line)
    let l:l += 1
  endfor

  write!

  let l:out = system('shfmt ' . s:switches . ' ' . l:filename)

  edit!

endfunction

command Convert2Bash echoerr 'Use <LEADER>fb to format your file.'
nnoremap <silent> <Leader>fb :call <SID>shFormat()<CR>

let &cpoptions = s:save_cpoptions

let g:loaded_shfmt = 1
