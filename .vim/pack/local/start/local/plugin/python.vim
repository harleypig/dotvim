" Vim as a Python IDE
" https://rapphil.github.io/vim-python-ide/
"
" ALE
" Available Linters: [
" 'bandit', 'cspell', 'flake8', 'flakehell',
" 'jedils', 'mypy', 'prospector', 'pycodestyle',
" 'pydocstyle', 'pyflakes', 'pylama', 'pylint',
" 'pylsp', 'pyre', 'pyright', 'unimport', 'vulture']

let g:ale_linters = {'python': ['pylint']}

let g:ale_fix_on_save = 1
"let g:ale_fixers = {'python': []}
let g:ale_fixers = {'python': ['autoflake','autopep8','black','isort','pyflyby','remove_trailing_lines','reorder-python-imports','trim_whitespace','yapf']}
