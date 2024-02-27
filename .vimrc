" Exmellent HTML formatted copy of the VIm documentation at
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

" Run bin/update-coc-extensions to make sure this is setup correctly.

" This list has to exist before coc is loaded.
let g:coc_global_extensions = [
    \ 'coc-diagnostic',
    \ 'coc-docker',
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-sh',
    \ 'coc-toml',
    \ 'coc-vimlsp',
    \ '@yaegassy/coc-ansible',
    \]

" @yaegassy/coc-ansible
" coc-coverage
" coc-db
" coc-dictd
" coc-git
" coc-lists
" coc-markdownlint
" coc-pairs
" coc-prettier
" coc-pydocstring
" coc-smartf
" coc-sql
" coc-tasks
" coc-terminal
" coc-toml
" coc-yaml

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile the help tags for all plugins
helptags ALL

augroup ansible_filetype
  autocmd!
  autocmd BufRead,BufNewFile *.yml,*.yaml if search('^\s*-\s*hosts:\s', 'nw') | setfiletype yaml.ansible | endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme norwaytoday
