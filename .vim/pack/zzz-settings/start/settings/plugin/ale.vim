" ----------------------------------------------------------------------------
" ALE Core Configuration
"
" Follow the suggestions of ALE to disable LSP features by default
" See: https://github.com/dense-analysis/ale#cocnvim

" Core settings
let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

" ----------------------------------------------------------------------------
" Display Settings

" Control how ALE displays errors and warnings

let g:ale_virtualtext_cursor = 'disabled'
let g:ale_change_sign_column_color = v:true
let g:ale_use_quickfix = v:false

" ----------------------------------------------------------------------------
" Performance Settings

" Control when ALE runs linters and fixers

let g:ale_lint_on_text_changed = 'insert'
" let g:ale_lint_on_insert_leave = v:false

" ----------------------------------------------------------------------------
" Global Fixers

" Default fixers applied to all file types
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
