function! ShellcheckFileType() abort
    let l:first_line = getline(1)
    let l:matches = matchlist(l:first_line, '#\s*shellcheck\s*shell=\zs\w\+\ze')

    if !empty(l:matches)
        let l:filetype = l:matches[0]
        execute 'setfiletype ' . l:filetype
    endif
endfunction

autocmd BufRead,BufNewFile * call ShellcheckFileType()
