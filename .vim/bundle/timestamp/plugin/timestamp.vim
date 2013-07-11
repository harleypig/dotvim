if exists ( 'g:loaded_timestamp' )

  finish

endif

let g:loaded_timestamp = 1

if exists( "*strftime" )

  if ! exists( 'g:timestamp_format_full' )

    if ! exists( 'g:timestamp_format_begin' )

      let g:timestamp_format_begin = '__TS:'

    endif

    if ! exists( 'g:timestamp_format_epoch' )

      let g:timestamp_format_epoch = '%s'

    endif

    if ! exists( 'g:timestamp_format_delim' )

      let g:timestamp_format_delim = '|'

    endif

    if ! exists( 'g:timestamp_format_human' )

      let g:timestamp_format_human = '%b %d, %Y %R'

    endif

    if ! exists( 'g:timestamp_format_end' )

      let g:timestamp_format_end = ' '

    endif

    let g:timestamp_format_full = g:timestamp_format_begin . g:timestamp_format_epoch . g:timestamp_format_delim . g:timestamp_format_human . g:timestamp_format_end

  endif

  inoremap <Leader>ts <C-R>=strftime( g:timestamp_format_full )<CR>

endif
