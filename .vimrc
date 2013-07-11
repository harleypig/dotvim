" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

set nocompatible

" See .vim/after/ftplugin/perl.vim for perl specific settings.

" https://github.com/tpope/vim-pathogen
" docs in .vim/bundle/pathogen/README.markdown
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" My own docs, mainly notes for myself
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
