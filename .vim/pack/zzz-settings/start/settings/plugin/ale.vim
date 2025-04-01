" Follow the suggestions of ALE to disable LSP features by default (see
" https://github.com/dense-analysis/ale#cocnvim).

let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_use_quickfix = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_virtualtext_cursor = 'disabled'

" Auto cleanup for all files
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'terraform': ['terraform'],
  \   'hcl': ['terraform'],
  \}

" Terraform linters
let g:ale_linters = {
  \   'terraform': ['tflint'],
  \   'hcl': ['tflint'],
  \}
