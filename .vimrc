" Excellent HTML formatted copy of the VIm documentation at
" https://vimhelp.org

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use coc for lsp functions, not ale
" And disable the annoying startup warning that doesn't seem to mean anything
let g:ale_disable_lsp = 1
"let g:coc_disable_startup_warning = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable syntax highlighting with vim-polyglot before loading the plugin.
" let g:polyglot_disable = ['filetype', 'filetype']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install these extensions if they aren't already.
" This list has to exist before coc is loaded.
"
" coc-json:
" coc-toml: https://github.com/kkiyama117/coc-toml
" coc-lists: https://github.com/neoclide/coc-lists
" coc-pairs: https://github.com/neoclide/coc-pairs
"
" coc-sh: https://github.com/josa42/coc-sh
"   requires: https://github.com/bash-lsp/bash-language-server
"
" coc-db
"   required: https://github.com/tpope/vim-dadbod.git

let g:coc_global_extensions = [ 'coc-json', 'coc-sh', 'coc-toml', 'coc-lists', 'coc-db', 'coc-pairs' ]

" Lookit these after getting more comfortable with coc.
" https://github.com/voldikss/coc-todolist
" https://github.com/neoclide/coc-yank
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load all plugins in .vim/pack/*/start
packloadall!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile the help tags for all plugins
helptags ALL
