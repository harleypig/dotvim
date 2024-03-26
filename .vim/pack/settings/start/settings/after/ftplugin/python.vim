" Configure isort if it's available.
" https://pycqa.github.io/isort

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal autoindent
setlocal smartindent

let g:ale_fixers = {}

if executable('isort')
  let g:ale_fixers.python = ['isort']
  let g:ale_python_isort_auto_poetry = 1
endif
