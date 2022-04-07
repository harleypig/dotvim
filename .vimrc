" Excellent HTML formatted copy of the VIm documentation at
" http://vimdoc.sourceforge.net/htmldoc/

set nocompatible

"profile start /home/harleypig/work/vim.profile
"profile! file *

" Try to force editing of the called file to an already existing window
" XXX: How well is this working?
"runtime macros/editexisting.vim

" Ignore plugins by using directory name under .vim/bundle
" let g:pathogen_disabled = [ 'abolish', 'autoclose', ... ]
let g:pathogen_disabled = [ 'abolish', 'cscope_macros', 'drawit', 'evervim', 'gundo', 'speeddating', 'taskwarrior', 'ultisnips' ]

" vim-lsp requires vim 8.0 or greater
if v:version < '800'
  call add(g:pathogen_disable, 'vim-lisp')
endif

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
"runtime macros/justify.vim

helptags ~/.vim/doc

colorscheme desert
" colorscheme blacklight
" colorscheme neon

filetype plugin indent on
syntax on

" Use a different colorscheme when using vimdiff and turn off syntax
" highlighting. This improves visibility mightily.

if &diff
  colorscheme vividchalk
  syntax off
endif

" Automatically reload this file when it, or any sourced file, is saved.
aug AutoloadVimrc
  au!
  au BufWritePost $MYVIMRC source $MYVIMRC
aug END
