
" This is a setting, but I'm putting it here because it's actings as
" a mapping.
"set   pastetoggle=<Leader>pp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" README: Open terminal in a new window below the current window. Will not be
" included in a sessions file.
map <leader>tt :botright terminal ++norestore<CR>

" README: Toggle paste mode.
map <leader>pp :set paste!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/95139#95139
" Comment to this answer: Instead of manually typing nohlsearch, try mapping
" it. Ctrl-L already redraws the screen, so I make it also and remove search
" highlighting: ... pydave Feb 23 at 19:04
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Requires vim-eunuch.
if exists('g:loaded_eunuch')
  " Use Sudowrite instead of write.
  cmap w!! :call Sudowrite()
else
  cmap w!! %!sudo tee > /dev/null %
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN README: coc-terminal

function! ToggleSigns()
  if (&signcolumn == "yes" || &signcolumn == "number")
    set signcolumn=no
  else
    if (&number == 1 || &relativenumber == 1)
      set signcolumn=number
    else
      set signcolumn=yes
    endif
  endif
endfunction

" Toggle showing of signs
map <leader>signs :call ToggleSigns()<CR>

" END README

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