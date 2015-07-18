function! IsPerlTestFile()
  echo "Got to IsPerlTestFile"
  if expand("%:e") == 't' && expand("%:p:h") =~ '/xt/'
    echo "file is t in directory path xt"
    set filetype=perl
  endif
endfunction

au BufNewFile,BufRead *.t call IsPerlTestFile()
