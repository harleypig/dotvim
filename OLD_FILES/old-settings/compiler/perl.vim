" Vim Compiler File
" Compiler:     Perl syntax checks (perl -Wc)
" Maintainer:   Alan Young <harleypig@gmail.com>
"               Christian J. Robinson <heptite@gmail.com>
" Last Change:  2015 Jul 19

" Stolen from $VIM/vim74/compiler/perl.vim

echo "after/compiler/perl.vim work in progress"
finish

if exists("current_compiler")
  finish
endif
let current_compiler = "perl"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:savecpo = &cpo
set cpo&vim

" If first line has -w then perl -w must be called, the same for -W, -t and
" -T.
"
" It's possible to have these flags with other commands, but they either don't
" require the flag when manually running from the command line or they are
" rare enough and specific enough that we don't want to worry about it here.
"
" It's also possible to have the wierd combination of -wWtT but let's let the
" programer deal with that idiocy.

" =~# ... the # means match case.

let s:firstline = getline(1)
let s:flags  = ''

if s:firstline =~# '-[^ ]*w'
  let s:flags .= 'w'
endif

if s:firstline =~# '-[^ ]*W'
  let s:flags .= 'W'
endif

if s:firstline =~# '-[^ ]*t'
  let s:flags .= 't'
endif

if s:firstline =~# '-[^ ]*T'
  let s:flags .= 'T'
endif

" If
if exists('g:perl_compiler_force_warnings') && g:perl_compiler_force_warnings == 0
	let s:warnopt = 'w'
else
	let s:warnopt = 'W'
endif

if getline(1) =~# '-[^ ]*T'
	let s:taintopt = 'T'
else
	let s:taintopt = ''
endif

exe 'CompilerSet makeprg=perl\ -' . s:warnopt . s:taintopt . 'c\ %'

CompilerSet errorformat=
	\%-G%.%#had\ compilation\ errors.,
	\%-G%.%#syntax\ OK,
	\%m\ at\ %f\ line\ %l.,
	\%+A%.%#\ at\ %f\ line\ %l\\,%.%#,
	\%+C%.%#

" Explanation:
" %-G%.%#had\ compilation\ errors.,  - Ignore the obvious.
" %-G%.%#syntax\ OK,                 - Don't include the 'a-okay' message.
" %m\ at\ %f\ line\ %l.,             - Most errors...
" %+A%.%#\ at\ %f\ line\ %l\\,%.%#,  - As above, including ', near ...'
" %+C%.%#                            -   ... Which can be multi-line.

let &cpo = s:savecpo
unlet s:savecpo
