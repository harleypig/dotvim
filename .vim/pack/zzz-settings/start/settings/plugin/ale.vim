" ----------------------------------------------------------------------------
" ALE Core Configuration

" Tell ALE not to try and provide LSP features (we use CoC for that)
" This means we should only pay attention to sections 3, 4, 6 (specific only
" as described below), 7, and 8 (specific only as described below).
"
" ALE is configured to focus solely on:
"
" • Running non-LSP linters
" • Providing fixing capabilities
" • Displaying diagnostics

let g:ale_disable_lsp = 1

" Only run linters we explicitly configure (no surprises!)
let g:ale_linters_explicit = 1

" Automatically fix problems when saving files
let g:ale_fix_on_save = 1

" ----------------------------------------------------------------------------
" Display Settings
"
" Control how errors and warnings appear in your editor

" Don't show error messages as virtual text (keeps the view clean)
let g:ale_virtualtext_cursor = 'disabled'

" Change the sign column color when there are errors
" This changes the entire column color. Ick.
" Leave this here so I don't try it again.
"let g:ale_change_sign_column_color = v:true

" ----------------------------------------------------------------------------
" Performance Settings
"
" Control when ALE checks your code to avoid slowdowns

" Only check for problems when typing in insert mode
let g:ale_lint_on_text_changed = 'insert'  " Default: 'normal'

" Lint when leaving insert mode (default: false)
let g:ale_lint_on_insert_leave = 1

" Lint when opening a file (default: true)
" let g:ale_lint_on_enter = 1

" Lint when saving a file (default: true)
# Add ELI5 about what happens when both ale_fix_on_save and this are true, AI!
" let g:ale_lint_on_save = 1

" Lint when filetype changes (default: true)
" let g:ale_lint_on_filetype_changed = 1

" ----------------------------------------------------------------------------
" Global Fixers
"
" Automatic fixes that apply to all file types

" For all files: remove extra blank lines at end of file and trailing whitespace
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
