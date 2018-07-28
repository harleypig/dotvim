" Have we been loaded yet?
" Are we in compatible mode?
" No? Return.

if exists("g:loaded_shellcheck") || &compatible
  finish
endif

let s:save_cpoptions = &cpoptions
set cpoptions&vim

function! s:shellcheck(sc)
  let l:lineno = line('.') - 1
  call append(l:lineno, '# shellcheck disable=SC'.a:sc)
endfunction

command -nargs=1 ShellCheck :call s:shellcheck(<f-args>)
nnoremap <silent> <Leader>sc :call <SID>shellcheck(input('shellcheck disable=SC'))<CR>

let &cpoptions = s:save_cpoptions

let g:loaded_shellcheck = 1
