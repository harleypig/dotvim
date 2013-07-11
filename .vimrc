" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

set nocompatible

" See .vim/after/ftplugin/perl.vim for perl specific settings.

" https://github.com/tpope/vim-pathogen
" docs in .vim/bundle/pathogen/README.markdown
runtime bundle/pathogen/autoload/pathogen.vim

" Ignore plugins by using directory name under .vim/bundle
" let g:pathogen_disabled = [ abolish, autoclose, ... ]
let g:pathogen_disabled = []

" Gundo requires at least vim 7.3
if v:version < '703' || !has('python')
  call add(g:pathogen_disabled, 'gundo')
endif

execute pathogen#infect()

helptags ~/.vim/doc

" colorscheme desert
colorscheme desert_harleypig

filetype plugin indent on
syntax on

runtime! extra/*.vim

" Automatically reload this file when it, or any sourced file, is saved.
aug AutoloadVimrc
  au!
  au BufWritePost $MYVIMRC      source $MYVIMRC
  au BufWritePost */extra/*.vim source $MYVIMRC
aug END
