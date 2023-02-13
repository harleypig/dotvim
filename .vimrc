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
let g:coc_global_extensions = [
    \ '@yaegassy/coc-ansible', 'coc-coverage',
		\ 'coc-db', 'coc-dictd', 'coc-docker', 'coc-git', 'coc-grammarly',
		\ 'coc-json', 'coc-lists', 'coc-markdownlint', 'coc-pairs',
		\ 'coc-prettier', 'coc-pydocstring', 'coc-sh', 'coc-smartf', 'coc-sql',
		\ 'coc-tasks', 'coc-terminal', 'coc-toml', 'coc-vimlsp', 'coc-yaml'
    \]

" @yaegassy/coc-ansible'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load all plugins in .vim/pack/*/start
packloadall!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile the help tags for all plugins
helptags ALL

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme norwaytoday
