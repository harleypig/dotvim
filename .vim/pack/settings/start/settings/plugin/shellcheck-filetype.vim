augroup shellcheckfiletype
    autocmd!
    autocmd BufRead,BufNewFile * call ShellcheckFileType()
augroup END

function! ShellcheckFileType() abort
    let l:first_line = getline(1)
    let l:matches = matchlist(l:first_line, '#\s*shellcheck\s*shell=\zs\w\+\ze')

    if !empty(l:matches)
        let l:filetype = l:matches[0]
        if l:filetype ==# 'dash' || l:filetype ==# 'busybox'
            execute 'setfiletype sh'
        elseif l:filetype ==# 'bash' || l:filetype ==# 'sh' || l:filetype ==# 'ksh'
            execute 'setfiletype ' . l:filetype
        endif
    endif
endfunction
