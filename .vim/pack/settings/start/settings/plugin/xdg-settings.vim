""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CleanOldFiles(directory, pattern, days) abort
    let l:current_time = localtime()
    let l:target_time = l:current_time - (a:days * 24 * 60 * 60)
    let l:files = split(globpath(a:directory, a:pattern), "\n")
    call filter(l:files, 'getftime(v:val) < l:target_time')
    call map(l:files, 'delete(v:val)')
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the XDG setup (to keep the home directory as clean as possible)
" https://wiki.archlinux.org/title/Vim#Workaround_for_XDG_Base_Directory_specification

set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p')
call CleanOldFiles(&backupdir, '*', 90)
call CleanOldFiles(&backupdir, '*', 90)

" see :h backup-table
" backup writebackup  action
" ----------------------------------
" off    off          no backup made
" off    on           backup current file, deleted afterwards (default)
" on     off          delete old backup, backup current file
" on     on           delete old backup, backup current file

" If you are having issues with some language servers, set nowritebackup
" either in this file or, preferably, the ftplugin for that filetype. See
" https://github.com/neoclide/coc.nvim/issues/649

set nobackup
set   writebackup

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
  set viminfofile=$XDG_STATE_HOME/vim/viminfo
endif

set viminfo=%10,'50,s1000,/1000,:1000

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p')
call CleanOldFiles(&undodir, '*', 90)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_home = $XDG_DATA_HOME.'/vim'
call mkdir($XDG_DATA_HOME.'/vim/spell', 'p')

set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p')
set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p')
