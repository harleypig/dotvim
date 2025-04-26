" Toggle the quickfix window
function! quickfixtoggle#toggle() abort
  if !empty(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist'))
    cclose
  else
    let l:curwin = winnr()
    copen
    execute l:curwin . 'wincmd w'
  endif
endfunction
