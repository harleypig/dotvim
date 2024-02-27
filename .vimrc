" Exmellent HTML formatted copy of the VIm documentation at
" https://vimhelp.org

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use coc for lsp functions, not ale
let g:ale_disable_lsp = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable syntax highlighting with vim-polyglot before loading the plugin.
" let g:polyglot_disable = ['filetype', 'filetype']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install these extensions if they aren't already.
" This list has to exist before coc is loaded.

" This is a hack to get coc to install the extensions.  It's not documented
" anywhere, but it works.  The extensions are installed asynchronously, so
" it's not a big deal if they aren't installed immediately.

" XXX: Figure out a way to update this list automatically, or at least on
" demand.
" https://github.com/neoclide/coc.nvim/issues/2857
"
" A list of installed extensions can be found in
" ~/.config/coc/extensions/package.json

" This list has to exist before coc is loaded.
let g:coc_global_extensions = [
    \ 'coc-diagnostic',
    \ 'coc-docker',
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-sh',
    \ 'coc-toml',
    \ 'coc-vimlsp',
    \ '@yaegassy/coc-ansible',
    \ '@yaegassy/coc-ansible'
    \]

" coc-coverage
" coc-db
" coc-dictd
" coc-git
" coc-lists
" coc-markdownlint
" coc-pairs
" coc-prettier
" coc-pydocstring
" coc-smartf
" coc-sql
" coc-tasks
" coc-terminal
" coc-toml
" coc-yaml

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load all plugins in .vim/pack/*/start
" This is done by default, it's not needed.
"packloadall!

" Map yaml.ansible filetype to ansible for coc-ansible extension
let g:coc_filetype_map = {
    \ 'yaml.ansible': 'ansible',
    \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile the help tags for all plugins
helptags ALL

function! ShowLanguageServer()
  let l:info = coc#rpc#request('workspace/showOutput', 'languageserver')
  if l:info == v:null
    echo "No language server is active for the current buffer."
  else
    echo l:info
  endif
endfunction

command! LanguageServer call ShowLanguageServer()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme norwaytoday
