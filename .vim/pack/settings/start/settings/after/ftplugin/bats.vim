setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal autoindent
setlocal smartindent

" coc.nvim is handling the LSP (including linters) so we don't need to setup
" shellcheck here.

let g:ale_fixers = { 'sh' : [ 'shfmt' ] }

let g:ale_sh_shfmt_options =
      \ '--indent 2 ' .
      \ '--binary-next-line ' .
      \ '--case-indent ' .
      \ '--space-redirects '
