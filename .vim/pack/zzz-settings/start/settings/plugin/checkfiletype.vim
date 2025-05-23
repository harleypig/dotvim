"augroup checkfiletype
"    autocmd!
"    autocmd BufRead,BufNewFile * call CheckFiletype()
"augroup END

function! CheckFiletype() abort
  let l:shebang = getline(1)
  let l:shellcheck_directive = getline(2)
  let l:matches_shebang = matchlist(l:shebang, '^#!\s*\zs.*/\(ba\?sh\)\ze')
  let l:matches_directive = matchlist(l:shellcheck_directive, '#\s*shellcheck\s+shell=\zs\w\+\ze')

  if !empty(l:matches_shebang)
    let l:filetype = l:matches_shebang[1]
    execute 'setfiletype ' . l:filetype

  elseif !empty(l:matches_directive)
    let l:filetype = l:matches_directive[0]

    "if l:filetype ==# 'dash' || l:filetype ==# 'busybox'
    if l:filetype ==# 'bash' || l:filetype ==# 'dash' || l:filetype ==# 'busybox'
      execute 'setfiletype sh'

    elseif l:filetype ==# 'bash' || l:filetype ==# 'sh'
      execute 'setfiletype ' . l:filetype
    endif
  endif
endfunction
