" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
plugin/RainbowPlugin.vim	[[[1
28
" RainbowPlugin.vim
"   Author: Charles E. Campbell, Jr.
"   Date:   Oct 28, 2009
"   Version: 2q	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp || exists("g:loaded_Rainbow")
 finish
endif
let g:loaded_Rainbow= "v2g"
let s:keepcpo       = &cpo
set cpo&vim

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com! -nargs=? -bang Rainbow	call Rainbow#Rainbow(<bang>1,<q-args>)

" ---------------------------------------------------------------------
" Default: {{{1
if !exists("g:hlrainbow")
 let g:hlrainbow= "{("
endif

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=4 fdm=marker
autoload/Rainbow.vim	[[[1
136
" Rainbow.vim
"   Author: Charles E. Campbell, Jr.
"   Date:   Oct 19, 2012
"   Version: 2q	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp || !exists("g:loaded_Rainbow")
 finish
endif
let g:loaded_Rainbow = "v2q"
let s:keepcpo        = &cpo
set cpo&vim

" ---------------------------------------------------------------------
" Rainbow#Rainbow: enable/disable rainbow highlighting for C/C++ {{{2
fun! Rainbow#Rainbow(enable,hlrainbow)
  if !exists("s:rainbowlevel")
   let s:rainbowlevel= 1
  else
   let s:rainbowlevel= s:rainbowlevel + 1
  endif

"  call Dfunc("Rainbow#Rainbow(enable=".a:enable." hlrainbow<".a:hlrainbow.">) rainbowlevel=".s:rainbowlevel)

  if s:rainbowlevel > 1
   let s:rainbowlevel= s:rainbowlevel - 1
"   call Dret("Rainbow#Rainbow : preventing Rainbow nesting")
   return
  endif

  " set filetype to clear out rainbow highlighting; remove any commands in the AuRainbowColor autocmd group
  augroup AugroupRainbow
   au!
  augroup END
  silent! augroup! AugroupRainbow
  let g:lisp_rainbow= 0
  exe "set ft=".&ft

  " set global g:hlrainbow_{filetype} to the new user's selection (if any)
  if a:hlrainbow != ""
   let g:hlrainbow_{&ft}= a:hlrainbow
  endif

  if a:enable
"  call Decho("sourcing rainbow.vvim")
   if &ft == "c" || &ft == "c++"
    augroup AugroupRainbow
 	 au BufNewFile,BufReadPost *.c,*.cpp,*.cxx,*.c++,*.C,*.h,*.hpp,*.hxx,*.h++,*.H	Rainbow
 	augroup END
    exe "so ".fnameescape(substitute(&rtp,',.*$','',''))."/after/syntax/c/rainbow.vvim"

   elseif &ft == "matlab"
    augroup AugroupRainbow
 	 au BufNewFile,BufReadPost *.m	Rainbow
 	augroup END
    exe "so ".fnameescape(substitute(&rtp,',.*$','',''))."/after/syntax/matlab/rainbow.vvim"

   elseif &ft == "javascript"
    augroup AugroupRainbow
 	 au BufNewFile,BufReadPost *.js	Rainbow
 	augroup END
	exe "so ".fnameescape(substitute(&rtp,',.*$','',''))."/after/syntax/javascript/rainbow.vvim"

   elseif &ft == "tex"
    augroup AugroupRainbow
 	 au BufNewFile,BufReadPost *.tex	Rainbow
 	augroup END
    exe "so ".fnameescape(substitute(&rtp,',.*$','',''))."/after/syntax/tex/rainbow.vvim"

   elseif &ft == "lisp"
    augroup AugroupRainbow
 	 au BufNewFile,BufReadPost *.tex	Rainbow
 	augroup END
	let g:lisp_rainbow= 1
	set ft=lisp
   endif

   " highlighting colorization by level
"   if &bg == "dark"
"    hi default   hlLevel0	ctermfg=red				ctermbg=black	guifg=red1				guibg=black
"    hi default   hlLevel1	ctermfg=yellow			ctermbg=black	guifg=orange1			guibg=black
"    hi default   hlLevel2	ctermfg=green			ctermbg=black	guifg=yellow1			guibg=black
"    hi default   hlLevel3	ctermfg=cyan			ctermbg=black	guifg=hotpink			guibg=black
"    hi default   hlLevel4	ctermfg=magenta			ctermbg=black	guifg=chartreuse		guibg=black
"    hi default   hlLevel5	ctermfg=red				ctermbg=black	guifg=PeachPuff1		guibg=black
"    hi default   hlLevel6	ctermfg=yellow			ctermbg=black	guifg=cyan1				guibg=black
"    hi default   hlLevel7	ctermfg=green			ctermbg=black	guifg=cornflowerblue	guibg=black
"    hi default   hlLevel8	ctermfg=cyan			ctermbg=black	guifg=magenta1			guibg=black
"    hi default   hlLevel9	ctermfg=magenta			ctermbg=black	guifg=purple1			guibg=black
"   else
"    hi default   hlLevel0	ctermfg=red				ctermbg=black	guifg=red3				guibg=black
"    hi default   hlLevel1	ctermfg=darkyellow		ctermbg=black	guifg=orangered3		guibg=black
"    hi default   hlLevel2	ctermfg=darkgreen		ctermbg=black	guifg=orange2			guibg=black
"    hi default   hlLevel3	ctermfg=blue			ctermbg=black	guifg=yellow3			guibg=black
"    hi default   hlLevel4	ctermfg=darkmagenta		ctermbg=black	guifg=olivedrab4		guibg=black
"    hi default   hlLevel5	ctermfg=red				ctermbg=black	guifg=green4			guibg=black
"    hi default   hlLevel6	ctermfg=darkyellow		ctermbg=black	guifg=paleturquoise3	guibg=black
"    hi default   hlLevel7	ctermfg=darkgreen		ctermbg=black	guifg=deepskyblue4		guibg=black
"    hi default   hlLevel8	ctermfg=blue			ctermbg=black	guifg=darkslateblue		guibg=black
"    hi default   hlLevel9	ctermfg=darkmagenta		ctermbg=black	guifg=darkviolet		guibg=black
"   endif
   if &bg == "dark"
    hi   hlLevel0 ctermfg=red         guifg=red1
    hi   hlLevel1 ctermfg=yellow      guifg=orange1
    hi   hlLevel2 ctermfg=green       guifg=yellow1
    hi   hlLevel3 ctermfg=cyan        guifg=greenyellow
    hi   hlLevel4 ctermfg=magenta     guifg=green1
    hi   hlLevel5 ctermfg=red         guifg=springgreen1
    hi   hlLevel6 ctermfg=yellow      guifg=cyan1
    hi   hlLevel7 ctermfg=green       guifg=steelblue1
    hi   hlLevel8 ctermfg=cyan        guifg=magenta1
    hi   hlLevel9 ctermfg=magenta     guifg=purple
   else
    hi   hlLevel0 ctermfg=red         guifg=red3
    hi   hlLevel1 ctermfg=darkyellow  guifg=orangered3
    hi   hlLevel2 ctermfg=darkgreen   guifg=orange2
    hi   hlLevel3 ctermfg=blue        guifg=yellow3
    hi   hlLevel4 ctermfg=darkmagenta guifg=olivedrab4
    hi   hlLevel5 ctermfg=red         guifg=green4
    hi   hlLevel6 ctermfg=darkyellow  guifg=paleturquoise3
    hi   hlLevel7 ctermfg=darkgreen   guifg=deepskyblue4
    hi   hlLevel8 ctermfg=blue        guifg=darkslateblue
    hi   hlLevel9 ctermfg=darkmagenta guifg=darkviolet
   endif

  endif

  let s:rainbowlevel= s:rainbowlevel - 1
"  call Dret("Rainbow#Rainbow")
endfun

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=4 fdm=marker
after/syntax/c/rainbow.vvim	[[[1
162
" rainbow.vvim : provides "rainbow-colored" curly braces and parentheses
"               C/C++ language version
"   Author: 	Charles E. Campbell, Jr.
"   Date:		Nov 01, 2009
"   Associated Files:  plugin/RainbowPlugin.vim autoload/Rainbow.vim doc/Rainbow.txt
" ---------------------------------------------------------------------
" non-compatible only: {{{1
if &cp
 finish
endif
let keepcpo= &cpo
let s:work = ''
set cpo&vim

" ---------------------------------------------------------------------
" Default Settings: {{{1
if exists("g:hlrainbow_cpp")
 let g:hlrainbow_c= g:hlrainbow_cpp
" call Decho("g:hlrainbow_cpp<".g:hlrainbow_cpp.">")
endif
if !exists("g:hlrainbow_c")
 let g:hlrainbow_c= '{}()'
endif
"call Decho("g:hlrainbow_c<".g:hlrainbow_c.">")

syn clear cParen cCppParen cBracket cCppBracket cBlock cParenError

" Clusters {{{1
syn cluster cParenGroup		contains=cBlock,cCharacter,cComment,cCommentError,cCommentL,cConditional,cConstant,cDefine,cInclude,cLabel,cMulti,cNumbers,cOperator,cPreProc,cRepeat,cSpaceError,cSpecialCharacter,cSpecialError,cStatement,cStorageClass,cString,cStructure,cType
syn cluster cCppParenGroup	contains=cBlock,cCharacter,cComment,cCommentError,cCommentL,cConditional,cConstant,cCppBracket,cCppString,cDefine,cInclude,cLabel,cMulti,cNumbers,cOperator,cPreProc,cRepeat,cSpaceError,cSpecialCharacter,cSpecialError,cStatement,cStorageClass,cStructure,cType
syn cluster cCurlyGroup		contains=cConditional,cConstant,cLabel,cOperator,cRepeat,cStatement,cStorageClass,cStructure,cType,cBitField,cCharacter,cCommentError,cInclude,cNumbers,cPreCondit,cSpaceError,cSpecialCharacter,cSpecialError,cUserCont,cBlock,cComment,cCommentL,cCppOut,cCppString,cDefine,cMulti,cPreCondit,cPreProc,cString,cFoldSpec
if &ft == "cpp"
 syn cluster cCurlyGroup add=cppStatement,cppAccess,cppType,cppExceptions,cppOperator,cppCast,cppStorageClass,cppStructure,cppNumber,cppBoolean,cppMinMax
endif

" Error Syntax {{{1
syn clear cErrInBracket
syn match	cErrInBracket	display contained "[{}]\|<%\|%>"
syn match	cParenError		display ')'
syn match	cBracketError	display ']'
if &ft == "cpp"
 syn cluster cCppBracketGroup	add=cParenError,cErrInBracket,cCurly,cCppParen,cCppBracket
 syn cluster cCppParenGroup		add=cBracketError,cErrInBracket,cCurly,cCppParen,cCppBracket
 syn cluster cBracketGroup		add=cParenError,cErrInBracket,cCurly,cCppParen,cCppBracket
 syn cluster cParenGroup		add=cBracketError,cErrInBracket,cCurly,cCppParen,cCppBracket
 syn cluster cCurlyGroup		add=cParenError,cBracketError,cCurly,cCppParen,cCppBracket
else
 syn cluster cBracketGroup		add=cParenError,cErrInBracket,cCurly,cParen,cBracket
 syn cluster cParenGroup		add=cBracketError,cErrInBracket,cCurly,cParen,cBracket
 syn cluster cCurlyGroup		add=cParenError,cBracketError,cCurly,cParen,cBracket
endif

" ---------------------------------------------------------------------
" supports {} highlighting, too many } error detection, and {{{1
" function folding (when fdm=syntax)
if g:hlrainbow_c =~ '[{}]'

" call Decho("enabling {} rainbow")
 syn match  cCurlyError	display '}'
 syn region cCurly  fold matchgroup=hlLevel0 start='{' end='}' 			 contains=@cCurlyGroup,cCurly1
 syn region cCurly1		 matchgroup=hlLevel1 start='{' end='}' contained contains=@cCurlyGroup,cCurly2
 syn region cCurly2		 matchgroup=hlLevel2 start='{' end='}' contained contains=@cCurlyGroup,cCurly3
 syn region cCurly3		 matchgroup=hlLevel3 start='{' end='}' contained contains=@cCurlyGroup,cCurly4
 syn region cCurly4		 matchgroup=hlLevel4 start='{' end='}' contained contains=@cCurlyGroup,cCurly5
 syn region cCurly5		 matchgroup=hlLevel5 start='{' end='}' contained contains=@cCurlyGroup,cCurly6
 syn region cCurly6		 matchgroup=hlLevel6 start='{' end='}' contained contains=@cCurlyGroup,cCurly7
 syn region cCurly7		 matchgroup=hlLevel7 start='{' end='}' contained contains=@cCurlyGroup,cCurly8
 syn region cCurly8		 matchgroup=hlLevel8 start='{' end='}' contained contains=@cCurlyGroup,cCurly9
 syn region cCurly9		 matchgroup=hlLevel9 start='{' end='}' contained contains=@cCurlyGroup,cCurly
else
 syn region cCurly	fold start='{' end='}'	contains=@cCurlyGroup
endif

" ---------------------------------------------------------------------
" supports () highlighting and error detection {{{1
if g:hlrainbow_c =~ '[()]'

 if &ft == "cpp"
"  call Decho("enabling () rainbow for C++")
  syn region	cCppParen	transparent matchgroup=hlLevel0	start='(' end=')' 			contains=@cCppParenGroup,cCppParen1 
  syn region	cCppParen1	transparent matchgroup=hlLevel1	start='(' end=')' contained contains=@cCppParenGroup,cCppParen2 
  syn region	cCppParen2	transparent matchgroup=hlLevel2	start='(' end=')' contained contains=@cCppParenGroup,cCppParen3 
  syn region	cCppParen3	transparent matchgroup=hlLevel3	start='(' end=')' contained contains=@cCppParenGroup,cCppParen4 
  syn region	cCppParen4	transparent matchgroup=hlLevel4	start='(' end=')' contained contains=@cCppParenGroup,cCppParen5 
  syn region	cCppParen5	transparent matchgroup=hlLevel5	start='(' end=')' contained contains=@cCppParenGroup,cCppParen6 
  syn region	cCppParen6	transparent matchgroup=hlLevel6	start='(' end=')' contained contains=@cCppParenGroup,cCppParen7 
  syn region	cCppParen7	transparent matchgroup=hlLevel7	start='(' end=')' contained contains=@cCppParenGroup,cCppParen8 
  syn region	cCppParen8	transparent matchgroup=hlLevel8	start='(' end=')' contained contains=@cCppParenGroup,cCppParen9 
  syn region	cCppParen9	transparent matchgroup=hlLevel9	start='(' end=')' contained contains=@cCppParenGroup,cCppParen
 else
"  call Decho("enabling () rainbow for C")
  syn region	cParen		transparent matchgroup=hlLevel0	start='(' end=')' 			contains=@cParenGroup,cParen1
  syn region	cParen1		transparent matchgroup=hlLevel1	start='(' end=')' contained contains=@cParenGroup,cParen2
  syn region	cParen2		transparent matchgroup=hlLevel2	start='(' end=')' contained contains=@cParenGroup,cParen3
  syn region	cParen3		transparent matchgroup=hlLevel3	start='(' end=')' contained contains=@cParenGroup,cParen4
  syn region	cParen4		transparent matchgroup=hlLevel4	start='(' end=')' contained contains=@cParenGroup,cParen5
  syn region	cParen5		transparent matchgroup=hlLevel5	start='(' end=')' contained contains=@cParenGroup,cParen6
  syn region	cParen6		transparent matchgroup=hlLevel6	start='(' end=')' contained contains=@cParenGroup,cParen7
  syn region	cParen7		transparent matchgroup=hlLevel7	start='(' end=')' contained contains=@cParenGroup,cParen8
  syn region	cParen8		transparent matchgroup=hlLevel8	start='(' end=')' contained contains=@cParenGroup,cParen9
  syn region	cParen9		transparent matchgroup=hlLevel9	start='(' end=')' contained contains=@cParenGroup,cParen
 endif
else
 if &ft == "cpp"
  syn region	cCppParen	start='(' end=')' contains=@cParenGroup
 else
  syn region	cParen		start='(' end=')' contains=@cParenGroup
 endif
endif

" ---------------------------------------------------------------------
" supports [] highlighting and error detection {{{1
if g:hlrainbow_c =~ '[[\]]'
 syn clear   cBracket cCppBracket
 syn cluster cBracketGroup		contains=cBlock,cBracket,cCharacter,cComment,cCommentError,cCommentL,cConditional,cConstant,cDefine,cInclude,cLabel,cMulti,cNumbers,cOperator,cPreProc,cRepeat,cSpaceError,cSpecialCharacter,cSpecialError,cStatement,cStorageClass,cString,cStructure,cType

 if &ft == "cpp"
"  call Decho("enabling [] rainbow for C++")
  syn cluster cCppBracketGroup	contains=cBlock,cCharacter,cComment,cCommentError,cCommentL,cConditional,cConstant,cCppBracket,cCppParen,cCppString,cDefine,cInclude,cLabel,cMulti,cNumbers,cOperator,cPreProc,cRepeat,cSpaceError,cSpecialCharacter,cSpecialError,cStatement,cStorageClass,cStructure,cType
  syn region cCppBracket  fold	matchgroup=hlLevel0 start='\[' end=']' 			 contains=@cCppBracketGroup,cCppBracket1
  syn region cCppBracket1		matchgroup=hlLevel1 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket2
  syn region cCppBracket2		matchgroup=hlLevel2 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket3
  syn region cCppBracket3		matchgroup=hlLevel3 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket4
  syn region cCppBracket4		matchgroup=hlLevel4 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket5
  syn region cCppBracket5		matchgroup=hlLevel5 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket6
  syn region cCppBracket6		matchgroup=hlLevel6 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket7
  syn region cCppBracket7		matchgroup=hlLevel7 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket8
  syn region cCppBracket8		matchgroup=hlLevel8 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket9
  syn region cCppBracket9		matchgroup=hlLevel9 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket
 else
"  call Decho("enabling [] rainbow for C")
  syn region cBracket  fold	matchgroup=hlLevel0 start='\[' end=']' 			 contains=@cBracketGroup,cBracket1
  syn region cBracket1		matchgroup=hlLevel1 start='\[' end=']' contained contains=@cBracketGroup,cBracket2
  syn region cBracket2		matchgroup=hlLevel2 start='\[' end=']' contained contains=@cBracketGroup,cBracket3
  syn region cBracket3		matchgroup=hlLevel3 start='\[' end=']' contained contains=@cBracketGroup,cBracket4
  syn region cBracket4		matchgroup=hlLevel4 start='\[' end=']' contained contains=@cBracketGroup,cBracket5
  syn region cBracket5		matchgroup=hlLevel5 start='\[' end=']' contained contains=@cBracketGroup,cBracket6
  syn region cBracket6		matchgroup=hlLevel6 start='\[' end=']' contained contains=@cBracketGroup,cBracket7
  syn region cBracket7		matchgroup=hlLevel7 start='\[' end=']' contained contains=@cBracketGroup,cBracket8
  syn region cBracket8		matchgroup=hlLevel8 start='\[' end=']' contained contains=@cBracketGroup,cBracket9
  syn region cBracket9		matchgroup=hlLevel9 start='\[' end=']' contained contains=@cBracketGroup,cBracket
 endif
else
 if &ft == "cpp"
  syn region	cCppBracket	start='\[' end=']' contains=@cCppBracketGroup
 else
  syn region	cBracket	start='\[' end=']' contains=@cBracketGroup
 endif
endif

" don't use {{{# patterns in curly brace matching
syn match cFoldSpec	'{{{\d\+'
syn match cFoldSpec	'}}}\d\+'

" highlighting: {{{1
hi link cCurlyError		cError
hi link cBracketError	cError

" ---------------------------------------------------------------------
"  Modelines: {{{1
let &cpo= keepcpo
" vim: fdm=marker ft=vim ts=4
after/syntax/cpp/rainbow.vvim	[[[1
162
" rainbow.vvim : provides "rainbow-colored" curly braces and parentheses
"               C/C++ language version
"   Author: 	Charles E. Campbell, Jr.
"   Date:		Nov 01, 2009
"   Associated Files:  plugin/RainbowPlugin.vim autoload/Rainbow.vim doc/Rainbow.txt
" ---------------------------------------------------------------------
" non-compatible only: {{{1
if &cp
 finish
endif
let keepcpo= &cpo
let s:work = ''
set cpo&vim

" ---------------------------------------------------------------------
" Default Settings: {{{1
if exists("g:hlrainbow_cpp")
 let g:hlrainbow_c= g:hlrainbow_cpp
" call Decho("g:hlrainbow_cpp<".g:hlrainbow_cpp.">")
endif
if !exists("g:hlrainbow_c")
 let g:hlrainbow_c= '{}()'
endif
"call Decho("g:hlrainbow_c<".g:hlrainbow_c.">")

syn clear cParen cCppParen cBracket cCppBracket cBlock cParenError

" Clusters {{{1
syn cluster cParenGroup		contains=cBlock,cCharacter,cComment,cCommentError,cCommentL,cConditional,cConstant,cDefine,cInclude,cLabel,cMulti,cNumbers,cOperator,cPreProc,cRepeat,cSpaceError,cSpecialCharacter,cSpecialError,cStatement,cStorageClass,cString,cStructure,cType
syn cluster cCppParenGroup	contains=cBlock,cCharacter,cComment,cCommentError,cCommentL,cConditional,cConstant,cCppBracket,cCppString,cDefine,cInclude,cLabel,cMulti,cNumbers,cOperator,cPreProc,cRepeat,cSpaceError,cSpecialCharacter,cSpecialError,cStatement,cStorageClass,cStructure,cType
syn cluster cCurlyGroup		contains=cConditional,cConstant,cLabel,cOperator,cRepeat,cStatement,cStorageClass,cStructure,cType,cBitField,cCharacter,cCommentError,cInclude,cNumbers,cPreCondit,cSpaceError,cSpecialCharacter,cSpecialError,cUserCont,cBlock,cComment,cCommentL,cCppOut,cCppString,cDefine,cMulti,cPreCondit,cPreProc,cString,cFoldSpec
if &ft == "cpp"
 syn cluster cCurlyGroup add=cppStatement,cppAccess,cppType,cppExceptions,cppOperator,cppCast,cppStorageClass,cppStructure,cppNumber,cppBoolean,cppMinMax
endif

" Error Syntax {{{1
syn clear cErrInBracket
syn match	cErrInBracket	display contained "[{}]\|<%\|%>"
syn match	cParenError		display ')'
syn match	cBracketError	display ']'
if &ft == "cpp"
 syn cluster cCppBracketGroup	add=cParenError,cErrInBracket,cCurly,cCppParen,cCppBracket
 syn cluster cCppParenGroup		add=cBracketError,cErrInBracket,cCurly,cCppParen,cCppBracket
 syn cluster cBracketGroup		add=cParenError,cErrInBracket,cCurly,cCppParen,cCppBracket
 syn cluster cParenGroup		add=cBracketError,cErrInBracket,cCurly,cCppParen,cCppBracket
 syn cluster cCurlyGroup		add=cParenError,cBracketError,cCurly,cCppParen,cCppBracket
else
 syn cluster cBracketGroup		add=cParenError,cErrInBracket,cCurly,cParen,cBracket
 syn cluster cParenGroup		add=cBracketError,cErrInBracket,cCurly,cParen,cBracket
 syn cluster cCurlyGroup		add=cParenError,cBracketError,cCurly,cParen,cBracket
endif

" ---------------------------------------------------------------------
" supports {} highlighting, too many } error detection, and {{{1
" function folding (when fdm=syntax)
if g:hlrainbow_c =~ '[{}]'

" call Decho("enabling {} rainbow")
 syn match  cCurlyError	display '}'
 syn region cCurly  fold matchgroup=hlLevel0 start='{' end='}' 			 contains=@cCurlyGroup,cCurly1
 syn region cCurly1		 matchgroup=hlLevel1 start='{' end='}' contained contains=@cCurlyGroup,cCurly2
 syn region cCurly2		 matchgroup=hlLevel2 start='{' end='}' contained contains=@cCurlyGroup,cCurly3
 syn region cCurly3		 matchgroup=hlLevel3 start='{' end='}' contained contains=@cCurlyGroup,cCurly4
 syn region cCurly4		 matchgroup=hlLevel4 start='{' end='}' contained contains=@cCurlyGroup,cCurly5
 syn region cCurly5		 matchgroup=hlLevel5 start='{' end='}' contained contains=@cCurlyGroup,cCurly6
 syn region cCurly6		 matchgroup=hlLevel6 start='{' end='}' contained contains=@cCurlyGroup,cCurly7
 syn region cCurly7		 matchgroup=hlLevel7 start='{' end='}' contained contains=@cCurlyGroup,cCurly8
 syn region cCurly8		 matchgroup=hlLevel8 start='{' end='}' contained contains=@cCurlyGroup,cCurly9
 syn region cCurly9		 matchgroup=hlLevel9 start='{' end='}' contained contains=@cCurlyGroup,cCurly
else
 syn region cCurly	fold start='{' end='}'	contains=@cCurlyGroup
endif

" ---------------------------------------------------------------------
" supports () highlighting and error detection {{{1
if g:hlrainbow_c =~ '[()]'

 if &ft == "cpp"
"  call Decho("enabling () rainbow for C++")
  syn region	cCppParen	transparent matchgroup=hlLevel0	start='(' end=')' 			contains=@cCppParenGroup,cCppParen1 
  syn region	cCppParen1	transparent matchgroup=hlLevel1	start='(' end=')' contained contains=@cCppParenGroup,cCppParen2 
  syn region	cCppParen2	transparent matchgroup=hlLevel2	start='(' end=')' contained contains=@cCppParenGroup,cCppParen3 
  syn region	cCppParen3	transparent matchgroup=hlLevel3	start='(' end=')' contained contains=@cCppParenGroup,cCppParen4 
  syn region	cCppParen4	transparent matchgroup=hlLevel4	start='(' end=')' contained contains=@cCppParenGroup,cCppParen5 
  syn region	cCppParen5	transparent matchgroup=hlLevel5	start='(' end=')' contained contains=@cCppParenGroup,cCppParen6 
  syn region	cCppParen6	transparent matchgroup=hlLevel6	start='(' end=')' contained contains=@cCppParenGroup,cCppParen7 
  syn region	cCppParen7	transparent matchgroup=hlLevel7	start='(' end=')' contained contains=@cCppParenGroup,cCppParen8 
  syn region	cCppParen8	transparent matchgroup=hlLevel8	start='(' end=')' contained contains=@cCppParenGroup,cCppParen9 
  syn region	cCppParen9	transparent matchgroup=hlLevel9	start='(' end=')' contained contains=@cCppParenGroup,cCppParen
 else
"  call Decho("enabling () rainbow for C")
  syn region	cParen		transparent matchgroup=hlLevel0	start='(' end=')' 			contains=@cParenGroup,cParen1
  syn region	cParen1		transparent matchgroup=hlLevel1	start='(' end=')' contained contains=@cParenGroup,cParen2
  syn region	cParen2		transparent matchgroup=hlLevel2	start='(' end=')' contained contains=@cParenGroup,cParen3
  syn region	cParen3		transparent matchgroup=hlLevel3	start='(' end=')' contained contains=@cParenGroup,cParen4
  syn region	cParen4		transparent matchgroup=hlLevel4	start='(' end=')' contained contains=@cParenGroup,cParen5
  syn region	cParen5		transparent matchgroup=hlLevel5	start='(' end=')' contained contains=@cParenGroup,cParen6
  syn region	cParen6		transparent matchgroup=hlLevel6	start='(' end=')' contained contains=@cParenGroup,cParen7
  syn region	cParen7		transparent matchgroup=hlLevel7	start='(' end=')' contained contains=@cParenGroup,cParen8
  syn region	cParen8		transparent matchgroup=hlLevel8	start='(' end=')' contained contains=@cParenGroup,cParen9
  syn region	cParen9		transparent matchgroup=hlLevel9	start='(' end=')' contained contains=@cParenGroup,cParen
 endif
else
 if &ft == "cpp"
  syn region	cCppParen	start='(' end=')' contains=@cParenGroup
 else
  syn region	cParen		start='(' end=')' contains=@cParenGroup
 endif
endif

" ---------------------------------------------------------------------
" supports [] highlighting and error detection {{{1
if g:hlrainbow_c =~ '[[\]]'
 syn clear   cBracket cCppBracket
 syn cluster cBracketGroup		contains=cBlock,cBracket,cCharacter,cComment,cCommentError,cCommentL,cConditional,cConstant,cDefine,cInclude,cLabel,cMulti,cNumbers,cOperator,cPreProc,cRepeat,cSpaceError,cSpecialCharacter,cSpecialError,cStatement,cStorageClass,cString,cStructure,cType

 if &ft == "cpp"
"  call Decho("enabling [] rainbow for C++")
  syn cluster cCppBracketGroup	contains=cBlock,cCharacter,cComment,cCommentError,cCommentL,cConditional,cConstant,cCppBracket,cCppParen,cCppString,cDefine,cInclude,cLabel,cMulti,cNumbers,cOperator,cPreProc,cRepeat,cSpaceError,cSpecialCharacter,cSpecialError,cStatement,cStorageClass,cStructure,cType
  syn region cCppBracket  fold	matchgroup=hlLevel0 start='\[' end=']' 			 contains=@cCppBracketGroup,cCppBracket1
  syn region cCppBracket1		matchgroup=hlLevel1 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket2
  syn region cCppBracket2		matchgroup=hlLevel2 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket3
  syn region cCppBracket3		matchgroup=hlLevel3 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket4
  syn region cCppBracket4		matchgroup=hlLevel4 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket5
  syn region cCppBracket5		matchgroup=hlLevel5 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket6
  syn region cCppBracket6		matchgroup=hlLevel6 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket7
  syn region cCppBracket7		matchgroup=hlLevel7 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket8
  syn region cCppBracket8		matchgroup=hlLevel8 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket9
  syn region cCppBracket9		matchgroup=hlLevel9 start='\[' end=']' contained contains=@cCppBracketGroup,cCppBracket
 else
"  call Decho("enabling [] rainbow for C")
  syn region cBracket  fold	matchgroup=hlLevel0 start='\[' end=']' 			 contains=@cBracketGroup,cBracket1
  syn region cBracket1		matchgroup=hlLevel1 start='\[' end=']' contained contains=@cBracketGroup,cBracket2
  syn region cBracket2		matchgroup=hlLevel2 start='\[' end=']' contained contains=@cBracketGroup,cBracket3
  syn region cBracket3		matchgroup=hlLevel3 start='\[' end=']' contained contains=@cBracketGroup,cBracket4
  syn region cBracket4		matchgroup=hlLevel4 start='\[' end=']' contained contains=@cBracketGroup,cBracket5
  syn region cBracket5		matchgroup=hlLevel5 start='\[' end=']' contained contains=@cBracketGroup,cBracket6
  syn region cBracket6		matchgroup=hlLevel6 start='\[' end=']' contained contains=@cBracketGroup,cBracket7
  syn region cBracket7		matchgroup=hlLevel7 start='\[' end=']' contained contains=@cBracketGroup,cBracket8
  syn region cBracket8		matchgroup=hlLevel8 start='\[' end=']' contained contains=@cBracketGroup,cBracket9
  syn region cBracket9		matchgroup=hlLevel9 start='\[' end=']' contained contains=@cBracketGroup,cBracket
 endif
else
 if &ft == "cpp"
  syn region	cCppBracket	start='\[' end=']' contains=@cCppBracketGroup
 else
  syn region	cBracket	start='\[' end=']' contains=@cBracketGroup
 endif
endif

" don't use {{{# patterns in curly brace matching
syn match cFoldSpec	'{{{\d\+'
syn match cFoldSpec	'}}}\d\+'

" highlighting: {{{1
hi link cCurlyError		cError
hi link cBracketError	cError

" ---------------------------------------------------------------------
"  Modelines: {{{1
let &cpo= keepcpo
" vim: fdm=marker ft=vim ts=4
after/syntax/tex/rainbow.vvim	[[[1
159
" rainbow.vvim : provides "rainbow-colored" curly braces, begin..end matching, etc
"               LaTeX
"   Author: 	Charles E. Campbell, Jr.
"   Date:		Oct 18, 2011
"   Associated Files:  plugin/RainbowPlugin.vim autoload/Rainbow.vim doc/Rainbow.txt
" ---------------------------------------------------------------------
" non-compatible only: {{{1
if &cp
 finish
endif
let keepcpo= &cpo
let s:work = ''
set cpo&vim
syn clear

" ---------------------------------------------------------------------
" Default Settings: {{{1
if !exists("g:hlrainbow_tex")
 let g:hlrainbow_tex= 'brace begin left math'
endif
"call Decho("g:hlrainbow_tex<".g:hlrainbow_tex.">")

" ---------------------------------------------------------------------
" Synchronization: {{{1
syn sync clear
syn sync fromstart

" ---------------------------------------------------------------------
" set up clusters {{{1
syn cluster texRainbowGroup0 contains=texBeginEnd1,texLeftRight1,texMath1,texBrace1,texSpecial
syn cluster texRainbowGroup1 contains=texBeginEnd2,texLeftRight2,texMath2,texBrace2,texSpecial
syn cluster texRainbowGroup2 contains=texBeginEnd3,texLeftRight3,texMath3,texBrace3,texSpecial
syn cluster texRainbowGroup3 contains=texBeginEnd4,texLeftRight4,texMath4,texBrace4,texSpecial
syn cluster texRainbowGroup4 contains=texBeginEnd5,texLeftRight5,texMath5,texBrace5,texSpecial
syn cluster texRainbowGroup5 contains=texBeginEnd6,texLeftRight6,texMath6,texBrace6,texSpecial
syn cluster texRainbowGroup6 contains=texBeginEnd7,texLeftRight7,texMath7,texBrace7,texSpecial
syn cluster texRainbowGroup7 contains=texBeginEnd8,texLeftRight8,texMath8,texBrace8,texSpecial
syn cluster texRainbowGroup8 contains=texBeginEnd9,texLeftRight9,texMath9,texBrace9,texSpecial
syn cluster texRainbowGroup9 contains=texBeginEnd0,texLeftRight0,texMath0,texBrace0,texSpecial

" ---------------------------------------------------------------------
"  Syntax Highlighting: {{{1

syn region texLeftRight0 matchgroup=hlLevel0 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup0
syn region texLeftRight1 matchgroup=hlLevel1 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup1 contained
syn region texLeftRight2 matchgroup=hlLevel2 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup2 contained
syn region texLeftRight3 matchgroup=hlLevel3 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup3 contained
syn region texLeftRight4 matchgroup=hlLevel4 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup4 contained
syn region texLeftRight5 matchgroup=hlLevel5 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup5 contained
syn region texLeftRight6 matchgroup=hlLevel6 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup6 contained
syn region texLeftRight7 matchgroup=hlLevel7 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup7 contained
syn region texLeftRight8 matchgroup=hlLevel8 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup8 contained
syn region texLeftRight9 matchgroup=hlLevel9 	start='\\left\\\=[|(){}[\].]' end='\\right\\\=[|(){}[\].]' contains=@texRainbowGroup9 contained

syn region texBrace0	matchgroup=hlLevel0	start='{'	end='}'	contains=@texRainbowGroup0
syn region texBrace1	matchgroup=hlLevel1	start='{'	end='}'	contains=@texRainbowGroup1 contained
syn region texBrace2	matchgroup=hlLevel2	start='{'	end='}'	contains=@texRainbowGroup2 contained
syn region texBrace3	matchgroup=hlLevel3	start='{'	end='}'	contains=@texRainbowGroup3 contained
syn region texBrace4	matchgroup=hlLevel4	start='{'	end='}'	contains=@texRainbowGroup4 contained
syn region texBrace5	matchgroup=hlLevel5	start='{'	end='}'	contains=@texRainbowGroup5 contained
syn region texBrace6	matchgroup=hlLevel6	start='{'	end='}'	contains=@texRainbowGroup6 contained
syn region texBrace7	matchgroup=hlLevel7	start='{'	end='}'	contains=@texRainbowGroup7 contained
syn region texBrace8	matchgroup=hlLevel8	start='{'	end='}'	contains=@texRainbowGroup8 contained
syn region texBrace9	matchgroup=hlLevel9	start='{'	end='}'	contains=@texRainbowGroup9 contained

syn region texBrace0	matchgroup=hlLevel0	start='\['	end=']'	contains=@texRainbowGroup0
syn region texBrace1	matchgroup=hlLevel1	start='\['	end=']'	contains=@texRainbowGroup1 contained
syn region texBrace2	matchgroup=hlLevel2	start='\['	end=']'	contains=@texRainbowGroup2 contained
syn region texBrace3	matchgroup=hlLevel3	start='\['	end=']'	contains=@texRainbowGroup3 contained
syn region texBrace4	matchgroup=hlLevel4	start='\['	end=']'	contains=@texRainbowGroup4 contained
syn region texBrace5	matchgroup=hlLevel5	start='\['	end=']'	contains=@texRainbowGroup5 contained
syn region texBrace6	matchgroup=hlLevel6	start='\['	end=']'	contains=@texRainbowGroup6 contained
syn region texBrace7	matchgroup=hlLevel7	start='\['	end=']'	contains=@texRainbowGroup7 contained
syn region texBrace8	matchgroup=hlLevel8	start='\['	end=']'	contains=@texRainbowGroup8 contained
syn region texBrace9	matchgroup=hlLevel9	start='\['	end=']'	contains=@texRainbowGroup9 contained

syn region texBrace0	matchgroup=hlLevel0	start='('	end=')'	contains=@texRainbowGroup0
syn region texBrace1	matchgroup=hlLevel1	start='('	end=')'	contains=@texRainbowGroup1 contained
syn region texBrace2	matchgroup=hlLevel2	start='('	end=')'	contains=@texRainbowGroup2 contained
syn region texBrace3	matchgroup=hlLevel3	start='('	end=')'	contains=@texRainbowGroup3 contained
syn region texBrace4	matchgroup=hlLevel4	start='('	end=')'	contains=@texRainbowGroup4 contained
syn region texBrace5	matchgroup=hlLevel5	start='('	end=')'	contains=@texRainbowGroup5 contained
syn region texBrace6	matchgroup=hlLevel6	start='('	end=')'	contains=@texRainbowGroup6 contained
syn region texBrace7	matchgroup=hlLevel7	start='('	end=')'	contains=@texRainbowGroup7 contained
syn region texBrace8	matchgroup=hlLevel8	start='('	end=')'	contains=@texRainbowGroup8 contained
syn region texBrace9	matchgroup=hlLevel9	start='('	end=')'	contains=@texRainbowGroup9 contained

syn region texBeginEnd0	matchgroup=hlLevel0  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup0
syn region texBeginEnd1	matchgroup=hlLevel1  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup1 contained
syn region texBeginEnd2	matchgroup=hlLevel2  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup2 contained
syn region texBeginEnd3	matchgroup=hlLevel3  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup3 contained
syn region texBeginEnd4	matchgroup=hlLevel4  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup4 contained
syn region texBeginEnd5	matchgroup=hlLevel5  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup5 contained
syn region texBeginEnd6	matchgroup=hlLevel6  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup6 contained
syn region texBeginEnd7	matchgroup=hlLevel7  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup7 contained
syn region texBeginEnd8	matchgroup=hlLevel8  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup8 contained
syn region texBeginEnd9	matchgroup=hlLevel9  start='\\begin{\z(.\{-}\)}' end='\\end{\z1}' contains=@texRainbowGroup9 contained

syn region texMath0  	matchgroup=hlLevel0		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup0
syn region texMath1  	matchgroup=hlLevel1		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup1	contained
syn region texMath2  	matchgroup=hlLevel2		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup2	contained
syn region texMath3  	matchgroup=hlLevel3		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup3	contained
syn region texMath4  	matchgroup=hlLevel4		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup4	contained
syn region texMath5  	matchgroup=hlLevel5		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup5	contained
syn region texMath6  	matchgroup=hlLevel6		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup6	contained
syn region texMath7  	matchgroup=hlLevel7		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup7	contained
syn region texMath8  	matchgroup=hlLevel8		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup8	contained
syn region texMath9  	matchgroup=hlLevel9		start='\$\z(\$\=\)'	end='\$\z1'	contains=@texRainbowGroup9	contained
syn match  texSpecial	'\\\$'

hi link   texBrace0			hlLevel0
hi link   texBrace1			hlLevel1
hi link   texBrace2			hlLevel2
hi link   texBrace3			hlLevel3
hi link   texBrace4			hlLevel4
hi link   texBrace5			hlLevel5
hi link   texBrace6			hlLevel6
hi link   texBrace7			hlLevel7
hi link   texBrace8			hlLevel8
hi link   texBrace9			hlLevel9

hi link   texBeginEnd0		hlLevel0
hi link   texBeginEnd1		hlLevel1
hi link   texBeginEnd2		hlLevel2
hi link   texBeginEnd3		hlLevel3
hi link   texBeginEnd4		hlLevel4
hi link   texBeginEnd5		hlLevel5
hi link   texBeginEnd6		hlLevel6
hi link   texBeginEnd7		hlLevel7
hi link   texBeginEnd8		hlLevel8
hi link   texBeginEnd9		hlLevel9

hi link   texLeftRight0		hlLevel0
hi link   texLeftRight1		hlLevel1
hi link   texLeftRight2		hlLevel2
hi link   texLeftRight3		hlLevel3
hi link   texLeftRight4		hlLevel4
hi link   texLeftRight5		hlLevel5
hi link   texLeftRight6		hlLevel6
hi link   texLeftRight7		hlLevel7
hi link   texLeftRight8		hlLevel8
hi link   texLeftRight9		hlLevel9

hi link   texMath0			hlLevel0
hi link   texMath1			hlLevel1
hi link   texMath2			hlLevel2
hi link   texMath3			hlLevel3
hi link   texMath4			hlLevel4
hi link   texMath5			hlLevel5
hi link   texMath6			hlLevel6
hi link   texMath7			hlLevel7
hi link   texMath8			hlLevel8
hi link   texMath9			hlLevel9
hi link   texSpecial		Special

" ---------------------------------------------------------------------
"  Modelines: {{{1
let &cpo= keepcpo
" vim: fdm=marker ft=vim ts=4
after/syntax/matlab/rainbow.vvim	[[[1
312
" rainbow.vvim : provides "rainbow-colored" pairings for
"               Matlab language version
"   Author: 	Charles E. Campbell, Jr.
"   Date:		Sep 23, 2011
"   Associated Files:  plugin/RainbowPlugin.vim autoload/Rainbow.vim doc/Rainbow.txt
" ---------------------------------------------------------------------
" non-compatible only: {{{1
if &cp
 finish
endif
let keepcpo= &cpo
let s:work = ''
set cpo&vim

" ---------------------------------------------------------------------
" Default Settings: {{{1
if !exists("g:hlrainbow_matlab")
 let g:hlrainbow_matlab= 'if for switch while'
endif
"call Decho("g:hlrainbow_matlab<".g:hlrainbow_matlab.">")

" ---------------------------------------------------------------------
" remove some keyword based matching that syntax/matlab.vim uses, and
" remove any previous matlab-based rainbow highlighting
syn clear matlabLabel matlabConditional matlabRepeat
sil! syn clear matlabRif0matlabRif1,matlabRif2,matlabRif3,matlabRif4,matlabRif5,matlabRif6,matlabRif7,matlabRif8,matlabRif9,
sil! syn clear matlabRfor0matlabRfor1,matlabRfor2,matlabRfor3,matlabRfor4,matlabRfor5,matlabRfor6,matlabRfor7,matlabRfor8,matlabRfor9,
sil! syn clear matlabRwhile0matlabRwhile1,matlabRwhile2,matlabRwhile3,matlabRwhile4,matlabRwhile5,matlabRwhile6,matlabRwhile7,matlabRwhile8,matlabRwhile9,
sil! syn clear matlabRswitch0matlabRswitch1,matlabRswitch2,matlabRswitch3,matlabRswitch4,matlabRswitch5,matlabRswitch6,matlabRswitch7,matlabRswitch8,matlabRswitch9,
sil! syn clear matlabRelse0matlabRelse1,matlabRelse2,matlabRelse3,matlabRelse4,matlabRelse5,matlabRelse6,matlabRelse7,matlabRelse8,matlabRelse9,
sil! syn clear matlabRbreak0matlabRbreak1,matlabRbreak2,matlabRbreak3,matlabRbreak4,matlabRbreak5,matlabRbreak6,matlabRbreak7,matlabRbreak8,matlabRbreak9,
sil! hi clear hlLevel0,hlLevel1,hlLevel2,hlLevel3,hlLevel4,hlLevel5,hlLevel6,hlLevel7,hlLevel8,hlLevel9

" ---------------------------------------------------------------------
" set up clusters {{{1
syn cluster matlabGroup	contains=matlabArithmeticOperator,matlabComment,matlabDelimiter,matlabError,matlabExceptions,matlabFloat,matlabFunction,matlabImplicit,matlabLineContinuation,matlabLogicalOperator,matlabMultilineComment,matlabNumber,matlabOO,matlabOperator,matlabRelationalOperator,matlabScope,matlabSemicolon,matlabString,matlabTodo,matlabTransposeOperator,matlabTransposeOther
syn cluster matlabRainbowGroup0 contains=@matlabGroup,matlabRif1,matlabRfor1,matlabRwhile1,matlabRswitch1
syn cluster matlabRainbowGroup1 contains=@matlabGroup,matlabRif2,matlabRfor2,matlabRwhile2,matlabRswitch2
syn cluster matlabRainbowGroup2 contains=@matlabGroup,matlabRif3,matlabRfor3,matlabRwhile3,matlabRswitch3
syn cluster matlabRainbowGroup3 contains=@matlabGroup,matlabRif4,matlabRfor4,matlabRwhile4,matlabRswitch4
syn cluster matlabRainbowGroup4 contains=@matlabGroup,matlabRif5,matlabRfor5,matlabRwhile5,matlabRswitch5
syn cluster matlabRainbowGroup5 contains=@matlabGroup,matlabRif6,matlabRfor6,matlabRwhile6,matlabRswitch6
syn cluster matlabRainbowGroup6 contains=@matlabGroup,matlabRif7,matlabRfor7,matlabRwhile7,matlabRswitch7
syn cluster matlabRainbowGroup7 contains=@matlabGroup,matlabRif8,matlabRfor8,matlabRwhile8,matlabRswitch8
syn cluster matlabRainbowGroup8 contains=@matlabGroup,matlabRif9,matlabRfor9,matlabRwhile9,matlabRswitch9
syn cluster matlabRainbowGroup9 contains=@matlabGroup,matlabRif0,matlabRfor0,matlabRwhile0,matlabRswitch0

" ---------------------------------------------------------------------
" Substitute rainbow'ed syntax {{{1

" ---------------------------------------------------------------------
"  if: {{{2
if g:hlrainbow_matlab =~ '\<if\>'
 syn region matlabRif0		matchgroup=hlLevel0	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup0,matlabRelse0
 syn region matlabRif1		matchgroup=hlLevel1	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup1,matlabRelse1	contained
 syn region matlabRif2		matchgroup=hlLevel2	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup2,matlabRelse2	contained
 syn region matlabRif3		matchgroup=hlLevel3	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup3,matlabRelse3	contained
 syn region matlabRif4		matchgroup=hlLevel4	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup4,matlabRelse4	contained
 syn region matlabRif5		matchgroup=hlLevel5	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup5,matlabRelse5	contained
 syn region matlabRif6		matchgroup=hlLevel6	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup6,matlabRelse6	contained
 syn region matlabRif7		matchgroup=hlLevel7	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup7,matlabRelse7	contained
 syn region matlabRif8		matchgroup=hlLevel8	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup8,matlabRelse8	contained
 syn region matlabRif9		matchgroup=hlLevel9	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup9,matlabRelse9	contained
                                                                                                                   
 syn match matlabRelse0		contained	"\<else\(if\)\=\>"
 syn match matlabRelse1		contained	"\<else\(if\)\=\>"
 syn match matlabRelse2		contained	"\<else\(if\)\=\>"
 syn match matlabRelse3		contained	"\<else\(if\)\=\>"
 syn match matlabRelse4		contained	"\<else\(if\)\=\>"
 syn match matlabRelse5		contained	"\<else\(if\)\=\>"
 syn match matlabRelse6		contained	"\<else\(if\)\=\>"
 syn match matlabRelse7		contained	"\<else\(if\)\=\>"
 syn match matlabRelse8		contained	"\<else\(if\)\=\>"
 syn match matlabRelse9		contained	"\<else\(if\)\=\>"

 hi link matlabRelse0		hlLevel0
 hi link matlabRelse1		hlLevel1
 hi link matlabRelse2		hlLevel2
 hi link matlabRelse3		hlLevel3
 hi link matlabRelse4		hlLevel4
 hi link matlabRelse5		hlLevel5
 hi link matlabRelse6		hlLevel6
 hi link matlabRelse7		hlLevel7
 hi link matlabRelse8		hlLevel8
 hi link matlabRelse9		hlLevel9

else

 syn region matlabRif0		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup0,matlabRelse0
 syn region matlabRif1		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup1,matlabRelse1	contained
 syn region matlabRif2		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup2,matlabRelse2	contained
 syn region matlabRif3		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup3,matlabRelse3	contained
 syn region matlabRif4		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup4,matlabRelse4	contained
 syn region matlabRif5		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup5,matlabRelse5	contained
 syn region matlabRif6		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup6,matlabRelse6	contained
 syn region matlabRif7		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup7,matlabRelse7	contained
 syn region matlabRif8		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup8,matlabRelse8	contained
 syn region matlabRif9		matchgroup=None	start="\<if\>"			end="\<end\>"	contains=@matlabRainbowGroup9,matlabRelse9	contained
                                                                                                                   
 syn match matlabRelse0		contained	"\<else\(if\)\=\>"
 syn match matlabRelse1		contained	"\<else\(if\)\=\>"
 syn match matlabRelse2		contained	"\<else\(if\)\=\>"
 syn match matlabRelse3		contained	"\<else\(if\)\=\>"
 syn match matlabRelse4		contained	"\<else\(if\)\=\>"
 syn match matlabRelse5		contained	"\<else\(if\)\=\>"
 syn match matlabRelse6		contained	"\<else\(if\)\=\>"
 syn match matlabRelse7		contained	"\<else\(if\)\=\>"
 syn match matlabRelse8		contained	"\<else\(if\)\=\>"
 syn match matlabRelse9		contained	"\<else\(if\)\=\>"

 sil! syn clear matlabRelse0
 sil! syn clear matlabRelse1
 sil! syn clear matlabRelse2
 sil! syn clear matlabRelse3
 sil! syn clear matlabRelse4
 sil! syn clear matlabRelse5
 sil! syn clear matlabRelse6
 sil! syn clear matlabRelse7
 sil! syn clear matlabRelse8
 sil! syn clear matlabRelse9
endif

" ---------------------------------------------------------------------
"  for: {{{2
if g:hlrainbow_matlab =~ '\<for\>'
 syn region matlabRfor0			matchgroup=hlLevel0	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup0,matlabRbreak0
 syn region matlabRfor1			matchgroup=hlLevel1	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup1,matlabRbreak1	contained
 syn region matlabRfor2			matchgroup=hlLevel2	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup2,matlabRbreak2	contained
 syn region matlabRfor3			matchgroup=hlLevel3	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup3,matlabRbreak3	contained
 syn region matlabRfor4			matchgroup=hlLevel4	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup4,matlabRbreak4	contained
 syn region matlabRfor5			matchgroup=hlLevel5	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup5,matlabRbreak5	contained
 syn region matlabRfor6			matchgroup=hlLevel6	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup6,matlabRbreak6	contained
 syn region matlabRfor7			matchgroup=hlLevel7	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup7,matlabRbreak7	contained
 syn region matlabRfor8			matchgroup=hlLevel8	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup8,matlabRbreak8	contained
 syn region matlabRfor9			matchgroup=hlLevel9	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup9,matlabRbreak9	contained

 if g:hlrainbow_matlab !~ '\<while\>'
  syn match matlabRbreak0	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak1	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak2	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak3	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak4	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak5	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak6	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak7	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak8	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak9	contained	"\<\(break\|continue\)\>"

  hi link matlabRbreak0 			hlLevel0
  hi link matlabRbreak1 			hlLevel1
  hi link matlabRbreak2 			hlLevel2
  hi link matlabRbreak3 			hlLevel3
  hi link matlabRbreak4 			hlLevel4
  hi link matlabRbreak5 			hlLevel5
  hi link matlabRbreak6 			hlLevel6
  hi link matlabRbreak7 			hlLevel7
  hi link matlabRbreak8 			hlLevel8
  hi link matlabRbreak9 			hlLevel9
 endif
else

 syn region matlabRfor0			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup0,matlabRbreak0
 syn region matlabRfor1			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup1,matlabRbreak1	contained
 syn region matlabRfor2			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup2,matlabRbreak2	contained
 syn region matlabRfor3			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup3,matlabRbreak3	contained
 syn region matlabRfor4			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup4,matlabRbreak4	contained
 syn region matlabRfor5			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup5,matlabRbreak5	contained
 syn region matlabRfor6			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup6,matlabRbreak6	contained
 syn region matlabRfor7			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup7,matlabRbreak7	contained
 syn region matlabRfor8			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup8,matlabRbreak8	contained
 syn region matlabRfor9			matchgroup=None	start="\<for\>"			end="\<end\>"	contains=@matlabRainbowGroup9,matlabRbreak9	contained

 if g:hlrainbow_matlab !~ '\<while\>'
  syn match matlabRbreak0	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak1	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak2	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak3	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak4	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak5	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak6	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak7	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak8	contained	"\<\(break\|continue\)\>"
  syn match matlabRbreak9	contained	"\<\(break\|continue\)\>"
 endif
endif

" ---------------------------------------------------------------------
"  switch: {{{2
if g:hlrainbow_matlab =~ '\<switch\>'
 syn region matlabRswitch0		matchgroup=hlLevel0	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup0,matlabRcase0
 syn region matlabRswitch1		matchgroup=hlLevel1	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup1,matlabRcase1	contained
 syn region matlabRswitch2		matchgroup=hlLevel2	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup2,matlabRcase2	contained
 syn region matlabRswitch3		matchgroup=hlLevel3	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup3,matlabRcase3	contained
 syn region matlabRswitch4		matchgroup=hlLevel4	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup4,matlabRcase4	contained
 syn region matlabRswitch5		matchgroup=hlLevel5	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup5,matlabRcase5	contained
 syn region matlabRswitch6		matchgroup=hlLevel6	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup6,matlabRcase6	contained
 syn region matlabRswitch7		matchgroup=hlLevel7	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup7,matlabRcase7	contained
 syn region matlabRswitch8		matchgroup=hlLevel8	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup8,matlabRcase8	contained
 syn region matlabRswitch9		matchgroup=hlLevel9	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup9,matlabRcase9	contained

 syn match matlabRcase0			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase1			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase2			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase3			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase4			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase5			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase6			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase7			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase8			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase9			contained	"\<\(case\|otherwise\)\>"

 hi link matlabRcase0			hlLevel0
 hi link matlabRcase1			hlLevel1
 hi link matlabRcase2			hlLevel2
 hi link matlabRcase3			hlLevel3
 hi link matlabRcase4			hlLevel4
 hi link matlabRcase5			hlLevel5
 hi link matlabRcase6			hlLevel6
 hi link matlabRcase7			hlLevel7
 hi link matlabRcase8			hlLevel8
 hi link matlabRcase9			hlLevel9
else

 syn region matlabRswitch0		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup0,matlabRcase0
 syn region matlabRswitch1		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup1,matlabRcase1	contained
 syn region matlabRswitch2		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup2,matlabRcase2	contained
 syn region matlabRswitch3		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup3,matlabRcase3	contained
 syn region matlabRswitch4		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup4,matlabRcase4	contained
 syn region matlabRswitch5		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup5,matlabRcase5	contained
 syn region matlabRswitch6		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup6,matlabRcase6	contained
 syn region matlabRswitch7		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup7,matlabRcase7	contained
 syn region matlabRswitch8		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup8,matlabRcase8	contained
 syn region matlabRswitch9		matchgroup=None	start="\<switch\>"			end="\<end\>"	contains=@matlabRainbowGroup9,matlabRcase9	contained


 syn match matlabRcase0			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase1			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase2			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase3			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase4			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase5			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase6			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase7			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase8			contained	"\<\(case\|otherwise\)\>"
 syn match matlabRcase9			contained	"\<\(case\|otherwise\)\>"
endif

" ---------------------------------------------------------------------
"  while: {{{2
if g:hlrainbow_matlab =~ '\<while\>'
 syn region matlabRwhile0		matchgroup=hlLevel0	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup0,matlabRbreak0
 syn region matlabRwhile1		matchgroup=hlLevel1	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup1,matlabRbreak1	contained
 syn region matlabRwhile2		matchgroup=hlLevel2	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup2,matlabRbreak2	contained
 syn region matlabRwhile3		matchgroup=hlLevel3	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup3,matlabRbreak3	contained
 syn region matlabRwhile4		matchgroup=hlLevel4	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup4,matlabRbreak4	contained
 syn region matlabRwhile5		matchgroup=hlLevel5	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup5,matlabRbreak5	contained
 syn region matlabRwhile6		matchgroup=hlLevel6	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup6,matlabRbreak6	contained
 syn region matlabRwhile7		matchgroup=hlLevel7	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup7,matlabRbreak7	contained
 syn region matlabRwhile8		matchgroup=hlLevel8	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup8,matlabRbreak8	contained
 syn region matlabRwhile9		matchgroup=hlLevel9	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup9,matlabRbreak9	contained

 syn match matlabRbreak0	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak1	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak2	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak3	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak4	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak5	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak6	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak7	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak8	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak9	contained	"\<\(break\|continue\)\>"

 hi link matlabRbreak0 			hlLevel0
 hi link matlabRbreak1 			hlLevel1
 hi link matlabRbreak2 			hlLevel2
 hi link matlabRbreak3 			hlLevel3
 hi link matlabRbreak4 			hlLevel4
 hi link matlabRbreak5 			hlLevel5
 hi link matlabRbreak6 			hlLevel6
 hi link matlabRbreak7 			hlLevel7
 hi link matlabRbreak8 			hlLevel8
 hi link matlabRbreak9 			hlLevel9

else

 syn region matlabRwhile0		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup0,matlabRbreak0
 syn region matlabRwhile1		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup1,matlabRbreak1	contained
 syn region matlabRwhile2		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup2,matlabRbreak2	contained
 syn region matlabRwhile3		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup3,matlabRbreak3	contained
 syn region matlabRwhile4		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup4,matlabRbreak4	contained
 syn region matlabRwhile5		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup5,matlabRbreak5	contained
 syn region matlabRwhile6		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup6,matlabRbreak6	contained
 syn region matlabRwhile7		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup7,matlabRbreak7	contained
 syn region matlabRwhile8		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup8,matlabRbreak8	contained
 syn region matlabRwhile9		matchgroup=None	start="\<while\>"		end="\<end\>"	contains=@matlabRainbowGroup9,matlabRbreak9	contained

 syn match matlabRbreak0	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak1	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak2	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak3	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak4	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak5	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak6	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak7	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak8	contained	"\<\(break\|continue\)\>"
 syn match matlabRbreak9	contained	"\<\(break\|continue\)\>"
endif

" ---------------------------------------------------------------------
"  Modelines: {{{1
let &cpo= keepcpo
" vim: fdm=marker ft=vim ts=4
after/syntax/lisp/rainbow.vvim	[[[1
57
" rainbow.vim: highlights different levels of () with different colors
"  Lisp language version
"  Author: Charles E. Campbell, Jr.
"  Date:   Oct 19, 2012
"  Version:	2
" ---------------------------------------------------------------------
" non-compatible only: {{{1
if &cp
 finish
endif
let keepcpo= &cpo
let s:work = ''
set cpo&vim

" ---------------------------------------------------------------------
" syntax: {{{1
syn region lispParen0           transparent matchgroup=hlLevel0 start="(" end=")" contains=@lispListCluster,lispParen1 
syn region lispParen1 contained transparent matchgroup=hlLevel1 start="(" end=")" contains=@lispListCluster,lispParen2 
syn region lispParen2 contained transparent matchgroup=hlLevel2 start="(" end=")" contains=@lispListCluster,lispParen3 
syn region lispParen3 contained transparent matchgroup=hlLevel3 start="(" end=")" contains=@lispListCluster,lispParen4 
syn region lispParen4 contained transparent matchgroup=hlLevel4 start="(" end=")" contains=@lispListCluster,lispParen5 
syn region lispParen5 contained transparent matchgroup=hlLevel5 start="(" end=")" contains=@lispListCluster,lispParen6 
syn region lispParen6 contained transparent matchgroup=hlLevel6 start="(" end=")" contains=@lispListCluster,lispParen7 
syn region lispParen7 contained transparent matchgroup=hlLevel7 start="(" end=")" contains=@lispListCluster,lispParen8 
syn region lispParen8 contained transparent matchgroup=hlLevel8 start="(" end=")" contains=@lispListCluster,lispParen9 
syn region lispParen9 contained transparent matchgroup=hlLevel9 start="(" end=")" contains=@lispListCluster,lispParen0

" ---------------------------------------------------------------------
" highlighting: {{{1
if &bg == "dark"
 hi   hlLevel0 ctermfg=red         guifg=red1
 hi   hlLevel1 ctermfg=yellow      guifg=orange1      
 hi   hlLevel2 ctermfg=green       guifg=yellow1      
 hi   hlLevel3 ctermfg=cyan        guifg=greenyellow  
 hi   hlLevel4 ctermfg=magenta     guifg=green1       
 hi   hlLevel5 ctermfg=red         guifg=springgreen1 
 hi   hlLevel6 ctermfg=yellow      guifg=cyan1        
 hi   hlLevel7 ctermfg=green       guifg=slateblue1   
 hi   hlLevel8 ctermfg=cyan        guifg=magenta1     
 hi   hlLevel9 ctermfg=magenta     guifg=purple1
else
 hi   hlLevel0 ctermfg=red         guifg=red3
 hi   hlLevel1 ctermfg=darkyellow  guifg=orangered3
 hi   hlLevel2 ctermfg=darkgreen   guifg=orange2
 hi   hlLevel3 ctermfg=blue        guifg=yellow3
 hi   hlLevel4 ctermfg=darkmagenta guifg=olivedrab4
 hi   hlLevel5 ctermfg=red         guifg=green4
 hi   hlLevel6 ctermfg=darkyellow  guifg=paleturquoise3
 hi   hlLevel7 ctermfg=darkgreen   guifg=deepskyblue4
 hi   hlLevel8 ctermfg=blue        guifg=darkslateblue
 hi   hlLevel9 ctermfg=darkmagenta guifg=darkviolet
endif

" ---------------------------------------------------------------------
"  Modelines: {{{1
let &cpo= keepcpo
" vim: fdm=marker ft=vim ts=4
doc/Rainbow.txt	[[[1
130
*rainbow.txt*	The Rainbow Tool		       Oct 19, 2012

Author:    Charles E. Campbell, Jr.  <NdrOchip@ScampbellPfamily.AbizM>
           (remove NOSPAM from Campbell's email first)
Copyright: (c) 2004-2011 by Charles E. Campbell, Jr.	*Rainbow-copyright*
           The VIM LICENSE applies to Rainbow.vim, RainbowPlugin.vim, and
	   Rainbow.txt (see |copyright|) except use "Rainbow" instead of
	   "Vim".
	   NO WARRANTY, EXPRESS OR IMPLIED.  USE AT-YOUR-OWN-RISK.

==============================================================================
1. Contents					*rainbow* *rainbow-contents* {{{1

	1. Contents.....................................: |rainbow-contents|
	2. Usage........................................: |rainbow-usage|
	3. History......................................: |rainbow-history|

==============================================================================
2. Usage						*rainbow-usage*   {{{1

INSTALL
	vim rainbow.vba.gz
	:so %
	:q

TUTORIAL					*:rainbow-tutorial*
	Simply edit one of the supported filetypes
	(currently, c, c++, matlab, Latex, or javascript):

	    vim somefile
	    :Rainbow   -- this will turn rainbow highlighting on
	    :Rainbow!  -- this will turn rainbow highlighting off

MANUAL							*:Rainbow*

					*rainbow-c* *rainbow-cpp*
	:Rainbow and C/C++:~
	This command will enable rainbow highlighting for C and C++.
	One may also pass the desired set of delimiters to be
	rainbow'd via this command: (also see |g:hlrainbow_c|) >

		:Rainbow {[(
		:Rainbow {(
		:Rainbow {[
		:Rainbow [(
		:Rainbow {
		:Rainbow [
		:Rainbow (
<
	These forms of the :Rainbow command alter the g:hlrainbow
	variable value.

							 *rainbow-lisp*
	:Rainbow and Lisp:~
	For lisp, :Rainbow (and, conversely, :Rainbow!) enable/disable
	rainbow highlighting for Lisp (*.lsp) files.

							 *rainbow-matlab*
	:Rainbow and Matlab:~
	For matlab files, :Rainbow and :Rainbow! provide/disable rainbow
	highlighting for Mat (*.m) files.  One may also pass a selective
	set of items to be rainbow'd via this command:
	(also see |g:hlrainbow_matlab|) >

		:Rainbow if for switch while
<
	or any subset.

							*rainbow-tex*
	:Rainbow and TeX:~
	This command enables rainbow highlighting for LaTeX (*.tex) files.
	It isn't intended for regular use, but to make it easier to locate
	problems with missing "$"s, etc.

							*:Rainbow!*
	:Rainbow!~
	This command will disable rainbow highlighting for C and C++.

	This plugin provides a "rainbow" of colors for matching brackets
	( [] () {} ) depending upon their nesting level; it is intended to
	provide support the C and C++ languages.

					*g:hlrainbow_c* *g:hlrainbow_cpp*
	g:hlrainbow_c/g:hlrainbow_cpp:~
	This global variable holds characters such as "(){}[]"; by default
	it holds "{(".  It enables rainbow highlighting as follows:
	  "(" or ")":  ( and ) rainbow highlighting
	  "{" or "}":  { and } rainbow highlighting
	  "[" or "]":  [ and ] rainbow highlighting

							*g:hlrainbow_js*
	g:hlrainbow_js:~
	This global variable holds characters such as "(){}"; by default
	it holds "{(".  It enables rainbow highlighting as follows:
	  "(" or ")":  ( and ) rainbow highlighting
	  "{" or "}":  { and } rainbow highlighting

						*g:hlrainbow_matlab*
	g:hlrainbow and Matlab:~
	This global variable holds a string which may contain one or more of
	the following words: >

		if for switch while
<
	and enables rainbow highlighting for the associated Matlab grammar.

==============================================================================
3. History						*rainbow-history* {{{1

 v2	Oct 20, 2009	* supports Rainbow command to turn rainbow
			  highlighting on/off.
			* (Greg Klein) pointed out that "contained" seemed to
			  be missing from the cParenXX definitions.
			* I've commented out the cCppParen definitions,
			  letting cParenXX work.  I noticed a problem with
			  these: (the following closing parenthesis got
			  highlighted as an error)
			    int f(int x,
			          int y)
			  and I'm afraid I don't remember why there was
			  a separate set of definitions for C++.  If anyone
			  sees a problem -- please give me an example (short
			  is good)
	Nov 01, 2009	* :Rainbow {[( and variants supported.
	Sep 26, 2011	* Matlab, LaTeX, and Javascript supported
	Oct 19, 2012	* Included rainbow-parentheses support for Lisp

==============================================================================
Modelines: {{{1
vim:tw=78:ts=8:ft=help:fdm=marker:
