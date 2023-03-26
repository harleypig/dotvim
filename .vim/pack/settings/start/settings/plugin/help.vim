" open help window with a vertical split
autocmd FileType help wincmd L | call s:resize_help_window()

" resize help window when it is opened
function! s:resize_help_window()
  if &filetype ==# 'help'
    let l:width = winwidth(0)
    if l:width > 80
      let l:width = 80
    endif
    execute 'vertical resize ' . l:width
  endif
endfunction
