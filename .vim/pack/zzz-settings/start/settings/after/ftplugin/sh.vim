let g:is_bash = 1  " This tells Vim to use bash syntax for sh files

" coc.nvim is handling the LSP (including linters) so we don't need to setup
" shellcheck here.

let b:ale_fixers = ['shfmt']

" Enable format on save
let b:ale_fix_on_save = 1

" ALE pipes the buffer to shfmt on stdin and adds only --filename, so the
" indent must be given here to match shiftwidth (set.vim). --write must never
" be: shfmt refuses it on stdin and the fix fails. Keep these in step with
" the shfmt keys in the repository's .editorconfig.
let b:ale_sh_shfmt_options =
  \ '--indent 2 ' .
  \ '--simplify ' .
  \ '--binary-next-line ' .
  \ '--case-indent ' .
  \ '--space-redirects '
