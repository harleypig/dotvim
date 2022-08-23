" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

" This is set by default
" set nocompatible

" Use coc for lsp functions, not ale
let g:ale_disable_lsp = 1
let g:coc_disable_startup_warning = 1

" Load all plugins in .vim/pack/*/start directories
packloadall!

helptags ALL

colorscheme desert
"colorscheme blacklight
"colorscheme neon

filetype plugin indent on
syntax on

" Use a different colorscheme when using vimdiff and turn off syntax
" highlighting. This improves visibility mightily.


if &diff
  colorscheme vividchalk
  syntax off
endif

" XXX: Move this to mystuff?
" Automatically reload this file when it, or any sourced file, is saved.
aug AutoloadVimrc
  au!
  au BufWritePost $MYVIMRC source $MYVIMRC
aug END

" XXX: Move me!
set shellcmdflag=-ic

echo "HELLO"
