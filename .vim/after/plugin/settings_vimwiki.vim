" VimWiki    http://code.google.com/p/vimwiki/
"            Installed as a vimball 2011-08-01 ( v1.2 )
"            git show --pretty="format:" --name-only 98bf498 shows:
"            *** Changed, installed via hg, need to document this better! ***
"
"            .vim/.VimballRecord
"            .vim/autoload/vimwiki/base.vim
"            .vim/autoload/vimwiki/default.tpl
"            .vim/autoload/vimwiki/diary.vim
"            .vim/autoload/vimwiki/html.vim
"            .vim/autoload/vimwiki/lst.vim
"            .vim/autoload/vimwiki/style.css
"            .vim/autoload/vimwiki/tbl.vim
"            .vim/doc/tags <------------------- file was changed, not added
"            .vim/doc/vimwiki.txt
"            .vim/ftplugin/vimwiki.vim
"            .vim/plugin/vimwiki.vim
"            .vim/syntax/vimwiki.vim
"            .vim/syntax/vimwiki_default.vim
"            .vim/syntax/vimwiki_media.vim

let g:vimwiki_auto_checkbox = 1
let g:vimwiki_listsyms      = ' _-+X'
let g:vimwiki_folding       = 1
let g:vimwiki_fold_lists    = 1
let g:vimwiki_file_exts     = 'pdf,txt,doc,rtf,xls,php,zip,rar,7z,html,gz,pl,cgi'

" http://code.google.com/p/vimwiki/wiki/MultipleWikies
let g:vimwiki_list = [{ 'path': '~/Dropbox/vimwiki/main' },
                    \ { 'path': '~/Dropbox/vimwiki/work' },
                    \ { 'path': '~/Dropbox/vimwiki/web' }]
