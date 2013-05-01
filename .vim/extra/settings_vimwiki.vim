" VimWiki    http://code.google.com/p/vimwiki/

let g:vimwiki_auto_checkbox   = 1
let g:vimwiki_listsyms        = ' _\-+X'
let g:vimwiki_folding         = 'expr'
let g:vimwiki_file_exts       = 'pdf,txt,doc,rtf,xls,php,zip,rar,7z,html,gz,pl,cgi'
let g:vimwiki_customwiki2html = '~/.vim/tools/vimwiki2html.sh'

" http://code.google.com/p/vimwiki/wiki/MultipleWikies
let g:vimwiki_list = [{ 'path': '~/Dropbox/vimwiki/main' },
                    \ { 'path': '~/Dropbox/vimwiki/verio', 'auto_export': 1 },
                    \ { 'path': '~/Dropbox/vimwiki/wcec' }]
