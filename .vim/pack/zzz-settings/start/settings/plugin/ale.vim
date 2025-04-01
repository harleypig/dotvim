" ----------------------------------------------------------------------------
" ALE Core Configuration
" 
" These are the fundamental settings that control how ALE behaves

" Tell ALE not to try and provide LSP features (we use CoC for that)
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
let g:ale_change_sign_column_color = v:true

" Don't use the quickfix list (use location list instead)
let g:ale_use_quickfix = v:false

" ----------------------------------------------------------------------------
" Performance Settings
" 
" Control when ALE checks your code to avoid slowdowns

" Only check for problems when typing in insert mode
let g:ale_lint_on_text_changed = 'insert'

" Uncomment to disable checking when leaving insert mode
" let g:ale_lint_on_insert_leave = v:false

" ----------------------------------------------------------------------------
" Global Fixers
" 
" Automatic fixes that apply to all file types

" For all files: remove extra blank lines at end of file and trailing whitespace
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
