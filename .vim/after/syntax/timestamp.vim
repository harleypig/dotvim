if has( 'conceal' )

  syntax conceal on
  " How can I use variables for the patterns?
  syntax region myTimeStamp start="__TS:" end="|" oneline conceal cchar=_
  set conceallevel=2

endif
