if has( 'conceal' )
  if exists ( "g:timestamp_format_begin" )

  syntax conceal on
  " How can I use variables for the patterns?
  syntax region myTimeStamp start="__TS:" end="|" oneline conceal cchar=_
  set conceallevel=2

  endif
endif
