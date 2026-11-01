" coc.nvim is handling the LSP (including linters) so we don't need to setup
" shellcheck here.

let g:ale_fixers.bats = ['shfmt']

" Buffer-local, because sh.vim sets the global option for sh buffers. The
" flags match sh's; ALE passes shfmt no indent of its own.
let b:ale_sh_shfmt_options =
  \ '--indent 2 ' .
  \ '--simplify ' .
  \ '--binary-next-line ' .
  \ '--case-indent ' .
  \ '--space-redirects '
