""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  spacehi         https://github.com/jpalardy/spacehi.vim

" Don't highlight spaces in these filetypes
let blacklist = [ 'help', 'man', 'calendar' ]
autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * if index( blacklist, &ft ) < 0 | autocmd syntax * SpaceHi
