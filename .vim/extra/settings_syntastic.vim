" Syntastic  http://www.vim.org/scripts/script.php?script_id=2736
"            http://github.com/scrooloose/syntastic/
"            In .vim/bundle/syntastic

"syntastic_javascript_closure_compiler_file_list
"syntastic_javascript_closure_compiler_options
"syntastic_javascript_closure_compiler_path
"syntastic_javascript_gjslint_conf
"syntastic_javascript_jshint_conf
"syntastic_javascript_jsl_conf
"syntastic_javascript_jslint_conf

"" Global settings
"" Section 2.2 Error signs
"let g:syntastic_enable_signs=1
"" Section 4 Options
"let g:syntastic_check_on_open=1
"let g:syntastic_echo_current_error=0
""syntastic_error_symbol='>>'
""syntastic_style_error_symbol='S>'
""syntastic_warning_symbol='>>'
""syntastic_style_warning_symbol='S>'
"let g:syntastic_enable_balloons=0
"let g:syntastic_enable_highlighting=1
"let g:syntastic_auto_jump=0
"let g:syntastic_auto_loc_list=2
"let g:syntastic_loc_list_height=10
""syntastic_mode_map
"let g:syntastic_quiet_warnings=0
""let g:syntastic_stl_format = '[%E{Error @ %fe (#%e)}%B{, }%W{Warning @ %fw (#%w)} \err toggles]'
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{:}%W{Warn: %fw #%w} does \err still toggle?]'

" Perl settings
"let g:syntastic_perl_lib_path = './lib'
let g:syntastic_perl_efm_program='~/.vim/tools/efm_perl.pl -I . -I ./lib'

"nmap <Leader>err :SyntasticToggleMode<CR>

"" Stolen from http://mg.pov.lt/vim/plugin/quickloclist.vim
"" Returns 1 if the current buffer has an open location list, 0 otherwise.
"function! LocListOpen()
"  let curwinnr = winnr()
"  let mylist = getloclist(curwinnr)
"  if mylist == []
"    return 0
"  endif
"  for winnr in range(1, winnr('$'))
"    if winnr != curwinnr
"        \ && winbufnr(winnr) != -1
"        \ && (getwinvar(winnr, '&buftype') == 'quickfix' || getwinvar(curwinnr, '&buftype') == 'quickfix')
"        \ && getloclist(winnr) == mylist
"      return 1
"    endif
"  endfor
"  return 0
"endf
"
"function! ToggleLocList()
"  if LocListOpen()
"    lclose
"  else
"    lwin
"    wincmd W
"  endif
"endf
"
"command! ToggleLocList :call ToggleLocList()
"nmap <Leader>err ToggleLocList<CR>
