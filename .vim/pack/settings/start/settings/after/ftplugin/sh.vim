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

" Configure shfmt options for the built-in fixer
" ALE automatically uses Vim's indent settings (shiftwidth), so options like
" '--indent=2' are not needed. ALE will pass:
" * --indent=<shiftwidth> based on Vim's settings
" * --filename=<current_filename> automatically
let g:ale_sh_shfmt_options =
      \ '--write ' .
      \ '--simplify ' .
      \ '--binary-next-line ' .
      \ '--case-indent ' .
      \ '--space-redirects '
