""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  abolish         https://github.com/tpope/vim-abolish
"
"  vim casts       http://vimcasts.org/episodes/smart-search-with-subvert/
"                  http://vimcasts.org/episodes/supercharged-substitution-with-subvert/
"                  http://vimcasts.org/episodes/enhanced-abbreviations-with-abolish/

"  DISABLED until I can spend the time to learn how to use it.
"
"  Check out https://github.com/nelstrom/vim-americanize in conjunction with this plugin.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  align           https://github.com/vim-scripts/Align
"                  http://www.drchip.org/astronaut/vim/align.html

" XXX: Needs to be updated from the drchip link above. Perhaps put up my own
"      github repo.

" I'm using this simply, but it's much more powerful than that.  Currently,
" I'm using "<range>Align char(s)" to align columns of code manually. But
" there is more ...

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  autoalign       https://github.com/vim-scripts/AutoAlign
"                  http://www.drchip.org/astronaut/vim/index.html#AUTOALIGN

" This is used in conjunction with the align plugin above. There is no perl
" specific file.  Look into creating one, possibly integrating with vim-perl.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  ansiesc         https://github.com/vim-scripts/AnsiEsc.vim
"                  http://drchip.org/astronaut/vim/index.html#ANSIESC

" There are no settings for this.  Just do :AnsiEsc when you have ansi codes
" in your document.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  autoclose       https://github.com/Townk/vim-autoclose

" There are no settings for this.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  cscope_macros   https://github.com/vim-scripts/cscope_macros.vim
"                  http://cscope.sourceforge.net/
"                  http://cscope.sourceforge.net/cscope_vim_tutorial.html

"  DISABLED until I can spend the time to learn how to use it.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  drawit          https://github.com/vim-scripts/DrawIt
"                  http://www.drchip.org/astronaut/vim/index.html#DRAWIT

" DISABLED ... I'm not sure how much use I'll get out of this.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  editexisting    $VIMRUNTIME/macros/editexisting.vim

" There are no settings for this plugin.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  eunuch          https://github.com/tpope/vim-eunuch

" This plugin replaces my own Chmod (found in after/ftplugin/perl.vim) and w!!
" (found in settings/plugin/settings_misc.vim).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  evervim         https://github.com/kakkyz81/evervim

"  DISABLED ... I don't use evernote much.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  fugitive        https://github.com/tpope/vim-fugitive
"
"  vim casts       http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/
"                  http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
"                  http://vimcasts.org/episodes/fugitive-vim-resolving-merge-conflicts-with-vimdiff/
"                  http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
"                  http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  github          https://github.com/thinca/vim-github

" There are no settings for this plugin.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  gundo
"
"  vim casts       http://vimcasts.org/episodes/undo-branching-and-gundo-vim/

"  DISABLED until I can spend the time to learn how to use it.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  indent-guides   https://github.com/nathanaelkane/vim-indent-guides

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size  = 1
let g:indent_guides_start_level = 2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  justify         $VIMRUNTIME/macros/justify.vim

" There are no settings for this plugin.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  matchit         $VIMRUNTIME/macros/matchit.vim

" This is included in the vim distribution, but I've put it in my bundle
" directory to be less confusing to myself.

" I've set a matchit for if/elsif/else in after/ftplugin/perl.vim and vim-perl
" has a match_skip in bundle/vim-perl/ftplugin/perl.vim.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  matchtag        https://github.com/gregsexton/MatchTag

" There are no settings for this plugin.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  pathogen        https://github.com/tpope/vim-pathogen
"
"  vim casts       http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
"  other sites     http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen

" See .vimrc for pathogen usage.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  perlomni        https://github.com/c9s/perlomni.vim

" No settings at this time.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  showmarks       http://github.com/vim-scripts/showmarks

let g:showmarks_enable      = 0
let g:showmarks_ignore_type = "hpq"
let g:showmarks_textlower   = "\t"
let g:showmarks_textupper   = "\t"
let g:showmarks_textother   = "\t"

hi ShowMarksHLl ctermfg=white ctermbg=black cterm=bold guifg=blue guibg=lightblue gui=bold
hi ShowMarksHLu ctermfg=white ctermbg=black cterm=bold guifg=blue guibg=lightblue gui=bold
hi ShowMarksHLo ctermfg=white ctermbg=black cterm=bold guifg=blue guibg=lightblue gui=bold
hi ShowMarksHLm ctermfg=white ctermbg=black cterm=bold guifg=blue guibg=lightblue gui=bold

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  spacehi         https://github.com/jpalardy/spacehi.vim

" Don't highlight spaces in these filetypes
let blacklist = [ 'help', 'man', 'calendar' ]
autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * if index( blacklist, &ft ) < 0 | autocmd syntax * SpaceHi

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  speeddating     https://github.com/tpope/vim-speeddating

"  DISABLED ... I don't seem to have much use for this plugin.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  sshconfig

"  Just adds a keywordprg for editing sshconfig.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  statusline

" This is my own module. There is nothing to set here, at least for now.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  supertab        https://github.com/ervandew/supertab

" No settings at this time.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  surround        https://github.com/tpope/vim-surround

" There are no settings for this module

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  syntastic       https://github.com/scrooloose/syntastic

" See settings_syntastic.vim

" XXX: These colors are not taking affect!

hi SyntasticErrorSign ctermfg=darkred ctermbg=lightred
hi SyntasticStyleErrorSign ctermfg=darkred ctermbg=lightred
hi SyntasticWarningSign ctermfg=yellow ctermbg=lightred
hi SyntasticStyleWarningSign ctermfg=yellow ctermbg=lightred

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  taglist

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  timestamp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  unimpaired

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  vcscommand

" See settings_vcscommand.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  vim-commentary

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  vim-perl        https://github.com/petdance/vim-perl

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  vim-repeat

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  vim-signify

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  vimwiki

" See settings_vimwiki.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" calendar

let g:calendar_google_calendar = 1
let g:calendar_google_task     = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax plugins
"  gitolite        https://github.com/tmatilai/gitolite.vim
"  irssilog        https://github.com/vim-scripts/irssilog.vim

"  ledger          https://github.com/vim-scripts/ledger.vim
" Change *.ldg,*.ledger to whatever extension you have on your ledger files.
au BufNewFile,BufRead *.ldg,*.ledger setf ledger

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins To Checkout

" Snipmate      http://www.vim.org/scripts/script.php?script_id=2540
"               https://github.com/garbas/vim-snipmate
"               https://github.com/honza/snipmate-snippets
" Google Script https://github.com/dubenstein/vim-google-scribe
" SVNDiff       http://www.vim.org/scripts/script.php?script_id=1881
" NERDTree      https://github.com/scrooloose/nerdtree
" ctrlp         https://github.com/kien/ctrlp.vim

" Grammar Check
" LanguageTool  http://www.vim.org/scripts/script.php?script_id=3223

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Checked out and decided not to use ...
"
"  gitv            https://github.com/gregsexton/gitv
"  hypergit        https://github.com/c9s/hypergit.vim
"  perlcritic      https://github.com/mattfoster/vim-Perl-Critic
