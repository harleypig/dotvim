" ----------------------------------------------------------------------------
" ALE Early Settings
"
" These settings must be set before ALE is loaded to take effect

" Control when ALE checks your code to avoid slowdowns
"
" ALE can check your code in different ways:
"
" 'always' - Check whenever you type in any mode (TextChanged, TextChangedI)
" 'normal' - Check only when typing in normal mode (TextChanged)
" 'insert' - Check only when typing in insert mode (TextChangedI)
" 'never'  - Don't check as you type
"
" TextChanged is when you edit text in normal mode (like when deleting with 'x' or 'd')
" TextChangedI is when you edit text in insert mode (like when typing new code)
" Default: 'normal'
let g:ale_lint_on_text_changed = 'always'

" Lint when leaving insert mode (default: false)
let g:ale_lint_on_insert_leave = 1

" Lint when opening a file (default: true)
" let g:ale_lint_on_enter = 1

" Lint when saving a file (default: true)
" When both ale_fix_on_save and ale_lint_on_save are true, ALE will:
" 1. First fix your file (apply formatters, remove whitespace, etc.)
" 2. Save those changes to disk
" 3. Then lint the fixed file to check for remaining problems
" This gives you clean, formatted code that's also checked for errors!
" let g:ale_lint_on_save = 1

" Lint when filetype changes (default: true)
" let g:ale_lint_on_filetype_changed = 1

" Don't show error messages as virtual text (keeps the view clean)
let g:ale_virtualtext_cursor = 'disabled'

" Tell ALE not to try and provide LSP features (we use CoC for that)
let g:ale_disable_lsp = 1

" Only run linters we explicitly configure (no surprises!)
let g:ale_linters_explicit = 1

" Automatically fix problems when saving files
let g:ale_fix_on_save = 1
