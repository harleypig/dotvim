" Excellent HTML formatted copy of the VIm documentation at
" https://vimhelp.org

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use coc for lsp functions, not ale. This needs to be disabled before ALE is
" loaded, so we're doing it here.
let g:ale_disable_lsp = 1

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
colorscheme norwaytoday

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://wiki.archlinux.org/title/Vim#Workaround_for_XDG_Base_Directory_specification
"
" set runtimepath^=$XDG_CONFIG_HOME/vim
" set runtimepath+=$XDG_DATA_HOME/vim
" set runtimepath+=$XDG_CONFIG_HOME/vim/after
"
" set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
" set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after
"
" let g:netrw_home = $XDG_DATA_HOME."/vim"
" call mkdir($XDG_DATA_HOME."/vim/spell", 'p')
"
" set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p')
" set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p')
" set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p')
" set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p')
"
" if !has('nvim') | set viminfofile=$XDG_STATE_HOME/vim/viminfo | endif
