" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

set nocompatible

" See .vim/after/ftplugin/perl.vim for perl specific settings.

" Try to force editing of the called file to an already existing window
" XXX: How well is this working?
runtime macros/editexisting.vim

" Ignore plugins by using directory name under .vim/bundle
" let g:pathogen_disabled = [ 'abolish', 'autoclose', ... ]
let g:pathogen_disabled = [ 'abolish', 'cscope_macros', 'drawit', 'evervim', 'fugitive', 'gundo', 'speeddating' ]

" gundo requires vim 7.3 or greater
if v:version < '703' || !has('python')
  call add(g:pathogen_disabled, 'gundo')
endif

" indent-guides and perlomni require vim 7.2 or greater
if v:version < '702'
  call add(g:pathogen_disabled, 'indent-guides')
  call add(g:pathogen_disabled, 'perlomni')
endif

" autoclose and supertab require vim 7.0 or greater
if v:version < '700'
  call add(g:pathogen_disabled, 'autoclose')
  call add(g:pathogen_disabled, 'supertab')
endif

" https://github.com/tpope/vim-pathogen
" docs in .vim/bundle/pathogen/README.markdown
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

" XXX: How well is this working?
runtime macros/justify.vim

helptags ~/.vim/doc

" colorscheme desert
colorscheme desert_harleypig

filetype plugin indent on
syntax on

" Automatically reload this file when it, or any sourced file, is saved.
aug AutoloadVimrc
  au!
  au BufWritePost $MYVIMRC      source $MYVIMRC
aug END
