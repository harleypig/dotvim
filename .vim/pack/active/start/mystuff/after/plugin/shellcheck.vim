" Have we been loaded yet?
" Are we in compatible mode?
" No? Return.

if exists("g:loaded_shellcheck") || &compatible
  finish
endif

let s:save_cpoptions = &cpoptions
set cpoptions&vim

function! s:errMsg(msg)
  redraw
  echohl ErrorMsg

  if type(msg) != type('')
    echo 'msg must be a string'
  else
    echo msg
  endif

  echohl None
endfunction

function! s:scAddDirective(name,value)
  let l:lineno = line('.') - 1
  call append(l:lineno, '# shellcheck ' . a:name . '=' . a:value)
endfunction

function! s:scDisable(directive)
  if a:directive =~ '\D'
    call s:errMsg("'directive' must be an integer.'")
    return 1
  endif

  if str2nr(a:directive) < 1000
    call s:errMsg("'directive' must be greater than 999.")
    return 1
  endif

  call s:scAddDirective('disable','SC' . a:directive)
endfunction

function! s:scSource(source)
  " XXX: Does it make sense to check for existence of file here?

  call s:scAddDirective('source',a:source)
endfunction

function! s:scShell(shell)
  " XXX: Check for and allow only supported shells.
  " XXX: Does it make sense to have this directive on any but the first line?

  call s:scAddDirective('shell',a:shell)
endfunction

command -nargs=1 ShellCheckDisable :call s:scDisable(<f-args>)
command -nargs=1 ShellCheckSource  :call s:scSource(<f-args>)
command -nargs=1 ShellCheckShell   :call s:scShell(<f-args>)

nnoremap <silent> <Leader>scd :call <SID>scDisable(input('shellcheck disable=SC'))<CR>
nnoremap <silent> <Leader>scs :call <SID>scSource(input('shellcheck source='))<CR>
nnoremap <silent> <Leader>sch :call <SID>scShell(input('shellcheck shell='))<CR>

let &cpoptions = s:save_cpoptions

let g:loaded_shellcheck = 1
