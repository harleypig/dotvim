" coc.nvim is handling the LSP (including linters) so we don't need to setup
" shellcheck here.

let g:ale_fixers = { 'sh' : [ 'shfmt' ] }

let g:ale_sh_shfmt_options =
  \ '--binary-next-line ' .
  \ '--case-indent ' .
  \ '--space-redirects '
