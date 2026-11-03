" Excellent HTML formatted copy of the VIm documentation at
" https://vimhelp.org

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the XDG setup (to keep the home directory as clean as possible)
" https://wiki.archlinux.org/title/Vim#Workaround_for_XDG_Base_Directory_specification
"
" Because I've got my vim setup in a different repository, I need to make some
" modifications. Anything that would go under $XDG_CONFIG_HOME would have to
" go under $HOME/projects/dotvim instead.
"
" Put the required settings here, and the remainder in the xdg-settings.vim
" file in the settings/plugin directory.

" Unset or empty, XDG_DOTVIM is the checkout this file is in, found through
" a ~/.vimrc symlink; otherwise the paths below become /.vim and Vim starts
" on its defaults without a word.
if empty($XDG_DOTVIM)
  let $XDG_DOTVIM = fnamemodify(resolve(expand('<sfile>:p')), ':h')
endif

set runtimepath^=$XDG_DOTVIM/.vim
set packpath^=$XDG_DOTVIM/.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use coc for lsp functions, not ale. This needs to be disabled before ALE is
" loaded, so we're doing it here.
let g:ale_disable_lsp = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoC needs Node.js. Without it, setting coc.nvim's load guard keeps its
" plugin from loading, so Vim starts quietly with CoC switched off.
if !executable('node')
  let g:did_coc_loaded = 1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install these extensions if they aren't already.
" This list has to exist before coc is loaded.

" This is a hack to get coc to install the extensions.  It's not documented
" anywhere, but it works.  The extensions are installed asynchronously, so
" it's not a big deal if they aren't installed immediately.

" Run bin/update-coc-extensions to make sure this is setup correctly.

let g:coc_global_extensions = [
  \ 'coc-diagnostic',
  \ 'coc-docker',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-pyright',
  \ 'coc-sh',
  \ 'coc-toml',
  \ 'coc-vimlsp',
  \ '@yaegassy/coc-ansible',
  \]
