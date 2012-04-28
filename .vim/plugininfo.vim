"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins Installed

" ShowMarks  http://www.vim.org/scripts/script.php?script_id=152
"            http://github.com/vim-scripts/showmarks
"            In .vim/bundle/showmarks
let g:showmarks_ignore_type="hpq"
let g:showmarks_textlower="\t"
let g:showmarks_textupper="\t"
let g:showmarks_textother="\t"

" VCSCommand http://www.vim.org/scripts/script.php?script_id=90
"            http://repo.or.cz/w/vcscommand.git
"            In .vim/bundle/vcscommand

" For statusline (VCSCommandGetStatusLine)
let g:VCSCommandEnableBufferSetup=1

" Syntastic  http://www.vim.org/scripts/script.php?script_id=2736
"            http://github.com/scrooloose/syntastic/
"            In .vim/bundle/syntastic
let g:sytastic_check_on_open=1
let g:syntastic_echo_current_error=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons=0
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=2
let g:syntastic_loc_list_height=10
let g:syntastic_quiet_warnings=0
let g:syntastic_perl_efm_program='~/.vim/tools/efm_perl.pl'
let g:syntastic_stl_format='[%E{Error @ %fe (#%e)}%B{, }%W{Warning @ %fw (#%w)} "\err & \mode" toggles]'
nmap <Leader>mode :SyntasticToggleMode<CR>

" Stolen from http://mg.pov.lt/vim/plugin/quickloclist.vim
" Returns 1 if the current buffer has an open location list, 0 otherwise.
function! LocListOpen()
  let curwinnr = winnr()
  let mylist = getloclist(curwinnr)
  if mylist == []
    return 0
  endif
  for winnr in range(1, winnr('$'))
    if winnr != curwinnr
        \ && winbufnr(winnr) != -1
        \ && (getwinvar(winnr, '&buftype') == 'quickfix' || getwinvar(curwinnr, '&buftype') == 'quickfix')
        \ && getloclist(winnr) == mylist
      return 1
    endif
  endfor
  return 0
endf

function! ToggleLocList()
  if LocListOpen()
    lclose
  else
    lwin
    wincmd W
  endif
endf

command! ToggleLocList :call ToggleLocList()
nmap <Leader>err ToggleLocList<CR>

" Surround   http://www.vim.org/scripts/script.php?script_id=1697
"            http://github.com/tpope/vim-surround
"            In .vim/bundle/surround

" Align      http://www.vim.org/scripts/script.php?script_id=294
"            http://github.com/vim-scripts/Align
"            In .vim/bundle/align

" AutoAlign  http://www.vim.org/scripts/script.php?script_id=884
"            http://github.com/vim-scripts/AutoAlign
"            In .vim/bundle/autoalign

" Vim-Perl   http://github.com/petdance/vim-perl
"            In .vim/bundle/perl

" Pathogen   http://github.com/tpope/vim-pathogen
"            http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
"            http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
"            In .vim/bundle/pathogen

" Github     http://github.com/thinca/vim-github
"            In .vim/bundle/github

" PerlCritic https://github.com/mattfoster/vim-Perl-Critic
"            In .vim/bundle/perlcritic

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

" Fugitive   https://github.com/tpope/vim-fugitive
"            In .vim/bundle/fugitive

" gitv       https://github.com/gregsexton/gitv
"            In .vim/bundle/gitv

" quickfixstatus https://github.com/dannyob/quickfixstatus
"                In .vim/bundle/quickfixstatus

" :h 2html
" :h TOHtml
let g:html_no_progress   = 1
let g:html_number_lines  = 0
let g:html_dynamic_folds = 1
let g:html_use_xhtml     = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins To Checkout

" AutoComplPop  http://www.vim.org/scripts/script.php?script_id=1879
" Snipmate      http://www.vim.org/scripts/script.php?script_id=2540
" PerlOmni      http://www.vim.org/scripts/script.php?script_id=2852
" Google Script https://github.com/dubenstein/vim-google-scribe
" SVNDiff       http://www.vim.org/scripts/script.php?script_id=1881

" Look into looking for or creating a plugin for GRAC
" http://grac.sourceforge.net/
