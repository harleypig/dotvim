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
"
" An unset or empty variable takes the specification's default. Without the
" fallback, :set keeps an unset variable's name as a literal directory.

let s:state = empty($XDG_STATE_HOME) ? $HOME.'/.local/state' : $XDG_STATE_HOME
let s:data  = empty($XDG_DATA_HOME)  ? $HOME.'/.local/share' : $XDG_DATA_HOME

let &backupdir = s:state.'/vim/backup' | call mkdir(&backupdir, 'p')
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
let &viminfofile = s:state.'/vim/viminfo'
set viminfo=%10,'50,s1000,/1000,:1000
call CleanOldFiles(s:state.'/vim', 'viminfo', 180)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let &undodir = s:state.'/vim/undo' | call mkdir(&undodir,   'p')
call CleanOldFiles(&undodir, '*', 90)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_home = s:data.'/vim'
call mkdir(s:data.'/vim/spell', 'p')

let &directory = s:state.'/vim/swap'   | call mkdir(&directory, 'p')
call CleanOldFiles(&directory, '*', 90)

let &viewdir = s:state.'/vim/view'     | call mkdir(&viewdir,   'p')
call CleanOldFiles(&viewdir, '*', 90)
