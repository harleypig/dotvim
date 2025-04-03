" Configure isort if it's available.
" https://pycqa.github.io/isort

let g:ale_fixers = {}

if executable('isort')
  let g:ale_fixers.python = ['isort']
  let g:ale_python_isort_auto_poetry = 1
endif

if executable('yapf')
  if !has_key(g:ale_fixers, 'python')
    let g:ale_fixers.python = []
  endif
  call add(g:ale_fixers.python, 'yapf')
endif

" Force 2-space indentation for Python (overriding any other settings)
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
