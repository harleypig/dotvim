" Configure ALE to use vim-language-server for Vimscript
let b:ale_linters = {}
let b:ale_fixers = ['vimls']

let b:ale_vim_vimls_executable = 'vim-language-server'
let b:ale_vim_vimls_use_global = 1

" Add vint as an ALE linter for Vimscript
let b:ale_linters['vim'] = ['vint', 'vimls']
