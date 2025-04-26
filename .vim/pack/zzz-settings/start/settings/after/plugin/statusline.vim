"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the statusline
"
" look into replacing this with https://github.com/Lokaltog/vim-powerline
" powerline has been obsoleted by https://github.com/bling/vim-airline

" After experimenting with airline I find I like a lot of the ideas, but
" I don't like not being able to put what I want where I want.  So, I need to
" continue to do my own.  However, I plan on ripping off as much as possible
" from airline and other statusline tips and tricks I find.

" XXX: Can I modify statusline for various types (help, quickfix, etc.)?

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
" Define the YASL configuration dictionary
if !exists("g:yasl")
  let g:yasl = {
    \ 'buffer': {
    \   'none_filetype': 'none',
    \   'modified': '+',
    \   'not_modified': '-',
    \   'not_modifiable': 'X',
    \   'readonly': 'RO',
    \   'modified_readonly': '+RO'
    \ },
    \ 'warnings': {
    \   'mixed_indent': '[mixed indenting]',
    \   'expand_tab': '[&et]',
    \   'trailing_space': '[trailing space]',
    \   'paste_mode': '[PASTE]',
    \   'no_paste_mode': ''
    \ },
    \ 'format': {
    \   'non_unix_format': '*%s*',
    \   'non_utf8_encoding': '*%s*'
    \ }
  \ }
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to generate the buffer info block
function! YASL_BufferInfo()
  " Buffer number with padding
  let l:bufinfo = '[' . printf('%02d', bufnr('%')) . ' '

  " Filetype
  if strlen(&filetype)
    let l:bufinfo .= &filetype
  else
    let l:bufinfo .= g:yasl.buffer.none_filetype
  endif

  let l:bufinfo .= ' '

  " Modification and read-only status with colors applied directly
  if !&modifiable
    " Not modifiable trumps everything
    let l:bufinfo .= g:yasl.buffer.not_modifiable
  elseif &readonly
    " Read-only files
    if &modified
      let l:bufinfo .= g:yasl.buffer.modified . g:yasl.buffer.readonly
    else
      let l:bufinfo .= g:yasl.buffer.readonly
    endif
  else
    " Normal files
    if &modified
      let l:bufinfo .= g:yasl.buffer.modified
    else
      let l:bufinfo .= g:yasl.buffer.not_modified
    endif
  endif

  " Close the bracket
  let l:bufinfo .= ']'

  return l:bufinfo
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to generate warnings section
function! YASL_Warnings()
  let l:warnings = []

  " File format warning
  if &fileformat != 'unix'
    call add(l:warnings, printf(g:yasl.format.non_unix_format, &fileformat))
  endif

  " File encoding warning
  if &fileencoding != '' && &fileencoding != 'utf-8'
    call add(l:warnings, printf(g:yasl.format.non_utf8_encoding, &fileencoding))
  endif

  " Mixed indent warning
  if !exists("b:statusline_tab_warning")
    let b:statusline_tab_warning = ''
    if &filetype != 'help'
      let l:tabs = search('^\t', 'nw') != 0
      let l:spaces = search('^ ', 'nw') != 0

      if l:tabs && l:spaces
        let b:statusline_tab_warning = g:yasl.warnings.mixed_indent
      elseif (l:spaces && !&et) || (l:tabs && &et)
        let b:statusline_tab_warning = g:yasl.warnings.expand_tab
      endif
    endif
  endif

  if b:statusline_tab_warning != ''
    call add(l:warnings, b:statusline_tab_warning)
  endif

  " Trailing space warning
  if !exists("b:statusline_trailing_space_warning")
    let b:statusline_trailing_space_warning = ''
    if &filetype != 'help' && search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = g:yasl.warnings.trailing_space
    endif
  endif

  if b:statusline_trailing_space_warning != ''
    call add(l:warnings, b:statusline_trailing_space_warning)
  endif

  " Paste mode warning
  if &paste
    call add(l:warnings, g:yasl.warnings.paste_mode)
  endif

  " Join all warnings with a space
  return join(l:warnings, ' ')
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale info for statusline
function! YASL_LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_warnings = l:counts.warning + l:counts.style_warning
  let l:all_info = get(l:counts, 'info', 0)
  let l:all_hints = get(l:counts, 'hint', 0)

  " Return null if there's nothing to display
  if l:counts.total == 0
    return ''
  endif

  let l:output = ''

  " Show diagnostics in descending order of severity without spaces
  if l:all_errors > 0
    let l:output .= '%#DiagnosticError#E' . l:all_errors . '%*'
  endif

  if l:all_warnings > 0
    let l:output .= '%#DiagnosticWarning#W' . l:all_warnings . '%*'
  endif

  if l:all_info > 0
    let l:output .= '%#DiagnosticInfo#I' . l:all_info . '%*'
  endif

  if l:all_hints > 0
    let l:output .= '%#DiagnosticHint#H' . l:all_hints . '%*'
  endif

  " Wrap in square brackets and add :\qf at the end
  return '[' . l:output . '%#warningmsg#:\qf]'
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Make sure the status line is empty before we start.
set statusline=

" Buffer information block
set statusline+=%{YASL_BufferInfo()}

set statusline+=%#warningmsg#
set statusline+=%(%{YASL_Warnings()}%)
set statusline+=%{%YASL_LinterStatus()%}
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

" recalculate the warnings when idle or after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
" Force refresh of warnings in the statusline
autocmd cursorhold,bufwritepost * let &ro=&ro
