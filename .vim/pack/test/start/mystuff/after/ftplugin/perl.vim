" From vim-perl/syntax/perl.vim
" defaults are listed
"
" let g:perl_include_pod=1
" unlet perl_no_scope_in_variables
" unlet perl_no_extended_vars
" unlet perl_string_as_statement
" unlet perl_no_sync_on_sub
" unlet perl_no_sync_on_global_var
" let perl_sync_dist = 100
" unlet perl_fold
" unlet perl_fold_blocks
" unlet perl_nofold_packages
" unlet perl_nofold_subs
" unlet perl_fold_anonymous_subs
" unlet perl_no_subprototype_error

let perl_string_as_statement=1

" Sets make and errorformat for perl (see $VIMRUNTIME/compiler/perl)
" XXX: Is this redundant?
"compiler perl
"setlocal shellpipe=2>&1\ >
"setlocal makeef=errors.err

" Use perltidy for the '=' command
setlocal equalprg=perltidy

" Sort this section by doing the following (it will ignore the 'set no' or
" 'set   ' and sort by keywords :

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,11)cmp substr$b,11}@a'

setlocal   autoread
setlocal   autowrite
setlocal   confirm
setlocal nofoldenable
setlocal   lazyredraw
setlocal   more
setlocal   shiftround
setlocal   smarttab

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,9)cmp substr$b,9}@a'

setlocal cinkeys-=0#
setlocal diffopt=filler,iwhite
setlocal fillchars=fold:=,diff:=
setlocal foldcolumn=5
setlocal foldlevelstart=0
setlocal foldmethod=syntax
setlocal guioptions+=agimrLt
setlocal iskeyword+=$,%,@
setlocal matchpairs+=<:>
setlocal matchtime=3
setlocal nrformats=octal,hex,alpha

iab dbs $DB::single = 1;<ESC>

" Extended pair matching via matchit
let b:match_words = '\<if\>:\<elsif\>:\<else\>'
"let b:match_debug = 1

