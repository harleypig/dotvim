" Excellent HTML formatted copy of the VIm documentation at
" https://vimhelp.org

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable syntax highlighting with vim-polyglot before loading the plugin.
" let g:polyglot_disable = ['filetype', 'filetype']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load all plugins in .vim/pack/*/start
packloadall!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile the help tags for all plugins
helptags ALL
