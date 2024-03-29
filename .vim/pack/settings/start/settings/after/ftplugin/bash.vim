setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal autoindent
setlocal smartindent

let b:ale_fixers = ['shfmt']

let g:ale_sh_shfmt_options =
      \ '--indent 2 ' .
      \ '--binary-next-line ' .
      \ '--case-indent ' .
      \ '--space-redirects '

let g:ale_sh_shfmt_options =
      \ '--indent 2 ' .
      \ '--binary-next-line ' .
      \ '--case-indent ' .
      \ '--space-redirects '
