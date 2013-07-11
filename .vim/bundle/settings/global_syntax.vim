if ! exists( "autocmds_loaded" )

  let autocmds_loaded = 1
  autocmd BufEnter * source <sfile>

endif

if has( 'conceal' )
  if exists ( "g:timestamp_format_begin" )

    execute 'syntax match myTimeStamp "' . g:timestamp_format_begin . '.*' . g:timestamp_format_delim . '" conceal containedin=.*Comment.*'
    highlight myTimeStamp ctermfg=red ctermbg=blue
    set conceallevel=2

  endif
endif
