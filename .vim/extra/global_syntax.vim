if ! exists( "autocmds_loaded" )

  let autocmds_loaded = 1
  autocmd BufEnter * source <sfile>

endif

if has( 'conceal' )

  " How can I use variables for the patterns?
  "syntax region myTimeStamp start="__TS:" end="|" conceal
  syntax match myTimeStamp "__TS:.*|" conceal
  highlight myTimeStamp ctermfg=red ctermbg=blue
  set conceallevel=2

endif

