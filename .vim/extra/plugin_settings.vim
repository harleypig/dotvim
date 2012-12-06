" Surround   http://www.vim.org/scripts/script.php?script_id=1697
"            http://github.com/tpope/vim-surround
"            In .vim/bundle/surround

" Align      http://www.vim.org/scripts/script.php?script_id=294
"            http://github.com/vim-scripts/Align
"            In .vim/bundle/align

" AutoAlign  http://www.vim.org/scripts/script.php?script_id=884
"            http://github.com/vim-scripts/AutoAlign
"            In .vim/bundle/autoalign

" Vim-Perl   http://github.com/petdance/vim-perl
"            In .vim/bundle/perl

" Pathogen   http://github.com/tpope/vim-pathogen
"            http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
"            http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
"            In .vim/bundle/pathogen

" Github     http://github.com/thinca/vim-github
"            In .vim/bundle/github

" PerlCritic https://github.com/mattfoster/vim-Perl-Critic
"            In .vim/bundle/perlcritic

" Fugitive   https://github.com/tpope/vim-fugitive
"            In .vim/bundle/fugitive

" gitv       https://github.com/gregsexton/gitv
"            In .vim/bundle/gitv

" quickfixstatus https://github.com/dannyob/quickfixstatus
"                In .vim/bundle/quickfixstatus

" SpaceHi    https://github.com/jpalardy/spacehi.vim
"            In .vim/bundle/spacehi

" Don't highlight spaces in these filetypes
let blacklist = [ 'help' ]
autocmd BufWritePre * if index( blacklist, &ft ) < 0 | autocmd syntax * SpaceHi

"ledger
"evervim
"gitolite
"irssilog

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins To Checkout

" AutoComplPop  http://www.vim.org/scripts/script.php?script_id=1879
" Snipmate      http://www.vim.org/scripts/script.php?script_id=2540
"               https://github.com/garbas/vim-snipmate
"               https://github.com/honza/snipmate-snippets
" PerlOmni      http://www.vim.org/scripts/script.php?script_id=2852
" Google Script https://github.com/dubenstein/vim-google-scribe
" SVNDiff       http://www.vim.org/scripts/script.php?script_id=1881
" NERDTree      https://github.com/scrooloose/nerdtree
" ctrlp         https://github.com/kien/ctrlp.vim

" Look into looking for or creating a plugin for GRAC
" http://grac.sourceforge.net/
