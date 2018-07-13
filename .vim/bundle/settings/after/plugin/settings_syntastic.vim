" Syntastic  http://www.vim.org/scripts/script.php?script_id=2736
"            http://github.com/scrooloose/syntastic/
"            In .vim/bundle/syntastic

" Global settings
let g:syntastic_aggregate_errors         = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 0
let g:syntastic_check_on_wq              = 0
let g:syntastic_echo_current_error       = 0
let g:syntastic_enable_balloons          = 0
let g:syntastic_error_symbol             = '!!'
let g:syntastic_stl_format               = '[%E{Err %fe (%e)}%B{, }%W{Warn %fw (%w)} Open \lo Close \lc]'
let g:syntastic_style_error_symbol       = 'S!'
let g:syntastic_style_warning_symbol     = 'S?'
let g:syntastic_warning_symbol           = 'W?'

" Perl Checker options
let g:syntastic_enable_perl_checker      = 1
let g:syntastic_perl_checkers            = [ 'myperl', 'perlcritic' ]
let g:syntastic_perl_interpreter         = '~/.vim/tools/efm_perl.pl'
"let g:syntastic_perl_myperl_exec        = '~/.vim/tools/efm_perl.pl'
let g:syntastic_perl_perlcritic_thres    = 0
let g:syntastic_perl_perlcritic_post_args = '--verbose "\%s:\%f:\%l:\%c:\%p \%m\n"'
"let g:syntastic_debug                   = 31

" Shellcheck options
" Usage: shellcheck [OPTIONS...] FILES...
"   -a                --check-sourced          Include warnings from sourced files
"   -C[WHEN]          --color[=WHEN]           Use color (auto, always, never)
"   -e CODE1,CODE2..  --exclude=CODE1,CODE2..  Exclude types of warnings
"   -f FORMAT         --format=FORMAT          Output format (checkstyle, gcc, json, tty)
"   -s SHELLNAME      --shell=SHELLNAME        Specify dialect (sh, bash, dash, ksh)
"   -V                --version                Print version information
"   -x                --external-sources       Allow 'source' outside of FILES

let g:syntastic_sh_shellcheck_args       = '--external-sources --color=never --exclude=SC1090,SC1091'

" Ignore bats files
let g:syntastic_ignore_files = ['\.bats$']

noremap <silent> <leader>lc :lclose<CR>
noremap <silent> <leader>lo :Errors<CR>
