""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl highlighting for Carp keywords
" Maintainer: vim-perl <vim-perl@groups.google.com>
" Location:   vim-perl/contrib

syntax match perlStatementProc "\<\%(croak\|confess\|carp\|cluck\)\>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl highlighting for Test::More keywords
" Maintainer: vim-perl <vim-perl@groups.google.com>
" Location:   vim-perl/contrib

" XXX include guard
syntax match perlStatementProc "\<\%(plan\|use_ok\|require_ok\|ok\|is\|isnt\|diag\|like\|unlike\|cmp_ok\|is_deeply\|skip\|can_ok\|isa_ok\|pass\|fail\|BAIL_OUT\)\>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl highlighting for Try::Tiny keywords
" Maintainer: vim-perl <vim-perl@groups.google.com>
" Location:   vim-perl/contrib

" XXX include guard
syntax match perlStatementProc "\<\%(try\|catch\|finally\)\>"

" XXX catch instances where you forget the semicolon after the closing brace?

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl highlighting for all pragma-like modules
" Maintainer: vim-perl <vim-perl@groups.google.com>
" Location:   vim-perl/contrib

" XXX include guard

syntax match perlStatementInclude   "\<\%(use\|no\)\s\+\l\(\i\|:\)\+"
