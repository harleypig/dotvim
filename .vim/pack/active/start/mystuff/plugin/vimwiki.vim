" VimWiki: https://github.com/vimwiki/vimwiki

" Global options

let g:vimwiki_auto_checkbox   = 1
let g:vimwiki_auto_chdir      = 1
"let g:vimwiki_customwiki2html = '~/.vim/tools/vimwiki2html.sh'
"let g:vimwiki_file_exts       = 'pdf,txt,doc,rtf,xls,php,zip,rar,7z,html,gz,pl,cgi'
"let g:vimwiki_folding         = 'expr'
let g:vimwiki_global_ext      = 0
let g:vimwiki_listsyms        = ' _+X'
let g:vimwiki_links_header    = 'Available Pages'

" Define wikis and local options
let defaults       = {
      \ 'automatic_nested_syntaxes': 1,
      \ 'auto_generate_links': 1,
      \ 'auto_tags': 1,
      \ 'auto_generate_tags': 1,
      \ 'ext': 'md',
      \ 'index': 'home',
      \ 'list_margin': 0,
      \ 'syntax': 'markdown'
      \}

let mywiki         = extend(copy(defaults), { 'path': '~/projects/sites/mywiki/pages' })
let housewiki      = extend(copy(defaults), { 'path': '~/projects/sites/housewiki/pages' })
let scripturestudy = extend(copy(defaults), { 'path': '~/projects/sites/scripturestudy/pages' })
let carrie         = extend(copy(defaults), { 'path': '~/projects/sites/carrie/pages' })

let g:vimwiki_list = [mywiki, housewiki, scripturestudy, carrie]
