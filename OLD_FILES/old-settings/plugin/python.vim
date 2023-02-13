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

" Do I need both isort and reorder-python-imports?
" pyflyby is similar to isort and reorder-python-imports.
" yapf is a formatter, using something else
" autoflake manages imports, using something else

let g:ale_fixers = {'python': ['autopep8','isort','remove_trailing_lines','trim_whitespace']}

"let g:ale_fixers = {'python': ['black']}
