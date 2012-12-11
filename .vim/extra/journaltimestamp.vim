if exists ( 'g:loaded_journaltimestamp' )

  finish

endif

let g:loaded_journaltimestamp = 1

if exists( "*strftime" )

  if ! exists( 'g:journaltimestamp_format_full' )

    if ! exists( 'g:journaltimestamp_format_begin' )

      let g:journaltimestamp_format_begin = '**TS:'

    endif

    if ! exists( 'g:journaltimestamp_format_epoch' )

      let g:journaltimestamp_format_epoch = '%s'

    endif

    if ! exists( 'g:journaltimestamp_format_delim' )

      let g:journaltimestamp_format_delim = '|'

    endif

    if ! exists( 'g:journaltimestamp_format_human' )

      let g:journaltimestamp_format_human = '%b %d, %Y %R'

    endif

    if ! exists( 'g:journaltimestamp_format_end' )

      let g:journaltimestamp_format_end = '**'

    endif

    let g:journaltimestamp_format_full = g:journaltimestamp_format_begin . g:journaltimestamp_format_epoch . g:journaltimestamp_format_delim . g:journaltimestamp_format_human . g:journaltimestamp_format_end

  endif

"  if has( 'conceal' )
"
"    syntax conceal on
"    execute 'syn match JT /' . g:journaltimestamp_format_begin . '/ contained transparent contains=NONE'
"    set conceallevel=2
"
"  endif

  "syntax region jtEpoch start=/\v\*\*TS\:/ skip=/\v.{-}/ end=/\v\*\*/
  syntax region jtEpoch start='/\v\\*\\*TS:/' end='/\v\\*\\*/'
  "highlight jtEpoch ctermfg=yellow ctermbg=blue
  highlight link jtEpoch string

  inoremap <Leader>ts <C-R>=strftime( g:journaltimestamp_format_full )<CR>

endif
