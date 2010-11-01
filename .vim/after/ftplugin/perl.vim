let g:acp_behavior = {}
let g:def_perl_comp_bfunction = 1
let g:def_perl_comp_packagen = 1
let g:perl_compiler_force_warnings = 0
let g:perl_extended_vars=1
let g:perl_fold=1
let g:perl_fold_blocks=1
let g:perl_include_pod=1
let g:perl_nofold_subs=1

" Sets make and errorformat for perl (see $VIMRUNTIME/compiler/perl)
compiler perl

" Use perltidy for the '=' command
setlocal equalprg=perltidy 

" Sort this section by doing the following (it will ignore the 'set no' or
" 'set   ' and sort by keywords :

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,11)cmp substr$b,11}@a'

setlocal   autoindent
setlocal   autoread
setlocal   autowrite
setlocal nocompatible
setlocal   confirm
setlocal nocopyindent
setlocal   cursorline
setlocal   expandtab
setlocal nofoldenable
setlocal   hidden
setlocal   hlsearch
setlocal   incsearch
setlocal   lazyredraw
setlocal   linebreak
setlocal   magic
setlocal   more
setlocal   ruler
setlocal   shiftround
setlocal   showcmd
setlocal   showmatch
setlocal   showmode
setlocal   smartindent
setlocal   smarttab
setlocal   terse
setlocal   timeout
setlocal   title
setlocal novisualbell
setlocal   wildmenu
setlocal nowrap

setlocal backspace=indent,eol,start
setlocal backupdir-=.
setlocal backupdir=/tmp
setlocal cinkeys-=0#
setlocal clipboard+=unnamed
setlocal com+=s1:/*,mb:*,ex:*/
setlocal comments=b://,b:#'
setlocal diffopt=filler,iwhite
setlocal directory-=.
setlocal directory=/tmp
setlocal display=uhex,lastline
setlocal encoding=utf-8
setlocal fillchars=fold:=,diff:=
setlocal foldcolumn=5
setlocal foldlevelstart=0
setlocal foldmethod=syntax
setlocal formatoptions=r
setlocal guioptions+=agimrLt
setlocal history=500
setlocal matchtime=3
setlocal mouse=
setlocal nrformats=octal,hex,alpha
setlocal numberwidth=5
setlocal pastetoggle=<S-F1>
setlocal path=.,$HOME,,
setlocal report=1
setlocal scrolloff=9999999
setlocal shiftwidth=2
setlocal shortmess=a
setlocal softtabstop=2
setlocal tabstop=2
setlocal undolevels=1000
setlocal updatetime=3000
setlocal virtualedit=block
setlocal whichwrap=b,s,<,>,[,]
setlocal wildignore+=*/CVS/
setlocal wildignore+=*/SVN/
setlocal wildmode=list:longest,full

hi BufferSelected term=reverse ctermfg=white ctermbg=red cterm=bold
hi BufferNormal term=NONE ctermfg=black ctermbg=darkcyan cterm=NONE

" FindFuncName - Find the name of the function you are editing
" http://www.vim.org/scripts/script.php?script_id=1628
map \func :echo FunctionName()<CR>

" setlocal statusline+=\ %{FunctionName()}
autocmd BufWritePre * if &filetype == 'perl' | call StripTrailingWhitespace() | endif
" autocmd BufNewFile *.pm 0r ~/.vim/skeleton/perl_package.pm
" autocmd BufNewFile *.pl 0r ~/.vim/skeleton/perl_script.pl

" Found here: http://www.vim.org/scripts/script.php?script_id=2852
fun! PerlCompletionBehavior()
  let behavs = {'perl':[]}
  call add(behavs.perl, {
        \   'command' : "\<C-X>\<C-o>",
        \   'pattern' : printf('\w->\k\{%d,}$',1),
        \   'repeat'  : 0,
        \ })
  return behavs
endf

call extend(g:acp_behavior, PerlCompletionBehavior(), 'keep')

" Found here: http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/103606#103606
fun! StripTrailingWhitespace()

  " Store current cursor location and search value
  silent exe "normal ma<CR>"
  let saved_search = @/

  " delete the nasty whitespace
  %s/\s\+$//e

  " restore the stuff we saved
  silent exe "normal `a<CR>"
  let @/ = saved_search

endf

" type 'Chmod' to set execute for owner only
command! -bar -nargs=* Chmod :!chmod 0700 % <args>

" type 'Run' to run the current script
command! -bar -nargs=* Run :!./% <args>

" type 'Debug' to run the current script in the debugger
command! -bar -nargs=* Debug call WhichDebugger(<q-args>)

" can we run ptkdb or not?
function! WhichDebugger(args)
	if has('gui_running')
		execute "!perl -d:ptkdb " . fnameescape(expand("%")) . " " . a:args
		"execute "!ddd --perl " . fnameescape(expand('%')) . ' ' . a:args
	else
		execute "!perl -d " . fnameescape(expand("%")) . " " . a:args
	endif
endfunction

" How do I turn off autocommenting?
" autocmd FileType perl iab usrbinperl #!/usr/bin/perl<CR><CR>use strict;<CR>use warnings;<CR><CR>
"
" Need to experiment with this to make it work correctly, plus you can't just enter the word dumper
" autocmd FileType perl imap dumper <ESC>^iwarn Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']);<ESC>
"
" Omnicompletion for perl: http://www.vim.org/scripts/script.php?script_id=1924 
"
" Where are identifiers used? http://vimdoc.sourceforge.net/htmldoc/tips.html#ident-search

" How can these options be used in perl development?
" format*
" indentexpr
" keywordprg (default is too basic)
" omnifunc
" operatorfunc (g2)
" paragraphs
" spell*