" Jump to next/previous methods with ]m and [m
" https://groups.google.com/d/topic/vim-perl/vrOD7wNISNE/discussion
map <silent> ]m :call search('\v^\s*sub\s*\w+\s*(\(\s*.{-}\s*\))?\s*\{', 'W')<CR>
map <silent> [m :call search('\v^\s*sub\s*\w+\s*(\(\s*.{-}\s*\))?\s*\{', 'bW')<CR>

" Better handling of smartwrapping for perl, courtesy of
" https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
inoremap # X<C-H>#|
nnoremap <silent> >> :call ShiftLine()<CR>|

fun! ShiftLine()

  set nosmartindent
  normal! >>
  set smartindent

endfun

" Better handling of for include files, courtesy of
" https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
" How is this better than what is in vim-perl?
"set include=^\\s*use\\s\\+\\zs\\k\\+\\ze
"set includeexpr=substitute(v:fname,'::','/','g')
set suffixesadd=.pm
execute 'set path+=' . substitute($PERL5LIB, ':', ',', 'g')

" !!! Not a good idea to do this automatically.
" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/103606#103606
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
"autocmd BufWritePre    * if &filetype == 'perl' | call StripTrailingWhitespace() | endif
"autocmd FileAppendPre  * if &filetype == 'perl' | call StripTrailingWhitespace() | endif
"autocmd FileWritePre   * if &filetype == 'perl' | call StripTrailingWhitespace() | endif
"autocmd FilterWritePre * if &filetype == 'perl' | call StripTrailingWhitespace() | endif

fun! StripTrailingWhitespace()

  silent exe "normal mz<CR>"
  let saved_search = @/

  %s/\s\+$//e

  silent exe "normal `z<CR>"
  let @/ = saved_search

  delmarks z

endf

map <silent> <Leader>stw :call StripTrailingWhitespace()<Enter>

" Removed in favor of Tim Pope's Eunuch plugin
" type 'Chmod' to set execute for owner only
"command! -bar -nargs=* Chmod :!chmod 0700 % <args>

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

" Run perltidy and vimdiff
" https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
nmap <leader>pt :call Perltidy_diff()<CR>

function! Perltidy_diff ()
    " Work out what the tidied file will be called...
    let perl_file = expand( '%' )
    let tidy_file = perl_file . '.tdy'

    call system( 'perltidy -nst ' . perl_file . ' -o ' . tidy_file )

    " Add the diff to the right of the current window...
    set splitright
    exe ":vertical diffsplit " . tidy_file

    " Clean up the tidied version...
    call delete(tidy_file)
endfunction

" Tidy the whole file
nmap <leader>ptidy :call Perltidy_file()<CR>

function! Perltidy_file ()
  execute '%!perltidy'
endfunction

"" http://use.perl.org/~Ovid/journal/36929
"" Only works for subs defined in current package
"function! GotoSub(subname)
"    let files  = []
"
"    " find paths to modules with that sub
"    let paths = split(system("ack --perl -l 'sub\\s+".a:subname."' lib t/lib"), "\n")
"
"    if empty(paths)
"        echomsg("Subroutine '".a:subname."' not found")
"    else
"        let file = PickFromList('file', paths)
"        execute "edit +1 " . file
"
"        " jump to where that sub is defined
"        execute "/sub\\s\\+"  . a:subname . "\\>"
"    endif
"endfunction
"
"function! PickFromList( name, list, ... )
"    let forcelist = a:0 && a:1 ? 1 : 0
"
"    if 1 == len(a:list) && !forcelist
"        let choice = 0
"    else
"        let lines = [ 'Choose a '. a:name . ':' ]
"            \ + map(range(1, len(a:list)), 'v:val .": ". a:list[v:val - 1]')
"        let choice  = inputlist(lines)
"        if choice > 0 && choice <= len(a:list)
"            let choice = choice - 1
"        else
"            let choice = choice - 1
"        endif
"    end
"
"    return a:list[choice]
"endfunction
"
"noremap <Leader>gs :call GotoSub(expand('<cword>'))<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl code goes here
" http://vim.wikia.com/wiki/Using_embedded_Perl_interpreter

"if has( 'perl' )
"  function! EvalPerl()
"  perl << EOP
"use strict;
"use warnings FATAL => 'all', NONFATAL => 'redefine';
"
"eval "use PPIx::IndexLines";
"my $error = $@;
"my %hash;
"
"sub index_line {
"
"  if ( $error ) {
"
"    VIM::DoCommand "let subName='$error'";
"
"  } else {
"
"    my $curbuf = $main::curbuf;
"
"    if ( VIM::Eval( '&modified' ) || ! exists $hash{ $curbuf->Name } ) {
"
"      # There's got to be a better way to slurp in the current buffer!
"      my $document = join "\n", $curbuf->Get( 1 .. $curbuf->Count );
"
"      $hash{ $curbuf->Name } = PPIx::IndexLines->new( \$document );
"      $hash{ $curbuf->Name }->index_lines;
"
"    };
"
"    my ( $line ) = $main::curwin->Cursor;
"    my $sub_name = $hash{ $curbuf->Name }->line_type( $line );
"
"    VIM::DoCommand "let subName='$sub_name'";
"
"  }
"}
"EOP
"  endfunction
"  call EvalPerl()
"
"  function! StatusLineIndexLine()
"    perl index_line()
"    return subName
"  endfunction
"endif
"
" End perl code
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Integrate pmtools http://search.cpan.org/dist/pmtools/

" How do I turn off autocommenting?
" autocmd FileType perl iab usrbinperl #!/usr/bin/perl<CR><CR>use strict;<CR>use warnings;<CR><CR>

" Need to experiment with this to make it work correctly, plus you can't just enter the word dumper
" autocmd FileType perl imap dumper <ESC>^iwarn Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']);<ESC>

" Omnicompletion for perl: http://www.vim.org/scripts/script.php?script_id=1924

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
