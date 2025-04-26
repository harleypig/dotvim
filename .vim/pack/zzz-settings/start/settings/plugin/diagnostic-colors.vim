" Diagnostic Colors Configuration
" Standardizes colors for errors, warnings, etc. across different display methods

" Define color palette
let g:diagnostic_colors = {
  \ 'error': {
  \   'fg': 'White',
  \   'bg': 'DarkRed',
  \   'gui_fg': 'White',
  \   'gui_bg': 'DarkRed'
  \ },
  \ 'warning': {
  \   'fg': 'Black',
  \   'bg': 'Yellow',
  \   'gui_fg': 'Black',
  \   'gui_bg': 'Gold'
  \ },
  \ 'info': {
  \   'fg': 'White',
  \   'bg': 'Blue',
  \   'gui_fg': 'White',
  \   'gui_bg': 'RoyalBlue'
  \ },
  \ 'hint': {
  \   'fg': 'Black',
  \   'bg': 'LightGrey',
  \   'gui_fg': 'Black',
  \   'gui_bg': 'LightGrey'
  \ }
\ }

" Function to apply colors to highlight groups
function! s:ApplyDiagnosticColors()
  " ALE Sign Colors
  execute 'highlight ALEErrorSign ctermfg=' . g:diagnostic_colors.error.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.error.bg . 
        \ ' guifg=' . g:diagnostic_colors.error.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.error.gui_bg
  
  execute 'highlight ALEWarningSign ctermfg=' . g:diagnostic_colors.warning.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.warning.bg . 
        \ ' guifg=' . g:diagnostic_colors.warning.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.warning.gui_bg
  
  execute 'highlight ALEInfoSign ctermfg=' . g:diagnostic_colors.info.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.info.bg . 
        \ ' guifg=' . g:diagnostic_colors.info.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.info.gui_bg
  
  " CoC Sign Colors (even though ALE displays them, these are still used for some highlighting)
  execute 'highlight CocErrorSign ctermfg=' . g:diagnostic_colors.error.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.error.bg . 
        \ ' guifg=' . g:diagnostic_colors.error.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.error.gui_bg
  
  execute 'highlight CocWarningSign ctermfg=' . g:diagnostic_colors.warning.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.warning.bg . 
        \ ' guifg=' . g:diagnostic_colors.warning.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.warning.gui_bg
  
  execute 'highlight CocInfoSign ctermfg=' . g:diagnostic_colors.info.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.info.bg . 
        \ ' guifg=' . g:diagnostic_colors.info.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.info.gui_bg
  
  execute 'highlight CocHintSign ctermfg=' . g:diagnostic_colors.hint.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.hint.bg . 
        \ ' guifg=' . g:diagnostic_colors.hint.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.hint.gui_bg
  
  " Virtual Text Colors
  execute 'highlight ALEVirtualTextError ctermfg=' . g:diagnostic_colors.error.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.error.bg . 
        \ ' guifg=' . g:diagnostic_colors.error.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.error.gui_bg
  
  execute 'highlight ALEVirtualTextWarning ctermfg=' . g:diagnostic_colors.warning.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.warning.bg . 
        \ ' guifg=' . g:diagnostic_colors.warning.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.warning.gui_bg
  
  execute 'highlight ALEVirtualTextInfo ctermfg=' . g:diagnostic_colors.info.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.info.bg . 
        \ ' guifg=' . g:diagnostic_colors.info.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.info.gui_bg
  
  " Statusline Colors (for your custom statusline)
  execute 'highlight DiagnosticError ctermfg=' . g:diagnostic_colors.error.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.error.bg . 
        \ ' guifg=' . g:diagnostic_colors.error.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.error.gui_bg
  
  execute 'highlight DiagnosticWarning ctermfg=' . g:diagnostic_colors.warning.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.warning.bg . 
        \ ' guifg=' . g:diagnostic_colors.warning.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.warning.gui_bg
  
  execute 'highlight DiagnosticInfo ctermfg=' . g:diagnostic_colors.info.fg . 
        \ ' ctermbg=' . g:diagnostic_colors.info.bg . 
        \ ' guifg=' . g:diagnostic_colors.info.gui_fg . 
        \ ' guibg=' . g:diagnostic_colors.info.gui_bg
endfunction

" Apply colors when colorscheme changes
augroup DiagnosticColors
  autocmd!
  autocmd ColorScheme * call s:ApplyDiagnosticColors()
augroup END

" Apply colors immediately
call s:ApplyDiagnosticColors()
