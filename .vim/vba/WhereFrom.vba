" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
plugin/WhereFrom.vim	[[[1
281
" WhereFrom.vim
"  Author:	Charles E. Campbell, Jr.
"  Date:	Aug 16, 2005
"  Version:	3a	ASTRO-ONLY
"  Copyright:   Copyright (C) 2004-2005 Charles E. Campbell, Jr. {{{1
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like anything else that's free,
"               WhereFrom.vim is provided *as is* and comes with no warranty
"               of any kind, either expressed or implied. By using this
"               plugin, you agree that in no event will the copyright
"               holder be liable for any damages resulting from the use
"               of this software.
"
"  Usage: {{{1
"    WhereFrom[!] functionname(s)      WF[!] functionname(s)
"    WhereFrom[!] map(s)               WF[!] map(s)
"    WhereFrom[!] setting(s)           WF[!] setting(s)
"    WhereFrom[!] command(s)           WF[!] command(s)
"
"    The command searches the runtimepath (see :he runtimepath) to
"    determine where the function, map, or command is written.
"    With the "!", WhereFrom will continue looking for more than
"    one instance.
"
"    WF-style commands are available only if the command has
"    not been previously defined.
"
" GetLatestVimScripts: 1203 1 :AutoInstall: WhereFrom.vim
" GetLatestVimScripts: 1066 1 :AutoInstall: cecutil.vim

" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("g:loaded_WhereFrom")
 finish
endif
let s:keepcpo          = &cpo
let g:loaded_WhereFrom = "v3a"
set cpo&vim

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com!     -bang -nargs=+ WhereFrom	:call s:WhereFrom(<bang>0,<f-args>)
sil! com -bang -nargs=+ WF			:call s:WhereFrom(<bang>0,<f-args>)

" ---------------------------------------------------------------------
"  Support Functions: {{{1
" ---------------------------------------------------------------------
" WhereFrom: {{{2
fun! s:WhereFrom(bang,...)
"  call Dfunc("WhereFrom(bang=".a:bang."...) a:0=".a:0)

  " --------------------
  " initialize settings: {{{3
  " --------------------
  let iarg   = 1
  let akeep  = @a
  let eikeep = &ei
  let lzkeep = &lz
  set ei=all
  set lz
  let s:keeplastbufnr = bufnr("$")

  " for all arguments on the command line...
  while iarg <= a:0
"   call Decho(iarg.") <".a:{iarg}.">")

   " ---------------------------
   "  is the argument a map? {{{3
   " ---------------------------
   if v:version < 700
    if maparg(a:{iarg},"") != "" || maparg(a:{iarg},"i") != "" || maparg(a:{iarg},"c") != "" || maparg(a:{iarg},"l") != ""
     if exists("g:mapleader") && match(a:{iarg},'^'.g:mapleader) == 0
     	" allow a:{iarg} to handle map...<Leader>modsrch
	  let mlgt      = '[>'.escape(escape(g:mapleader,'\'),'\').']'
	  let modsrch   = substitute(a:{iarg},g:mapleader,mlgt,'')
     else
     	" support searching for maps or commands
	  let mlgt      = '[>\\\\]'
	  let modsrch   = substitute(a:{iarg},'^\\',mlgt,'')
     endif
     call WhereFromSrch(a:bang,a:{iarg},'\(map\|[nvoilc]m\%[ap]\|\([oilc]\=no\|[nv]n\)\%[remap]\|com\%[mand]\)!\=\s.*'.modsrch.'\s')
     let foundit = 1
     let iarg    = iarg + 1
     continue
    else
"     call Decho("not a mapping")
    endif
   else
    redir @a
	exe  "keepjumps silent verbose map ".a:{iarg}."?"
	redir  END
	if @a =~ "No mapping found"
"     call Decho("not a setting")
     let foundit= 0
	else
     let foundit= 1
	 echomsg substitute(@a,'^\n*','','e')
	 let  iarg= iarg + 1
	 continue
    endif
   endif

   " don't even bother looking further if there's a
   " non-alphanumeric character involved
   if a:{iarg} =~ '\W'
    let iarg= iarg + 1
    continue
   endif

   " --------------------------
   " is the argument a setting? {{{3
   " --------------------------
   let foundit= 1
   try
   	redir @a
	exe "keepjumps silent verbose set ".a:{iarg}."?"
	redir END
   catch /^Vim\%((\a\+)\)\=:E518/
   	" Not a setting
"   	call Decho("catch occurred on a:{".iarg."}<".a:{iarg}.">")
    let foundit= 0
   endtry
   if foundit
    echomsg substitute(@a,'^.*\(Last.*\)$',a:{iarg}.': \1','')
	let iarg= iarg + 1
	continue
   else
"   	call Decho("not a setting")
   endif

   " --------------------------------
   " is the argument an abbreviation? {{{3
   " --------------------------------
   let foundit= 0
   redir @a
   exe "keepjumps silent ab ".a:{iarg}
   redir END
   if @a =~ '\<'.a:{iarg}.'\>' && @a != "No abbreviation found"
    call WhereFromSrch(a:bang,a:{iarg},'ab\%[breviate]\s\+'.a:{iarg}.'\>')
	let foundit = 1
	let iarg    = iarg + 1
	continue
   else
"   	call Decho("not an abbreviation")
   endif

  " ---------------------------
  "  is the argument a command? {{{3
  " ---------------------------
   redir @a
    exe "keepjumps silent com ".a:{iarg}
   redir END
   if @a =~ "\n".'....\zs\<'.a:{iarg}.'\>'
"   call Decho("found a command a:{".iarg."}<".a:{iarg}.">")
    call WhereFromSrch(a:bang,a:{iarg},'\<com\%[mand]\>.*\<'.a:{iarg}.'\>')
    let foundit = 1
    let iarg    = iarg + 1
    continue
   else
"   call Decho("not a command")
   endif

   " -----------------------------
   "   is the argument a function? {{{3
   " -----------------------------
   let foundit= 0
   redir @a
    exe "keepjumps silent! function ".a:{iarg}
   redir END
   if @a =~ 'function \%('.a:{iarg}.'\|\S*_'.a:{iarg}.'\)('
    call WhereFromSrch(a:bang,a:{iarg},'\<fu\%[nction]!\=\s*\(<[sS][iI][dD]>\|[sS]:\)\='.a:{iarg}.'\>')
    let foundit = 1
    let iarg    = iarg + 1
    continue
   else
"    call Decho("not a function")
   endif

   " report if unable to find requested argument
   if !foundit
    echomsg "***WhereFrom*** sorry, am unable to find <".a:{iarg}.">"
   endif

   " update command being searched for
   let iarg= iarg + 1
  endwhile

  " ------------------------------
  " restore registers and settings {{{3
  " ------------------------------
  let @a  = akeep
  let &ei = eikeep
  let &lz = lzkeep
"  call Dret("WhereFrom : foundit=".foundit)
endfun

" ---------------------------------------------------------------------
" WhereFromSrch: {{{2
"   Implements search for a pattern in files in the runtimepath
fun! WhereFromSrch(bang,object,srchstring)
"  call Dfunc("WhereFromSrch(bang=".a:bang." object<".a:object."> srchstring<".a:srchstring.">)")
  " initialize search {{{3
  let foundit       = 0
  let srchstring    = a:srchstring
"  call Decho("keeplastbufnr=".s:keeplastbufnr)

  " set up list of files to be searched {{{3
  let vimfiles=expand("$HOME")."/.vimrc"
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"plugin/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"AsNeeded/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"ftplugin/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"ftplugin/*/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"colors/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"compiler/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"indent/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"syntax/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"syntax/*/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"after/ftplugin/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"after/colors/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"after/compiler/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"after/indent/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"after/plugin/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"after/ftplugin/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"after/ftplugin/*/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"after/syntax/*.vim"),'\n',',',"ge")
  let vimfiles=vimfiles.",".substitute(globpath(&rtp,"after/syntax/*/*.vim"),'\n',',',"ge")
  silent 1new! WhereFromBuffer
  let wfbufnr= bufnr("%")
"  call Decho("wfbufnr=".wfbufnr)
  setlocal buftype=nofile noswapfile noro nobl
  let vimfiles= substitute(vimfiles,',\+',',','ge')
"  call Decho("vimfiles: ".vimfiles)

  " search files {{{3
  while vimfiles != ""
   let vimfile = substitute(vimfiles,',.*$','','e')
   let vimfiles= (vimfiles =~ ",")? substitute(vimfiles,'^[^,]*,\(.*\)$','\1','e') : ""
"   call Decho("..considering file<".vimfile.">")
   if !filereadable(vimfile)
    let vimfile= ""
   	continue
   endif
   silent! %d
   exe "silent 0r ".vimfile
   if bufnr("$") > wfbufnr
"   	call Decho("bwipe read-in buf#".bufnr("$"))
    exe bufnr("$")."bwipe!"
   endif
"   call Decho("srchstring<".srchstring.">")
   let srchresult= search(srchstring)
   if srchresult != 0
    let mapstring = getline(srchresult)
"	call Decho(a:object.": defined in file<".vimfile."> line#".line("."))
    echomsg a:object.": defined in file<".vimfile."> line#".line(".")
    let foundit= 1
	if a:bang == 0
	 break
	endif
   endif
   let vimfile= ""
  endwhile

  " cleanup {{{3
  if wfbufnr > s:keeplastbufnr && bufloaded(wfbufnr)
"   call Decho("bwipe wherefrombuf#".wfbufnr." keeplastbufnr=".s:keeplastbufnr)
   exe wfbufnr."bwipe!"
  endif

  " report a failure to find the object {{{3
  if !foundit
   echomsg a:object.": its defined, but its not on the runtimepath"
  endif
"  call Dret("WhereFromSrch")
endfun

let &cpo= s:keepcpo
unlet s:keepcpo
" ---------------------------------------------------------------------
"  Modelines: {{{1
"  vim: ts=4 fdm=marker
doc/WhereFrom.txt	[[[1
64
*wherefrom.txt*	Where is Something From?			Aug 16, 2005

Author:  Charles E. Campbell, Jr.  <NdrOchip@ScampbellPfamily.AbizM>
	  (remove NOSPAM from Campbell's email first)
Copyright: (c) 2004-2005 by Charles E. Campbell, Jr.	*wherefrom-copyright*
             Copyright (C) 2004-2005 Charles E. Campbell, Jr. {{{1
             Permission is hereby granted to use and distribute this code,
             with or without modifications, provided that this copyright
             notice is copied with it. Like anything else that's free,
             WhereFrom.vim is provided *as is* and comes with no warranty
             of any kind, either expressed or implied. By using this
             plugin, you agree that in no event will the copyright
             holder be liable for any damages resulting from the use
             of this software.

==============================================================================
1. Contents		*wherefrom* *WF* *WhereFrom* *wherefrom-contents*

	1. Contents...................................: |wherefrom-contents|
	2. WhereFrom Manual...........................: |wherefrom-manual|
	3. WhereFrom History..........................: |wherefrom-history|

==============================================================================

2. WhereFrom Manual			*wherefrom-man* *wherefrom-manual*

	WhereFrom[!] functionname(s)      WF[!] functionname(s)
	WhereFrom[!] map(s)               WF[!] map(s)
	WhereFrom[!] setting(s)           WF[!] setting(s)
	WhereFrom[!] command(s)           WF[!] command(s)
	
	The WhereFrom and WF commands search the runtimepath (see
	|'runtimepath'|) to determine where the setting, function, map, or
	command was defined.  With the "!", WhereFrom will continue looking
	for more than one instance.
	
	WF-style commands are available only if the command has not been
	previously defined, and are provided as a shorthand.

	A search is undertaken only for functions, commands, and maps, and
	then only if the function, command, or map is known to the currently
	running vim.  Determining where settings are set is done using vim's
	built-in method.

	These commands don't search all *.vim files that you may have; it only
	examines those that lie on your runtimepath in the common directories
	plugin, ftplugin, colors, compilier, indent, syntax, and the after/
	variants.  In addition, it also searches the AsNeeded directory
	(see http://vim.sourceforge.net/scripts/script.php?script_id=915)

==============================================================================

3. WhereFrom History					*wherefrom-history*

	3  : Aug 16, 2005 : WhereFrom now takes advantage of vim 7.0 for
	                    determining where maps were last set
	2  : Feb 11, 2005 : GetLatestVimsScripts auto-update line included
	     Feb 22, 2005 : Now gives a message if unable to find a command
	     Apr 20, 2005 : includes $HOME/.vimrc on list of to-be-searched
	                    files
	1  : Jan 27, 2005 : Initial release

==============================================================================
vim:tw=78:ts=8:ft=help
