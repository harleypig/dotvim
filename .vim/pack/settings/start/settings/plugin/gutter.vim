set   signcolumn=yes
set   number
set   numberwidth=1

highlight SignColumn ctermbg=NONE guibg=NONE

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle showing of signs

function! ToggleSigns()
  if (&signcolumn ==# 'yes' || &signcolumn ==# 'number')
    set signcolumn=no
  else
    if (&number == 1 || &relativenumber == 1)
      set signcolumn=number
    else
      set signcolumn=yes
    endif
  endif
endfunction

map <leader>signs :call ToggleSigns()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle between the various ways of line numbering

function! ToggleLineNumbers()
  if (&number == 0 && &relativenumber == 0)
    set number norelativenumber
  elseif (&number == 1 && &relativenumber == 0)
    set nonumber relativenumber
  elseif (&number == 0 && &relativenumber == 1)
    set number relativenumber
  elseif (&number == 1 && &relativenumber == 1)
    set nonumber norelativenumber
  endif
endfunction

map <leader>ln :call ToggleLineNumbers()<CR>
