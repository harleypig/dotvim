setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal autoindent
setlocal smartindent

" coc.nvim is handling the LSP (including linters) so we don't need to setup
" shellcheck here.

let b:ale_fixers = ['shfmt']

let g:ale_sh_shfmt_options =
      \ '--write ' .
      \ '--simplify ' .
      \ '--indent 2 ' .
      \ '--binary-next-line ' .
      \ '--case-indent ' .
      \ '--space-redirects '
