" Sort and align on = sign, ignoring comments
" Works with both visual selection and line ranges
" FIXME
"command! -range -buffer AlignEquals <line1>,<line2>!grep\ -v\ '^\#'\ |\ column\ -t\ -s\ '='\ -o\ ' = '
"vnoremap <buffer> <Leader>srt :call AlignEquals<CR>
"nnoremap <buffer> <Leader>srt :call AlignEquals<CR>
