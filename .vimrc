" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

set nocompatible

" See .vim/after/ftplugin/perl.vim for perl specific settings.

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
helptags ~/.vim/doc

colorscheme desert

filetype plugin indent on
syntax on

" Automatically reload this file when it, or any sourced file, is saved.
if !exists( "autoload_vimrc" )

  let autoload_vimrc = 1
  autocmd BufWritePost .vimrc source $MYVIMRC

  " how can I make it so my custom config files are auto reloaded also?
  " autocmd BufWritePost .vim/after/plugin/statusline source $MYVIMRC

endif
