function! ShellcheckFileType() abort
    let l:first_line = getline(1)
    let l:matches = matchlist(l:first_line, '#\s*shellcheck\s*shell=\zs\w\+\ze')
    if !empty(l:matches)
        let l:filetype = l:matches[0]
        execute 'setfiletype ' . l:filetype
    endif
endfunction

autocmd BufRead,BufNewFile * call ShellcheckFileType()

" Define a function to determine the filetype based on the shellcheck directive
function! ShellcheckFileType() abort
    let l:first_line = getline(1)
    let l:matches = matchlist(l:first_line, '#\s*shellcheck\s*shell=\zs\w\+\ze')
    if !empty(l:matches)
        let l:filetype = l:matches[0]
        execute 'setfiletype ' . l:filetype
    endif
endfunction

" Use an autocommand to set the filetype based on the function's return value
autocmd BufRead,BufNewFile * let l:ft = ShellcheckFileType() | if !empty(l:ft) | execute 'setfiletype ' . l:ft | endif
