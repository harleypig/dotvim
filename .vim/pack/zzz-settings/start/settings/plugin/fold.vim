" ----------------------------------------------------------------------------
" Closed fold text: the fold's first non-blank line, dotted out to the window
" edge, then its size, its share of the buffer and its level, e.g.
"
"   function! Foo()........................ 12 lines [3.4%] +--+--
"
" Adapted from
" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/

function! s:CustomFoldText() abort
  let l:first = nextnonblank(v:foldstart)

  if l:first == 0 || l:first > v:foldend
    let l:line = getline(v:foldstart)

  else
    let l:line = substitute(getline(l:first), '\t', repeat(' ', &tabstop), 'g')
  endif

  " 8 is a rough allowance for the number column, whatever its real width.
  let l:width = winwidth(0) - &foldcolumn - (&number ? 8 : 0)

  let l:size = v:foldend - v:foldstart + 1
  let l:size_text = ' ' . l:size . ' lines '
  let l:share = printf('[%.1f%%] ', l:size * 100.0 / line('$'))
  let l:level = repeat('+--', v:foldlevel)

  let l:fill = l:width - strwidth(l:line . l:size_text . l:share . l:level)

  return l:line . repeat('.', l:fill) . l:size_text . l:share . l:level
endfunction

set foldtext=s:CustomFoldText()
