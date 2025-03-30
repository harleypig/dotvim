" Stolen from https://github.com/mhz/dotfiles , from his
" .vim/ftplugin/sshconfig.vim file

if exists ( "b:did_ftplugin" )
  finish
endif

let b:did_ftplugin = 1
set keywordprg=man\ -P\ \'less\ -p\ <cword>\'\ ssh_config
