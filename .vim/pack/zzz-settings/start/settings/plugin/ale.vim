" ----------------------------------------------------------------------------
" ALE Configuration
"
" Note: Early settings that must be set before ALE loads are in:
" .vim/pack/000-settings/start/settings/plugin/ale.vim

" ----------------------------------------------------------------------------
" Display Settings
"
" Control how errors and warnings appear in your editor

" Change the sign column color when there are errors
" This changes the entire column color. Ick.
" Leave this here so I don't try it again.
"let g:ale_change_sign_column_color = v:true

" ----------------------------------------------------------------------------
" Global Fixers
"
" Automatic fixes that apply to all file types

" For all files: remove extra blank lines at end of file and trailing whitespace
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
