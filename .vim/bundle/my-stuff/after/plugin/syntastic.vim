""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic

" https://github.com/scrooloose/syntastic
" http://www.vim.org/scripts/script.php?script_id=2736
" http://github.com/scrooloose/syntastic/

" XXX: These colors are not taking affect!

hi SyntasticErrorSign ctermfg=darkred ctermbg=lightred
hi SyntasticStyleErrorSign ctermfg=darkred ctermbg=lightred
hi SyntasticWarningSign ctermfg=yellow ctermbg=lightred
hi SyntasticStyleWarningSign ctermfg=yellow ctermbg=lightred

" Global
let g:syntastic_aggregate_errors         = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
let g:syntastic_echo_current_error       = 0
let g:syntastic_enable_balloons          = 0
let g:syntastic_error_symbol             = '!!'
"let g:syntastic_mode                     = 'passive'
let g:syntastic_stl_format               = '[%E{Err %fe (%e)}%B{, }%W{Warn %fw (%w)} Open \lo Close \lc]'
let g:syntastic_style_error_symbol       = 'S!'
let g:syntastic_style_warning_symbol     = 'S?'
let g:syntastic_warning_symbol           = 'W?'

" Perl
let g:syntastic_enable_perl_checker      = 1
let g:syntastic_perl_checkers            = [ 'myperl', 'perlcritic' ]
let g:syntastic_perl_interpreter         = '~/.vim/tools/efm_perl.pl'
"let g:syntastic_perl_myperl_exec        = '~/.vim/tools/efm_perl.pl'
let g:syntastic_perl_perlcritic_thres    = 0
let g:syntastic_perl_perlcritic_post_args = '--verbose "\%s:\%f:\%l:\%c:\%p \%m\n"'
"let g:syntastic_debug                   = 31

" ShellCheck
let g:syntastic_sh_shellcheck_args       = '--external-sources --color=never --exclude=SC1090,SC1091'

" Markdown
" mdl and proselint
let g:syntastic_markdown_mdl_exec = "markdownlint"
let g:syntastic_markdown_mdl_args = ""
let g:syntastic_markdown_checkers = ['mdl', 'proselint']

" Include vimwiki in Markdown checks
let g:syntastic_vimwiki_checkers = ['markdown/mdl', 'markdown/proselint']

" Ignore bats files and executables
let g:syntastic_ignore_files = ['\.bats$','/bats.*']

noremap <silent> <leader>lc :lclose<CR>
noremap <silent> <leader>lo :Errors<CR>
