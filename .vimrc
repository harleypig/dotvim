" Excellent HTML formatted copy of the VIm documentation at
" https://vimhelp.org

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use coc for lsp functions, not ale
let g:ale_disable_lsp = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable syntax highlighting with vim-polyglot before loading the plugin.
" let g:polyglot_disable = ['filetype', 'filetype']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install these extensions if they aren't already.
" This list has to exist before coc is loaded.

" This is a hack to get coc to install the extensions.  It's not documented
" anywhere, but it works.  The extensions are installed asynchronously, so
" it's not a big deal if they aren't installed immediately.

" XXX: Figure out a way to update this list automatically, or at least on
" demand.
"
" A list of installed extensions can be found in
" ~/.config/coc/extensions/package.json

let g:coc_global_extensions = [
    \ '@yaegassy/coc-ansible', 'coc-coverage', 'coc-diagnostic',
    \ 'coc-db', 'coc-dictd', 'coc-docker', 'coc-git',
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
