" g:ale_fixers is shared by every filetype, so only the python key is set
" here. Left unset when neither tool is installed, so the '*' fixers apply.
"
" Configure isort if it's available.
" https://pycqa.github.io/isort

let g:ale_fixers.python = []

if executable('isort')
  call add(g:ale_fixers.python, 'isort')
  let g:ale_python_isort_auto_poetry = 1
endif

if executable('yapf')
  call add(g:ale_fixers.python, 'yapf')
endif

if empty(g:ale_fixers.python)
  unlet g:ale_fixers.python
endif

" Force 2-space indentation for Python (overriding any other settings)
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
