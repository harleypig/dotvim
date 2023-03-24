"let g:ale_sign_column_always = 1
"let g:ale_open_list = 1
"let g:ale_list_vertical = 1

" XXX: How does this work with coc's formatOnSave?
"let g:ale_fix_on_save = 1

" Auto cleanup for all files
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

" Map ALEFix
map <leader>fb :ALEFix<CR>
