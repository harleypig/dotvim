let g:is_bash = 1  " This tells Vim to use bash syntax for sh files

" coc.nvim is handling the LSP (including linters) so we don't need to setup
" shellcheck here.

" Custom shfmt fixer function (kept for reference but not currently used)
" vint: -ProhibitUnusedVariable
function! s:shfmt_fixer(buffer) abort
  let l:cwd = getcwd()
  let l:filename = expand('#' . a:buffer . ':p')
  let l:dirname = fnamemodify(l:filename, ':h')

  execute 'cd' l:dirname
  let l:fixer_result = ale#fixers#shfmt#Fix(a:buffer)
  execute 'cd' l:cwd

  return l:fixer_result
endfunction
" vint: +ProhibitUnusedVariable

" Alternative approach using the custom fixer (currently commented out)
"let b:ale_fixers = {'sh': function('s:shfmt_fixer')}

" Current approach using the built-in shfmt fixer
let b:ale_fixers = ['shfmt']

" Enable format on save
let b:ale_fix_on_save = 1

" ALE pipes the buffer to shfmt on stdin and adds only --filename, so the
" indent must be given here to match shiftwidth (set.vim). --write must never
" be: shfmt refuses it on stdin and the fix fails. Keep these in step with
" the shfmt keys in the repository's .editorconfig.
let g:ale_sh_shfmt_options =
  \ '--indent 2 ' .
  \ '--simplify ' .
  \ '--binary-next-line ' .
  \ '--case-indent ' .
  \ '--space-redirects '
