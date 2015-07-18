function! IsPerlTestFile()
  if expand("%:e") == 't' && expand("%:p:h") =~ '/xt/'
    set filetype=perl
  endif
endfunction

au BufNewFile,BufRead *.t call IsPerlTestFile()
