" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

set nocompatible

" See .vim/after/ftplugin/perl.vim for perl specific settings.

"call pathogen#runtime_append_all_bundles()
call pathogen#incubate()
call pathogen#helptags()
helptags ~/.vim/doc

colorscheme desert

filetype plugin indent on
syntax on

runtime! extra/*.vim

" Automatically reload this file when it, or any sourced file, is saved.
aug AutoloadVimrc
  au!
  au BufWritePost $MYVIMRC      source $MYVIMRC
  au BufWritePost */extra/*.vim source $MYVIMRC
aug END
