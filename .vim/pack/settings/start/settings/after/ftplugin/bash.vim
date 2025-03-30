setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal autoindent
setlocal smartindent

" coc.nvim is handling the LSP (including linters) so we don't need to setup
" shellcheck here.

" vint: -ProhibitUnusedVariable
function! s:shfmt_fixer(buffer) abort
    let l:cwd = getcwd()
    let l:filename = expand('#' . a:buffer . ':p')
    let l:dirname = fnamemodify(l:filename, ':h')

    execute 'cd' l:dirname
    let l:fixer_result = ale#fixers#shfmt#Fix(a:buffer)
    execute 'cd' l:cwd

    return l:fixer_result
endfunction

"let b:ale_fixers = {'bash': function('s:shfmt_fixer')}
let b:ale_fixers = ['shfmt']

" Enable format on save
let b:ale_fix_on_save = 1

" ale shfmt uses vim's indent settings, so don't hardcode them here.
let g:ale_sh_shfmt_options =
      \ '--write ' .
      \ '--simplify ' .
      \ '--binary-next-line ' .
      \ '--case-indent ' .
      \ '--space-redirects '
