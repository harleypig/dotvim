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

" Shamelessly ripped off from
" https://github.com/whiteinge/dotfiles/blob/master/.vim/ftplugin/help.vim
" Vim Help docs: hit enter to activate links, and ctrl-[ as a back button
autocmd FileType help nmap <buffer> <Return> <C-]>
autocmd FileType help nmap <buffer> <C-[> <C-O>
