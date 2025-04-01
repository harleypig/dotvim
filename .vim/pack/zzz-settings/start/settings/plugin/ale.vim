" ----------------------------------------------------------------------------
" ALE Core Configuration
"
" Follow the suggestions of ALE to disable LSP features by default
" See: https://github.com/dense-analysis/ale#cocnvim

let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1

" ----------------------------------------------------------------------------
" Linting Behavior

let g:ale_lint_on_text_changed = 'insert'
" let g:ale_lint_on_insert_leave = v:false
let g:ale_use_quickfix = v:false
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_change_sign_column_color = v:true

" ----------------------------------------------------------------------------
" Fixing Behavior

let g:ale_fix_on_save = 1

" ----------------------------------------------------------------------------
" Global Fixers and Linters

" Auto cleanup for all files
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \}
