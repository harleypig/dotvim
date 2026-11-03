let g:vim_indent = #{
  \ line_continuation: shiftwidth(),
  \ }

" Add vint as an ALE linter for Vimscript
"let b:ale_fixers = []

" vim-language-server comes through CoC (coc-vimlsp); ALE skips LSP linters
" because .vimrc sets g:ale_disable_lsp.
let b:ale_linters = ['vint']
