" Compile help tags after all plugins have been loaded, but only for a doc
" directory whose tags are missing or older than a file beside them.
" helptags ALL would rewrite every tags file on 'runtimepath' at each start.

function! s:TagsAreStale(dir) abort
  let l:tags = glob(a:dir . '/tags*', 1, 1)

  if empty(l:tags)
    return 1
  endif

  let l:docs = filter(glob(a:dir . '/*', 1, 1),
    \ 'fnamemodify(v:val, ":t") !~# "^tags"')

  " getftime() counts whole seconds, so a doc written in the second the tags
  " were built counts as newer; the rebuild that causes settles it.
  return max(map(l:docs, 'getftime(v:val)'))
    \ >= min(map(l:tags, 'getftime(v:val)'))
endfunction

for s:dir in globpath(&runtimepath, 'doc', 1, 1)
  if filewritable(s:dir) == 2 && s:TagsAreStale(s:dir)
    execute 'silent! helptags' fnameescape(s:dir)
  endif
endfor

unlet! s:dir
