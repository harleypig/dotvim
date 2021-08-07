" VimWiki: https://github.com/vimwiki/vimwiki

let g:vimwiki_auto_checkbox   = 1
"let g:vimwiki_customwiki2html = '~/.vim/tools/vimwiki2html.sh'
"let g:vimwiki_file_exts       = 'pdf,txt,doc,rtf,xls,php,zip,rar,7z,html,gz,pl,cgi'
"let g:vimwiki_folding         = 'expr'
let g:vimwiki_global_ext      = 0
let g:vimwiki_listsyms        = ' _+X'

" http://code.google.com/p/vimwiki/wiki/MultipleWikies
let g:vimwiki_list = [
      \ {'path': '~/projects/sites/mywiki/pages', 'syntax': 'markdown', 'ext': 'md'},
      \ {'path': '~/projects/sites/housewiki/pages', 'syntax': 'markdown', 'ext': 'md'},
      \ {'path': '~/projects/sites/scripturestudy/pages', 'syntax': 'markdown', 'ext': 'md'},
      \ {'path': '~/projects/sites/carrie/pages', 'syntax': 'markdown', 'ext': 'md'}
      \ ]
