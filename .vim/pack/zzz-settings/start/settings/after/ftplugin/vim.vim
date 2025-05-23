let g:vim_indent = #{
  \ line_continuation: shiftwidth(),
  \ }

" Configure ALE to use vim-language-server for Vimscript
"let b:ale_fixers = []

" Add vint as an ALE linter for Vimscript
"let b:ale_fixers = []

let b:ale_linters = ['vint', 'vimls']

let b:ale_vim_vimls_executable = 'vim-language-server'
let b:ale_vim_vimls_use_global = 1
