"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the statusline
"
" look into replacing this with https://github.com/Lokaltog/vim-powerline
" powerline has been obsoleted by https://github.com/bling/vim-airline

" After experimenting with airline I find I like a lot of the ideas, but
" I don't like not being able to put what I want where I want.  So, I need to
" continue to do my own.  However, I plan on ripping off as much as possible
" from airline and other statusline tips and tricks I find.

set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"hi StatusLine ctermbg=White ctermfg=Black
hi StatusLine ctermbg=black ctermfg=white
"hi User1 ctermbg=White ctermfg=Red
"hi WarningMsg ctermbg=White ctermfg=Red
au CmdwinEnter * hi StatusLine ctermbg=Gray ctermfg=Red
au CmdwinLeave * hi StatusLine ctermbg=White ctermfg=Black
au InsertEnter * hi StatusLine ctermbg=Yellow ctermfg=Blue
au InsertLeave * hi StatusLine ctermbg=White ctermfg=Black

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists("g:YASL_NoneFiletype")
  let g:YASL_NoneFiletype = 'none'
endif

" Modify notification
if !exists("g:YASL_Modified")
  let g:YASL_Modified = '+'
endif

if !exists("g:YASL_NotModifiable")
  let g:YASL_NotModifiable = 'X'
endif

if !exists("g:YASL_NotModified")
  let g:YASL_NotModified = '-'
endif

if !exists("g:YASL_MixedIndentText")
  let g:YASL_MixedIndentText = '[mixed indenting]'
endif

if !exists("g:YASL_ExpandTabText")
  let g:YASL_ExpandTabText = '[&et]'
endif

if !exists("g:YASL_TrailingSpaceText")
  let g:YASL_TrailingSpaceText = '[trailing space]'
endif

if !exists("g:YASL_PasteMode")
  let g:YASL_PasteMode = '[PASTE]'
endif

if !exists("g:YASL_NoPasteMode")
  let g:YASL_NoPasteMode = ''
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale info for statusline
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  let l:output = ''

  if l:all_errors > 0
    let l:output .= '%#DiagnosticError#E' . l:all_errors . '%*'
  endif

  if l:all_non_errors > 0
    let l:output .= '%#DiagnosticWarning#W' . l:all_non_errors . '%*'
  endif

  return l:output
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" What non-ale information can I put here?
"function! StatusDiagnostic() abort
"  if ! exists("g:did_coc_loaded")
"    return ''
"  endif
"
"  let info = get(b:, 'coc_diagnostic_info', {})
"
"  if empty(info)
"    return ''
"  endif
"
"  let msgs = []
"
"  if get(info, 'error', 0)
"    call add(msgs, printf('E%d', info.error))
"  endif
"
"  if get(info, 'warning', 0)
"    call add(msgs, printf('W%d', info.warning))
"  endif
"
"  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
"endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Make sure the status line is empty before we start.
set statusline=

" Buffer number
set statusline+=[%02n
set statusline+=%(\ %{YASL_Filetype()}%)
set statusline+=%(\ %{YASL_IsModified()}%)
set statusline+=]

set statusline+=%#warningmsg#
"set statusline+=%1*
set statusline+=%(%{YASL_FileFormat()}%)
set statusline+=%(%{YASL_FileEncoding()}%)
set statusline+=%(%{YASL_MixedIndentWarning()}%)
set statusline+=%(%{YASL_TrailingSpaceWarning()}%)
set statusline+=%(%{YASL_PasteMode()}%)
set statusline+=%{%LinterStatus()%}
set statusline+=%*

" column and line # of total lines ; what percentage of the file are we at?
" and what size is the file?
set statusline+=[%c%V:%02l/%02L\ %p%%\ %{YASL_FileSize()}]

" The ascii value under the cursor, human and hexadecimal formats.
set statusline+=[%03b:%02B]

" What does vim think is under the cursor?
set statusline+=%([%{synIDattr(synID(line('.'),col('.'),1),'name')}]%)

" XXX: This doesn't update reliably
"set statusline+=%([%{get(b:,'coc_current_function','')}]%)

" End of left justified, begin right justified.
set statusline+=%=

" Version Control Information
" XXX: Add check for Fugitive being installed
"set statusline+=%{FugitiveStatusline()}

"Date time stamp for the current file.
"set statusline+=%{strftime('%D\ %T',getftime(expand('%:p')))}

" What are the permissions for the current file.
set statusline+=%(\ %{getfperm(expand('%'))}%)

" handled by StatusDiagnostic function above
" coc info
"if exists("g:did_coc_loaded")
"  set statusline+=%(\ %{coc#status()}%)
"endif

" What file are we editing?
set statusline+=\ %-.20F

" found @ http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
function! YASL_FileSize()
  let bytes = getfsize(expand("%:p"))

  if bytes <= 0
    return ''
  elseif bytes < 1024
    return bytes
  elseif bytes < 1024 * 1024
    return ( bytes / 1024 ) . 'k'
  else
    return 'TooDamnBig!'
  endif
endfunction

" recalculate the warnings when idle or after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

" Expand tab and mixed indenting warnings

function! YASL_MixedIndentWarning()
  if (&filetype == 'help')
    return ''
  endif

  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning = g:YASL_MixedIndentText
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = g:YASL_ExpandTabText
    else
      let b:statusline_tab_warning = ''
    endif
  endif

  return b:statusline_tab_warning
endfunction

function! YASL_TrailingSpaceWarning()
  " Need to move this to an array and allow for multiple filetypes to be skipped.
  if (&filetype == 'help')
    return ''
  endif

  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = g:YASL_TrailingSpaceText
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif

  return b:statusline_trailing_space_warning
endfunction

" Show X if this file is not modifiable.
" Show - if this file is modifiable and has not been modified.
" Show + if this file is modifiable and has been modified.

function! YASL_IsModified()
  if &modifiable
    if &modified
      let l:text = g:YASL_Modified
    else
      let l:text = g:YASL_NotModified
    endif
  else
    let l:text = g:YASL_NotModifiable
  endif

  return l:text
endfunction

" We only want to see if the file format is not unix.
function! YASL_FileFormat()
  if &fileformat == 'unix'
    let l:text = ''
  else
    let l:text = '*' . &fileformat . '*'
  endif

  return l:text
endfunction

" We only want to see if the file encoding is not utf-8.
function! YASL_FileEncoding()
  if &fileencoding == 'utf-8' || &fileencoding == ''
    let l:text = ''
  else
    let l:text = '*' . &fileencoding . '*'
  endif

  return l:text
endfunction

function! YASL_PasteMode()
  if &paste
    let l:text = g:YASL_PasteMode
  else
    let l:text = g:YASL_NoPasteMode
  endif

  return l:text
endfunction

function! YASL_Filetype()
  if strlen( &filetype )
    let l:text = &filetype
  else
    let l:text = g:YASL_NoneFiletype
  endif

  return l:text
endfunction
