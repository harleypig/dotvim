" vim-polyglot's JSON syntax file sources every ftplugin/json.vim, this one
" included, whenever JSON syntax loads: with filetype plugins off, and in
" buffers that embed JSON syntax, such as Dockerfiles. Stop here unless the
" filetype plugin mechanism is on and this buffer is JSON.
if !exists('g:did_load_ftplugin')
  \ || empty(filter(split(&filetype, '\.'), 'v:val =~# "^jsonc\\=$"'))
  finish
endif

setlocal foldmethod=syntax

let g:ale_fixers.json = ['jq']
let g:ale_fixers.jsonc = ['jq']
