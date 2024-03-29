setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal autoindent
setlocal smartindent

" coc.nvim is handling the LSP (including linters) so we don't need to setup
" shellcheck here.

function! s:shfmt_fixer(buffer) abort
    let l:cwd = getcwd()
    let l:filename = expand('#' . a:buffer . ':p')
    let l:dirname = fnamemodify(l:filename, ':h')
    execute 'cd' l:dirname
    let l:fixer_result = ale#fixers#shfmt#Fix(a:buffer)
    execute 'cd' l:cwd
    return l:fixer_result
endfunction

let b:ale_fixers = {'sh': function('s:shfmt_fixer')}

let g:ale_sh_shfmt_options =
      \ '--write ' .
      \ '--simplify ' .
      \ '--indent 2 ' .
      \ '--binary-next-line ' .
      \ '--case-indent ' .
      \ '--space-redirects '
