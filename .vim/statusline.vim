"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the statusline
"   broken up for ease of manipulation and readability.

set laststatus=2

hi StatusLine ctermbg=White ctermfg=Black
au CmdwinEnter * hi StatusLine ctermbg=White ctermfg=Red
au CmdwinLeave * hi StatusLine ctermbg=White ctermfg=Black
au InsertEnter * hi StatusLine ctermbg=White ctermfg=DarkBlue
au InsertLeave * hi StatusLine ctermbg=White ctermfg=Black

let g:StatuslineTrailingSpaceText = '\s'
let g:StatuslineExpandTabText = '&et'
let g:StatuslineMixedIndentText = 'mixed-indenting'

"Make sure the status line is empty before we start.
set statusline=

" Buffer number
set statusline+=[%02n

" What type of file are we editing?
set statusline+=%(\ %{strlen(&filetype)?&filetype:'none'}%)

" Show - if this file is modifiable and hasn't been modified.
set statusline+=\ %(%{&modifiable&&&modified?'':'-'}%)

" This section needs to stand out, so we're using the warningmsg hilite.
set statusline+=%#warningmsg#

" Show + if this file is modifiable and has been modified, or X if it's not
" modifiable.
set statusline+=%(%{&modifiable?&modified?'+':'':'X'}%)

" We only want to see if the file format is not unix.
set statusline+=%(\ %{&fileformat!='unix'?'*'.&fileformat.'*':''}%)

" We only want to see if the file encoding is not utf-8.
set statusline+=%(\ %{(&fileencoding!='utf-8'&&&fileencoding!='')?'*'.&fileencoding.'*':''}%)

" Expand tab and mixed indenting warnings
set statusline+=%(\ %{StatuslineMixedIndentWarning()}%)

" Do we have trailing spaces somewhere in the file?
set statusline+=%(\ %{StatuslineTrailingSpaceWarning()}%)

" Read the Syntastic docs.
set statusline+=%(\ %{SyntasticStatuslineFlag()}%)

" Are we in paste mode?
set statusline+=%(\ %{&paste?'PASTE':''}%)

" Return colorscheme to normal.
set statusline+=%*]

" column and line # of total lines ; what percentage of the file are we at?
set statusline+=[%c%V:%02l/%02L\ %p%%]

" The ascii value under the cursor, human and hexadecimal formats.
set statusline+=[%03b:%02B]

" What does vim think is under the cursor?
set statusline+=%(\ %{synIDattr(synID(line('.'),col('.'),1),'name')}%)

" End of left justified, begin right justified.
set statusline+=%=

" Version Control Information
set statusline+=%(\ %{VCSCommandGetStatusLine()}%)

"Date time stamp for the current file.
"set statusline+=%{strftime('%D\ %T',getftime(expand('%:p')))}

" What are the permissions for the current file.
set statusline+=%(\ %{getfperm(expand('%'))}%)

" What size is the file?
set statusline+=%(\ %{FileSize()}%)

" What file are we editing?
set statusline+=\ %F

" found @ http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
function! FileSize()
  let bytes = getfsize(expand("%:p"))

  if bytes <= 0
    return ''
  elseif bytes < 1024
    return bytes
  elseif bytes < 1024 * 1024
    return ( bytes / 1024 ) . 'k'
  else
    return 'Why are you editing such a freaking huge file?'
  endif
endfunction

"recalculate the warnings when idle or after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

function! StatuslineMixedIndentWarning()

  if (&filetype == 'help')
    return ''
  endif

  if !exists("g:StatuslineMixedIndentText")
    let g:StatuslineMixedIndentText = '[mixed-indenting]'
  endif

  if !exists("g:StatuslineExpandTabText")
    let g:StatuslineExpandTabText = '[&et]'
  endif

  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning = g:StatuslineMixedIndentText
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = g:StatuslineExpandTabText
    else
      let b:statusline_tab_warning = ''
    endif
  endif

  return b:statusline_tab_warning
endfunction

function! StatuslineTrailingSpaceWarning()

  if (&filetype == 'help')
    return ''
  endif

  if !exists("g:StatuslineTrailingSpaceText")
    let g:StatuslineTrailingSpaceText = ' \s'
  endif

  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = g:StatuslineTrailingSpaceText
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif

  return b:statusline_trailing_space_warning
endfunction

"function! InsertStatuslineColor(mode)
"  if a:mode == 'i'
"    hi statusline ctermbg=0
"  elseif a:mode == 'r'
"    hi statusline ctermbg=3
"  else
"    hi statusline ctermbg=5
"  endif
"endfunction
"
"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi statusline ctermbg=4
"
"hi statusline term=bold cterm=bold ctermfg=3 ctermbg=4

