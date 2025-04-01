" ----------------------------------------------------------------------------
" Gutter and Line Number Settings

" Default settings
set   signcolumn=yes    " Always show the sign column
set   number            " Show line numbers
set   numberwidth=1     " Minimum width of line number column

" Make sign column background transparent
highlight SignColumn ctermbg=NONE guibg=NONE

" ----------------------------------------------------------------------------
" Toggle sign column visibility
" Cycles between showing signs and hiding them
function! ToggleSigns()
  if (&signcolumn ==# 'yes' || &signcolumn ==# 'number')
    set signcolumn=no
  else
    if (&number == 1 || &relativenumber == 1)
      set signcolumn=number    " Show signs in the number column if numbers are enabled
    else
      set signcolumn=yes       " Otherwise use a dedicated sign column
    endif
  endif
endfunction

" ----------------------------------------------------------------------------
" Toggle line numbering mode
" Cycles through: no numbers → absolute → relative → both → no numbers
function! ToggleLineNumbers()
  if (&number == 0 && &relativenumber == 0)
    set number norelativenumber        " Show absolute line numbers
  elseif (&number == 1 && &relativenumber == 0)
    set nonumber relativenumber        " Show relative line numbers
  elseif (&number == 0 && &relativenumber == 1)
    set number relativenumber          " Show both absolute and relative numbers
  elseif (&number == 1 && &relativenumber == 1)
    set nonumber norelativenumber      " Hide all line numbers
  endif
endfunction

" ----------------------------------------------------------------------------
" Key Mappings

" Toggle sign column with <leader>signs
map <leader>signs :call ToggleSigns()<CR>

" Toggle line numbering mode with <leader>ln
map <leader>ln :call ToggleLineNumbers()<CR>
