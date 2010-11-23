" From vim-perl/syntax/perl.vim
" defaults are commented
let g:perl_include_pod=1
" unlet perl_no_scope_in_variables
" unlet perl_no_extended_vars
let perl_string_as_statement=1
" unlet perl_no_sync_on_sub
" unlet perl_no_sync_on_global_var
" let perl_sync_dist = 100
" unlet perl_fold
let g:perl_fold=1
let g:perl_fold_blocks=1
let g:perl_nofold_subs=1

" Sets make and errorformat for perl (see $VIMRUNTIME/compiler/perl)
compiler perl
"setlocal shellpipe=2>&1\ >
"setlocal makeef=errors.err

" Use perltidy for the '=' command
setlocal equalprg=perltidy

" Sort this section by doing the following (it will ignore the 'set no' or
" 'set   ' and sort by keywords :

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,11)cmp substr$b,11}@a'

setlocal   autoindent
setlocal   autoread
setlocal   autowrite
setlocal   confirm
setlocal nocopyindent
setlocal nocursorline
setlocal   foldenable
setlocal nohidden
setlocal   hlsearch
setlocal   incsearch
setlocal   lazyredraw
setlocal   more
setlocal   shiftround
setlocal   smartindent
setlocal   smarttab

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,9)cmp substr$b,9}@a'

setlocal cinkeys-=0#
setlocal diffopt=filler,iwhite
setlocal fillchars=fold:=,diff:=
setlocal foldcolumn=5
setlocal foldlevelstart=0
setlocal foldmethod=syntax
setlocal guioptions+=agimrLt
setlocal matchtime=3
setlocal nrformats=octal,hex,alpha

hi BufferSelected term=reverse ctermfg=white ctermbg=red cterm=bold
hi BufferNormal term=NONE ctermfg=black ctermbg=darkcyan cterm=NONE

" Found here: http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/103606#103606
autocmd BufWritePre * if &filetype == 'perl' | call StripTrailingWhitespace() | endif

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

" Perl code goes here
if has( 'perl' )
perl << EOP

use strict;

eval "use PPIx::LineToSub";
my $PPIxLineToSub = $@ ? 0 : 1;
sub testPerl { VIM::Msg( "PPIxLineToSub: $PPIxLineToSub" ); }
EOP

function! Tperl()
  perl testPerl()
endfunction

endif

"#if ( $PPIxLineToSub ) {
"#
"#  eval q{ sub StatusLineSubName {
"#
"#my $d = PPI::Document->new( './efm_perl.pl' );
"#$d->index_line_to_sub;
"#return $d->line_to_sub( +shift );
"#
"#};

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

"let g:acp_behavior = {}
"let g:def_perl_comp_bfunction = 1
"let g:def_perl_comp_packagen = 1
"call extend(g:acp_behavior, PerlCompletionBehavior(), 'keep')

" FindFuncName - Find the name of the function you are editing
" http://www.vim.org/scripts/script.php?script_id=1628
"map \func :echo FunctionName()<CR>
"setlocal statusline+=\ %{FunctionName()}

" Found here: http://www.vim.org/scripts/script.php?script_id=2852
"fun! PerlCompletionBehavior()
"  let behavs = {'perl':[]}
"  call add(behavs.perl, {
"        \   'command' : "\<C-X>\<C-o>",
"        \   'pattern' : printf('\w->\k\{%d,}$',1),
"        \   'repeat'  : 0,
"        \ })
"  return behavs
"endf

"autocmd BufNewFile *.pm 0r ~/.vim/skeleton/perl_package.pm
"autocmd BufNewFile *.pl 0r ~/.vim/skeleton/perl_script.pl
