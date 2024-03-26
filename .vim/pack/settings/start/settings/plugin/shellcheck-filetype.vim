"autocmd BufRead,BufNewFile * if getline(1) =~ '# shellcheck shell=bash' | setfiletype bash | endif
"autocmd BufRead,BufNewFile * if getline(1) =~ '# shellcheck shell=busybox' | setfiletype sh | endif
"autocmd BufRead,BufNewFile * if getline(1) =~ '# shellcheck shell=dash' | setfiletype sh | endif
"autocmd BufRead,BufNewFile * if getline(1) =~ '# shellcheck shell=ksh' | setfiletype ksh | endif
"autocmd BufRead,BufNewFile * if getline(1) =~ '# shellcheck shell=sh' | setfiletype sh | endif

" Define a function to determine the filetype based on the shellcheck directive
function! ShellcheckFileType() abort
    let l:first_line = getline(1)

    if l:first_line =~ '#\s*shellcheck\s*shell=bash'
        return 'bash'
    elseif l:first_line =~ '#\s*shellcheck\s*shell=sh'
        return 'sh'
    elseif l:first_line =~ '#\s*shellcheck\s*shell=dash'
        return 'sh'
    elseif l:first_line =~ '#\s*shellcheck\s*shell=ksh'
        return 'ksh'
    elseif l:first_line =~ '#\s*shellcheck\s*shell=busybox'
        return 'sh'
    else
        return ''
    endif
endfunction

" Use an autocommand to set the filetype based on the function's return value
autocmd BufRead,BufNewFile * let l:ft = ShellcheckFileType() | if !empty(l:ft) | execute 'setfiletype ' . l:ft | endif
