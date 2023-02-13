"Using gitwatch instead. 
"augroup vimwiki
"  au! BufRead * silent !git -C "%:p:h" pull
"  au! BufWritePost * silent !git -C "%:p:h" add "%:t"; git -C "%:p:h" commit -m "Auto commit" "%:t"; git -C "%:p:h" push
"augroup END

" Change working directory to file location so markdownlint will work correctly
setlocal autochdir
"set concealcursor=nc
