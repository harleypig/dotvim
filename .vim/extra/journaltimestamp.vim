if exists ( 'g:loaded_journaltimestamp' )

  finish

endif

let g:loaded_journaltimestamp = 1

if ! exists( 'g:journaltimestamp_baseformat' )

  let g:journaltimestamp_baseformat = '**TS:%s** '

endif

if exists ( "*strftime" )

  inoremap <Leader>ts <C-R>=strftime( g:journaltimestamp_baseformat )<CR>

endif
