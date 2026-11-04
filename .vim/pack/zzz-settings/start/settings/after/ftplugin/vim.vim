let g:vim_indent = #{
  \ line_continuation: shiftwidth(),
  \ }

" vim-language-server comes through CoC (coc-vimlsp); ALE skips LSP linters
" because the early ale.vim sets g:ale_disable_lsp.
let b:ale_linters = ['vint']
