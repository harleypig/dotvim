" Syntastic  http://www.vim.org/scripts/script.php?script_id=2736
"            http://github.com/scrooloose/syntastic/
"            In .vim/bundle/syntastic

" Global settings
" Default settings are commented
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
"let g:syntastic_echo_current_error=1
"let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='!!'
let g:syntastic_style_error_symbol='S!'
let g:syntastic_warning_symbol='W?'
let g:syntastic_style_warning_symbol='S?'
let g:syntastic_enable_balloons=0
let g:syntastic_enable_highlighting=1
let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=1
"let g:syntastic_loc_list_height=10
"let g:syntastic_ignore_files
"let g:syntastic_mode_map
let g:syntastic_quiet_messages=0
let g:syntastic_stl_format = '[%E{Error @ %fe (%e)}%B{, }%W{Warning @ %fw (%w)} \lo opens, \lc closes]'

" Perl settings
"let g:syntastic_perl_perlcritic_options = '--severity 1'
"let g:syntastic_perl_perlcritic_thres   = 1
"let g:syntastic_perl_lib_path = './lib'
let g:syntastic_perl_checkers=[ 'perl' ]
let g:syntastic_perl_efm_program='~/.vim/tools/efm_perl.pl'

noremap <silent> <leader>lc :lclose<CR>
noremap <silent> <leader>lo :lwindow<CR>
