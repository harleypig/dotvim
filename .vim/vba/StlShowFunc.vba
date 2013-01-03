" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
plugin/StlShowFunc.vim	[[[1
146
" StlShowFunc.vim : status line show-function script
"   Author: Charles E. Campbell
"   Date:   Sep 24, 2012
"   Version: 2q	ASTRO-ONLY
"   Copyright: Charles E. Campbell (09/24/12) (see StlShowFunc.txt for license)
" =====================================================================
" Load Once: {{{1
if &cp || exists("g:loaded_StlShowFunc")
 finish
endif
let s:keepcpo= &cpo
set cpo&vim
let g:loaded_StlShowFunc= "v2q"

" =====================================================================
" Commands: {{{1
com! -bang -nargs=* StlShowFunc	call s:ShowFuncSetup(<bang>1,<f-args>)

" =====================================================================
" Settings:
if !exists("b:stlshowfunc_keep")
 let b:stlshowfunc_keep= &l:stl
endif
if !exists("g:stlshowfunc_stlnofunc")
 let s:stlshowfunc_stlnofunc= '%1*%f%2* %{&kmp }%h%m%r%0*%=%-14.(%l,%c%V%)%< %P Win#%{winnr()} %{winwidth(0)}x%{winheight(0)} %<%{strftime("%a %b %d, %Y, %I:%M:%S %p")}'
else
 let s:stlshowfunc_stlnofunc= g:stlshowfunc_stlnofunc
endif
if !exists("g:stlshowfunc_stlfunc")
 let s:stlshowfunc_stlfunc = '%1*%f %3*%{StlShowFunc()}%2* %h%m%r%0* %= %-14.(%l,%c%V%)%< %P Win#%{winnr()} %{winwidth(0)}x%{winheight(0)} %<%{strftime("%a %b %d, %Y, %I:%M:%S %p")}'
else
 let s:stlshowfunc_stlfunc = g:stlshowfunc_stlfunc
endif
let &l:stl=s:stlshowfunc_stlnofunc

"  Set up User[1234] highlighting only if they're not already defined. {{{2
hi def User1 ctermfg=white ctermbg=blue guifg=white guibg=blue
hi def User2 ctermfg=cyan  ctermbg=blue guifg=cyan  guibg=blue
hi def User3 ctermfg=green ctermbg=blue guifg=green guibg=blue
hi def User4 ctermfg=red   ctermbg=blue guifg=red   guibg=blue

" =====================================================================
"  Functions: {{{1

" ---------------------------------------------------------------------
" ShowFuncSetup: toggle the display of containing function in the status line {{{2
"    StlShowFunc  [lang] - turn showfunc on
"    StlShowFunc!        - turn showfunc off
fun! s:ShowFuncSetup(mode,...)
"  call Dfunc("ShowFuncSetup(mode=".a:mode.") a:0=".a:0)

  if a:0 >= 1
   let stlhandler= a:1
"   call Decho("stlhandler<".stlhandler.">")
  endif
  if a:0 >= 2
   let stlhandlerlist= a:2
"   call Decho("stlhandlerlist<".stlhandlerlist.">")
  elseif a:0 >= 1
   let stlhandlerlist= "*.".a:1
  else
   let stlhandlerlist= "*.".&ft
  endif
  if !exists("s:showfunclang")
   let s:showfunclang= []
  endif

  if a:mode
   " turning StlShowFunc mode on
   if a:0 == 0
	echohl Error | echo "(ShowFuncSetup) missing stlhandler" | echohl None
"	call Dret("ShowFuncSetup : missing stlhandler")
	return
   endif
   " check if stlhandler has already been added to the autocmd list
   if count(s:showfunclang,stlhandler) == 0
   	let s:showfunc= 0
	call add(s:showfunclang,stlhandler)
"	call Decho('s:showfunclang'.string(s:showfunclang))
   endif
"   call Decho("s:showfunc ".(exists("s:showfunc")? "exists" : "doesn't exist"))
"   call Decho("StlShowFunc_".stlhandler."() ".(exists("*StlShowFunc_".stlhandler)? "exists" : "doesn't exist"))

   if (!exists("s:showfunc") || s:showfunc == 0) && exists("*StlShowFunc_".stlhandler)
   	" enable StlShowFunc for stlhandler language
"	call Decho("enabling StlShowFunc_".stlhandler)
    let s:showfunc= 1
"    call Decho("exe au CursorMoved *.".stlhandler." call StlShowFunc_".stlhandler."()")
    augroup STLSHOWFUNC
	 exe "au CursorMoved ".stlhandlerlist." call StlShowFunc_".stlhandler."()"
    augroup END
"	call Decho("exe call StlShowFunc_".stlhandler."()")
	exe "call StlShowFunc_".stlhandler."()"
   endif

  else
   " turning StlShowFunc mode off
   " remove *all* StlShowFunc handlers
   if exists("s:showfunc") && s:showfunc == 1
"	call Decho("disabling all StlShowFunc_*")
	let &l:stl=b:stlshowfunc_keep
    augroup STLSHOWFUNC
    	au!
    augroup END
    augroup! STLSHOWFUNC
   endif
   let s:showfunc     = 0
   let s:showfunclang = []
  endif

"  call Dret("ShowFuncSetup")
endfun

" ---------------------------------------------------------------------
" StlShowFunc: {{{2
fun! StlShowFunc()
  if exists("s:stlshowfunc_{winnr()}")
   return s:stlshowfunc_{winnr()}
  endif
  return ""
endfun

" ---------------------------------------------------------------------
" StlSetFunc: assigns a funcname to a window {{{2
"             A funcname of "" clears the window-associated function name
fun! StlSetFunc(funcname)
"  call Dfunc("StlSetFunc(funcname<".a:funcname.">)")
  if a:funcname == ""
   " remove the funcname to window association
   if exists("s:stlshowfunc_{winnr()}")
   	unlet s:stlshowfunc_{winnr()}
   endif
  else
   " set up the window to function name association
   " also set up the status line option to show the function
   let s:stlshowfunc_{winnr()} = a:funcname
   let &l:stl                  = s:stlshowfunc_stlfunc
  endif
"  call Dret("StlSetFunc")
endfun

" =====================================================================
" Modelines: {{{1
" vim: fdm=marker
let &cpo= s:keepcpo
unlet s:keepcpo
plugin/cecutil.vim	[[[1
536
" cecutil.vim : save/restore window position
"               save/restore mark position
"               save/restore selected user maps
"  Author:	Charles E. Campbell, Jr.
"  Version:	18h	ASTRO-ONLY
"  Date:	Oct 16, 2012
"
"  Saving Restoring Destroying Marks: {{{1
"       call SaveMark(markname)       let savemark= SaveMark(markname)
"       call RestoreMark(markname)    call RestoreMark(savemark)
"       call DestroyMark(markname)
"       commands: SM RM DM
"
"  Saving Restoring Destroying Window Position: {{{1
"       call SaveWinPosn()        let winposn= SaveWinPosn()
"       call RestoreWinPosn()     call RestoreWinPosn(winposn)
"		\swp : save current window/buffer's position
"		\rwp : restore current window/buffer's previous position
"       commands: SWP RWP
"
"  Saving And Restoring User Maps: {{{1
"       call SaveUserMaps(mapmode,maplead,mapchx,suffix)
"       call RestoreUserMaps(suffix)
"
" GetLatestVimScripts: 1066 1 :AutoInstall: cecutil.vim
"
" You believe that God is one. You do well. The demons also {{{1
" believe, and shudder. But do you want to know, vain man, that
" faith apart from works is dead?  (James 2:19,20 WEB)
"redraw!|call inputsave()|call input("Press <cr> to continue")|call inputrestore()

" ---------------------------------------------------------------------
" Load Once: {{{1
if &cp || exists("g:loaded_cecutil")
 finish
endif
let g:loaded_cecutil = "v18h"
let s:keepcpo        = &cpo
set cpo&vim
"DechoRemOn

" =======================
"  Public Interface: {{{1
" =======================

" ---------------------------------------------------------------------
"  Map Interface: {{{2
if !hasmapto('<Plug>SaveWinPosn')
 map <unique> <Leader>swp <Plug>SaveWinPosn
endif
if !hasmapto('<Plug>RestoreWinPosn')
 map <unique> <Leader>rwp <Plug>RestoreWinPosn
endif
nmap <silent> <Plug>SaveWinPosn		:call SaveWinPosn()<CR>
nmap <silent> <Plug>RestoreWinPosn	:call RestoreWinPosn()<CR>

" ---------------------------------------------------------------------
" Command Interface: {{{2
com! -bar -nargs=0 SWP	call SaveWinPosn()
com! -bar -nargs=? RWP	call RestoreWinPosn(<args>)
com! -bar -nargs=1 SM	call SaveMark(<q-args>)
com! -bar -nargs=1 RM	call RestoreMark(<q-args>)
com! -bar -nargs=1 DM	call DestroyMark(<q-args>)

com! -bar -nargs=1 WLR	call s:WinLineRestore(<q-args>)

if v:version < 630
 let s:modifier= "sil! "
else
 let s:modifier= "sil! keepj "
endif

" ===============
" Functions: {{{1
" ===============

" ---------------------------------------------------------------------
" SaveWinPosn: {{{2
"    let winposn= SaveWinPosn()  will save window position in winposn variable
"    call SaveWinPosn()          will save window position in b:cecutil_winposn{b:cecutil_iwinposn}
"    let winposn= SaveWinPosn(0) will *only* save window position in winposn variable (no stacking done)
fun! SaveWinPosn(...)
"  echomsg "Decho: SaveWinPosn() a:0=".a:0
  if line("$") == 1 && getline(1) == ""
"   echomsg "Decho: SaveWinPosn : empty buffer"
   return ""
  endif
  let so_keep   = &l:so
  let siso_keep = &siso
  let ss_keep   = &l:ss
  setlocal so=0 siso=0 ss=0

  let swline = line(".")                           " save-window line in file
  let swcol  = col(".")                            " save-window column in file
  if swcol >= col("$")
   let swcol= swcol + virtcol(".") - virtcol("$")  " adjust for virtual edit (cursor past end-of-line)
  endif
  let swwline   = winline() - 1                    " save-window window line
  let swwcol    = virtcol(".") - wincol()          " save-window window column
  let savedposn = ""
"  echomsg "Decho: sw[".swline.",".swcol."] sww[".swwline.",".swwcol."]"
  let savedposn = "call GoWinbufnr(".winbufnr(0).")"
  let savedposn = savedposn."|".s:modifier.swline
  let savedposn = savedposn."|".s:modifier."norm! 0z\<cr>"
  if swwline > 0
   let savedposn= savedposn.":".s:modifier."call s:WinLineRestore(".(swwline+1).")\<cr>"
  endif
  if swwcol > 0
   let savedposn= savedposn.":".s:modifier."norm! 0".swwcol."zl\<cr>"
  endif
  let savedposn = savedposn.":".s:modifier."call cursor(".swline.",".swcol.")\<cr>"

  " save window position in
  " b:cecutil_winposn_{iwinposn} (stack)
  " only when SaveWinPosn() is used
  if a:0 == 0
   if !exists("b:cecutil_iwinposn")
	let b:cecutil_iwinposn= 1
   else
	let b:cecutil_iwinposn= b:cecutil_iwinposn + 1
   endif
"   echomsg "Decho: saving posn to SWP stack"
   let b:cecutil_winposn{b:cecutil_iwinposn}= savedposn
  endif

  let &l:so = so_keep
  let &siso = siso_keep
  let &l:ss = ss_keep

"  if exists("b:cecutil_iwinposn")                                                                  " Decho
"   echomsg "Decho: b:cecutil_winpos{".b:cecutil_iwinposn."}[".b:cecutil_winposn{b:cecutil_iwinposn}."]"
"  else                                                                                             " Decho
"   echomsg "Decho: b:cecutil_iwinposn doesn't exist"
"  endif                                                                                            " Decho
"  echomsg "Decho: SaveWinPosn [".savedposn."]"
  return savedposn
endfun

" ---------------------------------------------------------------------
" RestoreWinPosn: {{{2
"      call RestoreWinPosn()
"      call RestoreWinPosn(winposn)
fun! RestoreWinPosn(...)
"  echomsg "Decho: RestoreWinPosn() a:0=".a:0
"  echomsg "Decho: getline(1)<".getline(1).">"
"  echomsg "Decho: line(.)=".line(".")
  if line("$") == 1 && getline(1) == ""
"   echomsg "Decho: RestoreWinPosn : empty buffer"
   return ""
  endif
  let so_keep   = &l:so
  let siso_keep = &l:siso
  let ss_keep   = &l:ss
  setlocal so=0 siso=0 ss=0

  if a:0 == 0 || a:1 == ""
   " use saved window position in b:cecutil_winposn{b:cecutil_iwinposn} if it exists
   if exists("b:cecutil_iwinposn") && exists("b:cecutil_winposn{b:cecutil_iwinposn}")
"    echomsg "Decho: using stack b:cecutil_winposn{".b:cecutil_iwinposn."}<".b:cecutil_winposn{b:cecutil_iwinposn}.">"
	try
	 exe s:modifier.b:cecutil_winposn{b:cecutil_iwinposn}
	catch /^Vim\%((\a\+)\)\=:E749/
	 " ignore empty buffer error messages
	endtry
	" normally drop top-of-stack by one
	" but while new top-of-stack doesn't exist
	" drop top-of-stack index by one again
	if b:cecutil_iwinposn >= 1
	 unlet b:cecutil_winposn{b:cecutil_iwinposn}
	 let b:cecutil_iwinposn= b:cecutil_iwinposn - 1
	 while b:cecutil_iwinposn >= 1 && !exists("b:cecutil_winposn{b:cecutil_iwinposn}")
	  let b:cecutil_iwinposn= b:cecutil_iwinposn - 1
	 endwhile
	 if b:cecutil_iwinposn < 1
	  unlet b:cecutil_iwinposn
	 endif
	endif
   else
	echohl WarningMsg
	echomsg "***warning*** need to SaveWinPosn first!"
	echohl None
   endif

  else	 " handle input argument
"   echomsg "Decho: using input a:1<".a:1.">"
   " use window position passed to this function
   exe a:1
   " remove a:1 pattern from b:cecutil_winposn{b:cecutil_iwinposn} stack
   if exists("b:cecutil_iwinposn")
	let jwinposn= b:cecutil_iwinposn
	while jwinposn >= 1                     " search for a:1 in iwinposn..1
	 if exists("b:cecutil_winposn{jwinposn}")    " if it exists
	  if a:1 == b:cecutil_winposn{jwinposn}      " and the pattern matches
	   unlet b:cecutil_winposn{jwinposn}            " unlet it
	   if jwinposn == b:cecutil_iwinposn            " if at top-of-stack
		let b:cecutil_iwinposn= b:cecutil_iwinposn - 1      " drop stacktop by one
	   endif
	  endif
	 endif
	 let jwinposn= jwinposn - 1
	endwhile
   endif
  endif

  " Seems to be something odd: vertical motions after RWP
  " cause jump to first column.  The following fixes that.
  " Note: was using wincol()>1, but with signs, a cursor
  " at column 1 yields wincol()==3.  Beeping ensued.
  let vekeep= &ve
  set ve=all
  if virtcol('.') > 1
   exe s:modifier."norm! hl"
  elseif virtcol(".") < virtcol("$")
   exe s:modifier."norm! lh"
  endif
  let &ve= vekeep

  let &l:so   = so_keep
  let &l:siso = siso_keep
  let &l:ss   = ss_keep

"  echomsg "Decho: RestoreWinPosn"
endfun

" ---------------------------------------------------------------------
" s:WinLineRestore: {{{2
fun! s:WinLineRestore(swwline)
"  echomsg "Decho: s:WinLineRestore(swwline=".a:swwline.")"
  while winline() < a:swwline
   let curwinline= winline()
   exe s:modifier."norm! \<c-y>"
   if curwinline == winline()
	break
   endif
  endwhile
"  echomsg "Decho: s:WinLineRestore"
endfun

" ---------------------------------------------------------------------
" GoWinbufnr: go to window holding given buffer (by number) {{{2
"   Prefers current window; if its buffer number doesn't match,
"   then will try from topleft to bottom right
fun! GoWinbufnr(bufnum)
"  call Dfunc("GoWinbufnr(".a:bufnum.")")
  if winbufnr(0) == a:bufnum
"   call Dret("GoWinbufnr : winbufnr(0)==a:bufnum")
   return
  endif
  winc t
  let first=1
  while winbufnr(0) != a:bufnum && (first || winnr() != 1)
  	winc w
	let first= 0
   endwhile
"  call Dret("GoWinbufnr")
endfun

" ---------------------------------------------------------------------
" SaveMark: sets up a string saving a mark position. {{{2
"           For example, SaveMark("a")
"           Also sets up a global variable, g:savemark_{markname}
fun! SaveMark(markname)
"  call Dfunc("SaveMark(markname<".a:markname.">)")
  let markname= a:markname
  if strpart(markname,0,1) !~ '\a'
   let markname= strpart(markname,1,1)
  endif
"  call Decho("markname=".markname)

  let lzkeep  = &lz
  set lz

  if 1 <= line("'".markname) && line("'".markname) <= line("$")
   let winposn               = SaveWinPosn(0)
   exe s:modifier."norm! `".markname
   let savemark              = SaveWinPosn(0)
   let g:savemark_{markname} = savemark
   let savemark              = markname.savemark
   call RestoreWinPosn(winposn)
  else
   let g:savemark_{markname} = ""
   let savemark              = ""
  endif

  let &lz= lzkeep

"  call Dret("SaveMark : savemark<".savemark.">")
  return savemark
endfun

" ---------------------------------------------------------------------
" RestoreMark: {{{2
"   call RestoreMark("a")  -or- call RestoreMark(savemark)
fun! RestoreMark(markname)
"  call Dfunc("RestoreMark(markname<".a:markname.">)")

  if strlen(a:markname) <= 0
"   call Dret("RestoreMark : no such mark")
   return
  endif
  let markname= strpart(a:markname,0,1)
  if markname !~ '\a'
   " handles 'a -> a styles
   let markname= strpart(a:markname,1,1)
  endif
"  call Decho("markname=".markname." strlen(a:markname)=".strlen(a:markname))

  let lzkeep  = &lz
  set lz
  let winposn = SaveWinPosn(0)

  if strlen(a:markname) <= 2
   if exists("g:savemark_{markname}") && strlen(g:savemark_{markname}) != 0
	" use global variable g:savemark_{markname}
"	call Decho("use savemark list")
	call RestoreWinPosn(g:savemark_{markname})
	exe "norm! m".markname
   endif
  else
   " markname is a savemark command (string)
"	call Decho("use savemark command")
   let markcmd= strpart(a:markname,1)
   call RestoreWinPosn(markcmd)
   exe "norm! m".markname
  endif

  call RestoreWinPosn(winposn)
  let &lz       = lzkeep

"  call Dret("RestoreMark")
endfun

" ---------------------------------------------------------------------
" DestroyMark: {{{2
"   call DestroyMark("a")  -- destroys mark
fun! DestroyMark(markname)
"  call Dfunc("DestroyMark(markname<".a:markname.">)")

  " save options and set to standard values
  let reportkeep= &report
  let lzkeep    = &lz
  set lz report=10000

  let markname= strpart(a:markname,0,1)
  if markname !~ '\a'
   " handles 'a -> a styles
   let markname= strpart(a:markname,1,1)
  endif
"  call Decho("markname=".markname)

  let curmod  = &mod
  let winposn = SaveWinPosn(0)
  1
  let lineone = getline(".")
  exe "k".markname
  d
  put! =lineone
  let &mod    = curmod
  call RestoreWinPosn(winposn)

  " restore options to user settings
  let &report = reportkeep
  let &lz     = lzkeep

"  call Dret("DestroyMark")
endfun

" ---------------------------------------------------------------------
" QArgSplitter: to avoid \ processing by <f-args>, <q-args> is needed. {{{2
" However, <q-args> doesn't split at all, so this one returns a list
" with splits at all whitespace (only!), plus a leading length-of-list.
" The resulting list:  qarglist[0] corresponds to a:0
"                      qarglist[i] corresponds to a:{i}
fun! QArgSplitter(qarg)
"  call Dfunc("QArgSplitter(qarg<".a:qarg.">)")
  let qarglist    = split(a:qarg)
  let qarglistlen = len(qarglist)
  let qarglist    = insert(qarglist,qarglistlen)
"  call Dret("QArgSplitter ".string(qarglist))
  return qarglist
endfun

" ---------------------------------------------------------------------
" ListWinPosn: {{{2
"fun! ListWinPosn()                                                        " Decho 
"  if !exists("b:cecutil_iwinposn") || b:cecutil_iwinposn == 0             " Decho 
"   call Decho("nothing on SWP stack")                                     " Decho
"  else                                                                    " Decho
"   let jwinposn= b:cecutil_iwinposn                                       " Decho 
"   while jwinposn >= 1                                                    " Decho 
"    if exists("b:cecutil_winposn{jwinposn}")                              " Decho 
"     call Decho("winposn{".jwinposn."}<".b:cecutil_winposn{jwinposn}.">") " Decho 
"    else                                                                  " Decho 
"     call Decho("winposn{".jwinposn."} -- doesn't exist")                 " Decho 
"    endif                                                                 " Decho 
"    let jwinposn= jwinposn - 1                                            " Decho 
"   endwhile                                                               " Decho 
"  endif                                                                   " Decho
"endfun                                                                    " Decho 
"com! -nargs=0 LWP	call ListWinPosn()                                    " Decho 

" ---------------------------------------------------------------------
" SaveUserMaps: this function sets up a script-variable (s:restoremap) {{{2
"          which can be used to restore user maps later with
"          call RestoreUserMaps()
"
"          mapmode - see :help maparg for details (n v o i c l "")
"                    ex. "n" = Normal
"                    The letters "b" and "u" are optional prefixes;
"                    The "u" means that the map will also be unmapped
"                    The "b" means that the map has a <buffer> qualifier
"                    ex. "un"  = Normal + unmapping
"                    ex. "bn"  = Normal + <buffer>
"                    ex. "bun" = Normal + <buffer> + unmapping
"                    ex. "ubn" = Normal + <buffer> + unmapping
"          maplead - see mapchx
"          mapchx  - "<something>" handled as a single map item.
"                    ex. "<left>"
"                  - "string" a string of single letters which are actually
"                    multiple two-letter maps (using the maplead:
"                    maplead . each_character_in_string)
"                    ex. maplead="\" and mapchx="abc" saves user mappings for
"                        \a, \b, and \c
"                    Of course, if maplead is "", then for mapchx="abc",
"                    mappings for a, b, and c are saved.
"                  - :something  handled as a single map item, w/o the ":"
"                    ex.  mapchx= ":abc" will save a mapping for "abc"
"          suffix  - a string unique to your plugin
"                    ex.  suffix= "DrawIt"
fun! SaveUserMaps(mapmode,maplead,mapchx,suffix)
"  call Dfunc("SaveUserMaps(mapmode<".a:mapmode."> maplead<".a:maplead."> mapchx<".a:mapchx."> suffix<".a:suffix.">)")

  if !exists("s:restoremap_{a:suffix}")
   " initialize restoremap_suffix to null string
   let s:restoremap_{a:suffix}= ""
  endif

  " set up dounmap: if 1, then save and unmap  (a:mapmode leads with a "u")
  "                 if 0, save only
  let mapmode  = a:mapmode
  let dounmap  = 0
  let dobuffer = ""
  while mapmode =~ '^[bu]'
   if     mapmode =~ '^u'
    let dounmap = 1
    let mapmode = strpart(a:mapmode,1)
   elseif mapmode =~ '^b'
    let dobuffer = "<buffer> "
    let mapmode  = strpart(a:mapmode,1)
   endif
  endwhile
"  call Decho("dounmap=".dounmap."  dobuffer<".dobuffer.">")
 
  " save single map :...something...
  if strpart(a:mapchx,0,1) == ':'
"   call Decho("save single map :...something...")
   let amap= strpart(a:mapchx,1)
   if amap == "|" || amap == "\<c-v>"
    let amap= "\<c-v>".amap
   endif
   let amap                    = a:maplead.amap
   let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|:sil! ".mapmode."unmap ".dobuffer.amap
   if maparg(amap,mapmode) != ""
    let maprhs                  = substitute(maparg(amap,mapmode),'|','<bar>','ge')
	let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|:".mapmode."map ".dobuffer.amap." ".maprhs
   endif
   if dounmap
	exe "sil! ".mapmode."unmap ".dobuffer.amap
   endif
 
  " save single map <something>
  elseif strpart(a:mapchx,0,1) == '<'
"   call Decho("save single map <something>")
   let amap       = a:mapchx
   if amap == "|" || amap == "\<c-v>"
    let amap= "\<c-v>".amap
"	call Decho("amap[[".amap."]]")
   endif
   let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|sil! ".mapmode."unmap ".dobuffer.amap
   if maparg(a:mapchx,mapmode) != ""
    let maprhs                  = substitute(maparg(amap,mapmode),'|','<bar>','ge')
	let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|".mapmode."map ".dobuffer.amap." ".maprhs
   endif
   if dounmap
	exe "sil! ".mapmode."unmap ".dobuffer.amap
   endif
 
  " save multiple maps
  else
"   call Decho("save multiple maps")
   let i= 1
   while i <= strlen(a:mapchx)
    let amap= a:maplead.strpart(a:mapchx,i-1,1)
	if amap == "|" || amap == "\<c-v>"
	 let amap= "\<c-v>".amap
	endif
	let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|sil! ".mapmode."unmap ".dobuffer.amap
    if maparg(amap,mapmode) != ""
     let maprhs                  = substitute(maparg(amap,mapmode),'|','<bar>','ge')
	 let s:restoremap_{a:suffix} = s:restoremap_{a:suffix}."|".mapmode."map ".dobuffer.amap." ".maprhs
    endif
	if dounmap
	 exe "sil! ".mapmode."unmap ".dobuffer.amap
	endif
    let i= i + 1
   endwhile
  endif
"  call Dret("SaveUserMaps : restoremap_".a:suffix.": ".s:restoremap_{a:suffix})
endfun

" ---------------------------------------------------------------------
" RestoreUserMaps: {{{2
"   Used to restore user maps saved by SaveUserMaps()
fun! RestoreUserMaps(suffix)
"  call Dfunc("RestoreUserMaps(suffix<".a:suffix.">)")
  if exists("s:restoremap_{a:suffix}")
   let s:restoremap_{a:suffix}= substitute(s:restoremap_{a:suffix},'|\s*$','','e')
   if s:restoremap_{a:suffix} != ""
"   	call Decho("exe ".s:restoremap_{a:suffix})
    exe "sil! ".s:restoremap_{a:suffix}
   endif
   unlet s:restoremap_{a:suffix}
  endif
"  call Dret("RestoreUserMaps")
endfun

" ==============
"  Restore: {{{1
" ==============
let &cpo= s:keepcpo
unlet s:keepcpo

" ================
"  Modelines: {{{1
" ================
" vim: ts=4 fdm=marker
doc/StlShowFunc.txt	[[[1
177
*StlShowFunc.txt*	Showing Functions in the Status Line	Nov 02, 2012

Author:    Charles E. Campbell, Jr.  <NdrOchip@ScampbellPfamily.AbizM>
           (remove NOSPAM from Campbell's email first)

Copyright: (c) 2004-2012 by Charles E. Campbell, Jr.	*StlShowFunc-copyright*
           The VIM LICENSE applies to StlShowFunc.vim,
           ftplugin/c/StlShowFunc_c.vim, ftplugin/dbg/StlShowFunc_dbg.vim,
           ftplugin/matlab/StlShowFunc_m.vim, ftplugin/vim/StlShowFunc_vim.vim,
           (see |copyright|) except use "StlShowFunc and associated functions"
           instead of "Vim"
No warranty, express or implied.  Use At-Your-Own-Risk.

==============================================================================
1. Contents				*StlShowFunc* *StlShowFunc-contents*

    1. Contents.........................................: |StlShowFunc|
    2. StlShowFunc Manual...............................: |StlShowFunc-manual|
    3. StlShowFunc History..............................: |StlShowFunc-history|

==============================================================================
2. StlShowFunc Manual				*StlShowFunc-manual*

   The StlShowFunc plugin and associated filetype plugins manipulate the
   status line to show the name of the function that the cursor is in.  In
   addition, information on the filename, current line and column, and much
   else is also displayed.  Note that your current statusline option is
   overridden with this plugin, although you can restore it by typing >
   	:StlShowFunc!
<
   If you'd like to change the colorization, define highlighting groups User1,
   User2, and User3 as you wish.  The plugin sets up defaults for them: >

	hi User1 ctermfg=white ctermbg=blue guifg=white guibg=blue
	hi User2 ctermfg=cyan  ctermbg=blue guifg=cyan  guibg=blue
	hi User3 ctermfg=green ctermbg=blue guifg=green guibg=blue
<
   An example of the status line: >

 StlShowFunc.vim StlShowFunc() 73,1 Bot Win#1 156x21 Thu May 25, 2006, 01:00:57 PM

<  Currently, the cursor is in the StlShowFunc() in StlShowFunc.vim.

   The plugin uses the new (as of vim 7.0) CursorMoved event to trigger a check on
   whether or not the cursor has moved from one function to another.

COMMANDS

   StlShowFunc [lang]    : turn StlShowFunc on for the given language
                           At this time, currently supported languages
			   include:
                              cpp  matlab  c      perl
                              dbg  sh      maple  vim

   StlShowFunc!          : turn off StlShowFunc


HOW IT WORKS

   In short form: the StlShowFunc utility modifies the |'statusline'| option
   to call a function which returns a string based on window number.  It also
   sets up a CursorMoved event which, whenever the cursor is moved, checks to
   see if the enclosing function name has changed and, if it has, sets a
   script and window-associated variable to that function name.

   Here's an overview of StlShowFunc's components:

   plugin/StlShowFunc.vim:~

     * sets up a |CursorMoved| |autocommand| event so that, when the
       cursor is moved, a check is made to determine if the containing
       function has changed  (ShowFuncSetup())

     * StlSetFunc(), which assigns a function name to a window by changing
       the |'statusline'| option.  It clears the association if given a "".

     * StlShowFunc(), which maps the window number to the associated
       StlShowFunc_[language]() function.

   ftplugin/[lang]/StlShowFunc_[lang].vim~

     * Provides the function StlShowFunc_[lang](), which determines what
       function the cursor is currently in and calls StlSetFunc(funcname)
       when that function name changes and calls StlSetFunc("") when the
       cursor is not currently inside a function).

     * Invokes  StlShowFunc "[lang]"  to initialize the StlShowFunc system
       for that window and language.

   Here's a more detailed sequence of events involved in the function name
   update:

     * Initially, for supported languages, the ftplugin handler for the language
       invokes StlShowFunc "[lang]", which calls s:ShowFuncSetup().

     * This function then installs a CursorMoved autocommand event, so that when
       the cursor is moved, StlShowFunc_[lang]() is called.  It also calls
       that handler to initialize a variable holding the name of the function
       (if any) that the cursor is in.

     * StlFuncSetup() then sets up the status line option (|'stl'|) to call
       StlShowFunc() (as well as to show other items on the status line).

     * When the cursor is moved, the |CursorMoved| event is triggered.  This
       event thus invokes StlShowFunc_[lang]()

     * StlShowFunc_[lang]() determines what the name of the function that the
       cursor currently resides in is called.  It calls StlSetFunc(funcname).

     * StlSetFunc(funcname) sets a script variable, s:stlshowfunc_{winnr()},
       to that function name.  These variables are window-oriented, so one
       may have multiple windows opened on the same file, each with their
       own function name associated with their own cursor position.

     * The |'statusline'| option also triggers a refresh of the status line.
       The |'statusline'| option as set by StlFuncSetup() calls StlShowFunc()
       as part of the status line refresh.

     * The StlShowFunc() returns the string in s:stlshowfunc_{winnr()}.

OPTIONS

							*g:stlshowfunc_stlnofunc*
     This option lets users override the status line normally given by
     the StlShowFunc plugin with their own preferences.

     Use ":let" to set the following variable which will specify the statusline
     when the cursor is not inside a function: >

	stlshowfunc_stlnofunc
<

							*g:stlshowfunc_stlfunc*
     This option lets users override the status line normally given by
     the StlShowFunc plugin with their own preferences.

     Use ":let" to set the following variable which will specify the statusline
     when the cursor is inside a function: >

	stlshowfunc_stlfunc

<    Note that including >
	%{StlShowFunc()}
<    will result in the status line showing the current function name.
     The first variable (stlshowfunc_stlfunc) is used when StlShowFunc is
     disabled; the second variable is used when StlShowFunc is enabled.

     By default, >
	let stlshowfunc_stlnofunc=
	\ '%1*%f%2*\ %{&kmp\ }%h%m%r%0*%=%-14.(%l,%c%V%)%<\ %P\ Win#%{winnr()}\
	\ %{winwidth(0)}x%{winheight(0)}\ %<%{strftime(\"%a\ %b\ %d,\ %Y,\ %I:%M:%S\ \%p\")}'
	let stlshowfunc_stlfunc =
	\ '%1*%f %3*%{StlShowFunc()}%2* %h%m%r%0* %= %-14.(%l,%c%V%)%< %P Win#%{winnr()}
	\ %{winwidth(0)}x%{winheight(0)} %<%{strftime("%a %b %d, %Y, %I:%M:%S %p")}'

==============================================================================
3. StlShowFunc History				*StlShowFunc-history* {{{1
   v2	Jun 07, 2006  * modified ftplugin/StlShowFunc*.vim files to only update
			the statusline when vim is in normal mode.
	Sep 03, 2008  * stl now set in plugin/StlShowFunc.c
		      * "hi def" now used instead of HLTest().
	May 20, 2009  * cecutil bug fix
	Jun 15, 2009  * made all references to the statusline setting local
	Aug 13, 2009  * StlShowFunc! stopped working somewhere along the line
			(the StlShowFunc command was requiring an argument,
			and obviously :StlShowFunc! doesn't have an argument)
	Jul 09, 2010  * c++ files now avoid loading c/StlShowFunc_c.vim
	              * a test in cpp/StlShowFunc_cpp.vim no longer matches
			things like "if" when embedded in a function name
			when deciding if the function name is a real function.
	Feb 07, 2011  * included support for fortran
	Sep 24, 2012  * included |stlshowfunc_stl| option
   v1	May 25, 2006 * initial release

==============================================================================
4. Modelines: {{{1
vim:tw=78:ts=8:ft=help:fdm=marker:
ftplugin/cpp/StlShowFunc_cpp.vim	[[[1
71
" StlShowFunc_cpp.vim :	a ftplugin for C++
" Author:	Charles E. Campbell, Jr.
" Date:		Sep 09, 2010
" Version:  2k	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_cpp") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_cpp= "v2k"

" ---------------------------------------------------------------------
" StlShowFunc_cpp: show function name associated with the line under the cursor {{{1
"DechoTabOn
fun! StlShowFunc_cpp()
"  call Dfunc("StlShowFunc_cpp() line#".line(".")." mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_cpp")
   return
  endif
  if !exists("b:cshowfunc_bgn")
   let b:cshowfunc_bgn= -2
   let b:cshowfunc_end= -2
  endif
"  call Decho("b:cshowfunc_bgn=".b:cshowfunc_bgn." b:cshowfunc_end=".b:cshowfunc_end)

  keepj let swp= SaveWinPosn(0)
  while 1
   keepj let spline= searchpair(')\_s*\%(const\_s*\|volatile\_s*\|/\*.*\*/\_s*\|//.*\_s*\)\{,2}{','','}','bW')
"   call Decho("spline=".spline)
   if spline <= 0
	call StlSetFunc("")
   	break
   endif
   if synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") == "Comment"
	if line(".") == 1
"	 call Decho("case comment in line#1:")
     call StlSetFunc("")
   	 break
	endif
	keepj norm! 0k
	continue
   endif
"   call Decho("after searchpair: line#".line(".").".".col(".")." spline=".spline)
   silent! keepj norm! %b
"   call Decho("after %b        : line#".line(".").".".col(".")." potential-funcname<".expand("<cword>").">")
   if expand("<cword>") !~ '\<\%(if\|for\|try\|catch\|while\|switch\|else\|do\)\>'
	let funcname= expand("<cword>")
"	call Decho("funcname<".funcname.">")
	call StlSetFunc(funcname."()")
	break
   endif
  endwhile
"  call Decho("swp<".swp.">")
  keepjumps call RestoreWinPosn(swp)

  " set the status line and return
"  call Dret("StlShowFunc_cpp : line#".line(".")." col#".col('.'))
endfun

" ---------------------------------------------------------------------
"  Enable FtPlugin: {{{1
if has("fname_case")
 StlShowFunc cpp *.cpp,*.cc,*.c++,*.dxx,*.tcc,*.inl,*.C,*.H,*.hh
else
 StlShowFunc cpp *.cpp,*.cc,*.c++,*.dxx,*.tcc,*.inl,*.hh
endif

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
ftplugin/c/StlShowFunc_c.vim	[[[1
76
" StlShowFunc_c.vim :	a ftplugin for C
" Author:	Charles E. Campbell, Jr.
" Date:		Nov 30, 2011
" Version:  2f	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_c") || !exists("g:loaded_StlShowFunc") || &ft == "cpp"
 finish
endif
let b:loaded_StlShowFunc_c= "v2f"

" ---------------------------------------------------------------------
" StlShowFunc_c: show function name associated with the line under the cursor {{{1
"DechoTabOn
fun! StlShowFunc_c()
"  call Dfunc("StlShowFunc_c() line#".line(".")." mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_c")
   return
  endif
  if !exists("b:cshowfunc_bgn")
   let b:cshowfunc_bgn= -2
   let b:cshowfunc_end= -2
  endif

  keepjumps let bgnfuncline = search('^{\s*\(//.*$\|\/\*.*$\)\=','Wbn')
  keepjumps let endfuncline = search('^}\s*$','Wn')
  if getline(".") =~ '^{$'
   let bgnfuncline= line(".")
  endif
  if getline(".") =~ '^}$'
   let endfuncline= line(".")
  endif
"  call Decho("previous bgn,end[".b:cshowfunc_bgn.",".b:cshowfunc_end."]")
"  call Decho("current  bgn,end[".bgnfuncline.",".endfuncline."]")

  if bgnfuncline == b:cshowfunc_bgn && endfuncline == b:cshowfunc_end
   " looks like we're in the same region -- no change
"   call Dret("StlShowFunc_c : no change")
   return
  endif

  let b:cshowfunc_bgn= bgnfuncline
  let b:cshowfunc_end= endfuncline
  keepjumps let endprvfuncline = search('^}$','Wbn')
"  call Decho("endprvfuncline=".endprvfuncline)

  if bgnfuncline < endprvfuncline || (endprvfuncline == 0 && bgnfuncline == 0)
   call StlSetFunc("")
  else
   keepjumps let swp= SaveWinPosn(0)
   exe "keepjumps ".bgnfuncline
   keepjumps let argend = search(')','Wb')
   if argend > 0 && argend > endprvfuncline
   	keepjumps norm! %
	keepjumps let hw= search('\<\h\w*','Wb')
	if hw > 0
	 let funcname= expand("<cword>")
"	 call Decho("funcname<".funcname.">")
	 call StlSetFunc(funcname."()")
	endif
   endif
   call RestoreWinPosn(swp)
  endif

  " set the status line and return
"  call Dret("StlShowFunc_c")
endfun

" ---------------------------------------------------------------------
"  Enable FtPlugin: {{{1
StlShowFunc c

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
ftplugin/dbg/StlShowFunc_dbg.vim	[[[1
64
" StlShowFunc_dbg.vim :	a ftplugin for DrChip's internal debugger files
" Author:	Charles E. Campbell, Jr.
" Date:		Apr 03, 2010
" Version:  2g	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_dbg") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_dbg= "v2g"

" ---------------------------------------------------------------------
" StlShowFunc_dbg: show function name associated with line under cursor {{{1
fun! StlShowFunc_dbg()
"  call Dfunc("StlShowFunc_dbg() mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_dbg")
   return
  endif

  " initialization:
  if !exists("b:dbgshowfunc_funcline")
   let b:dbgshowfunc_funcline= -2
   let s:funcname            = ""
  endif

  " determine searchpairpos for {}
  let stopline= line(".") - 500
  if stopline <= 0 | let stopline= 1 | endif
  sil! keepj let [funcline,funccol] = searchpairpos('{$','','}\%(\~\d\+\)\=$','Wbn','',stopline)
"  call Decho("funcline=".funcline." funccol=".funccol." b:dbgshowfunc_funcline=".b:dbgshowfunc_funcline." stopline=".stopline." curline=".line("."))

  if funcline == 0 || funccol == 0
   " occurs when searchpairpos() fails
   let b:dbgshowfunc_funcline= -2
   call StlSetFunc("")
"   call Dret("StlShowFunc_dbg : b:dbgshowfunc_funcline=".b:dbgshowfunc_funcline)
   return
  endif

  if funcline != b:dbgshowfunc_funcline
   let b:dbgshowfunc_funcline= funcline
   let funcname              = substitute(getline(funcline),'^|*\(\h\w*\)(.*$','\1','e')
"   call Decho("funcname<".funcname."> s:funcname<".s:funcname.">")
   if !exists("s:funcname") || funcname != s:funcname
	let s:funcname= funcname
	call StlSetFunc(funcname."()")
   endif
  else
   let s:funcname= ""
  endif
"  call Dret("StlShowFunc_dbg : b:dbgshowfunc_funcline=".b:dbgshowfunc_funcline)
endfun

" ---------------------------------------------------------------------
"  Enable FtPlugin: {{{1
StlShowFunc dbg
augroup STLSHOWFUNC
 au CursorMoved tmp* call StlShowFunc_dbg()
augroup END

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
ftplugin/maple/StlShowFunc_mv.vim	[[[1
85
" StlShowFunc_mv.vim :	a ftplugin for Maple V files
" Author:	Charles E. Campbell, Jr.
" Date:		Apr 03, 2010
" Version:  2e	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_mv") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_mv= "v2e"

" ---------------------------------------------------------------------
" StlShowFunc_mv: show function name associated with the line under the cursor {{{1
"DechoTabOn
fun! StlShowFunc_mv()
"  call Dfunc("StlShowFunc_mv() line#".line(".")." mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_mv")
   return
  endif
  if !exists("b:mvshowfunc_bgn")
   let b:mvshowfunc_bgn= -2
   let b:mvshowfunc_end= -2
  endif

  if getline(".") =~ ':=\s*proc\s*('
   let bgnfuncline= line(".")
  else
   sil! keepj let bgnfuncline = search(':=\s*proc\s*(','Wbn')
   if bgnfuncline == 0
   	let endfuncline= 0
   endif
  endif
  if bgnfuncline != 0
   if getline(".") =~ '^\s*end:\=\s*$'
    let endfuncline= line(".")
   else
	sil! keepj let endfuncline = search('^\s*end:\=\s*$','Wbn')
	if endfuncline < line(".") && endfuncline > bgnfuncline
	 let bgnfuncline= 0
	 let endfuncline= 0
	else
	 sil! keepj let endfuncline = search('^\s*end:\=\s*$','Wn')
	endif
   endif
  endif
"  call Decho("previous bgn,end[".b:mvshowfunc_bgn.",".b:mvshowfunc_end."]")
"  call Decho("current  bgn,end[".bgnfuncline.",".endfuncline."]")

  if bgnfuncline == b:mvshowfunc_bgn && endfuncline == b:mvshowfunc_end
   " looks like we're in the same region -- no change
"   call Dret("StlShowFunc_mv : no change")
   return
  endif

  let b:mvshowfunc_bgn     = bgnfuncline
  let b:mvshowfunc_end     = endfuncline
  keepj let endprvfuncline = search('^\s*endf\%[unction]\>','Wbn')
"  call Decho("endprvfuncline=".endprvfuncline)

  if bgnfuncline < endprvfuncline || (endprvfuncline == 0 && bgnfuncline == 0)
   call StlSetFunc("")
  else
   " extract the function name from the bgnfuncline
   let funcline= getline(bgnfuncline)
   if funcline =~ '^.\{-}:=\s*proc\s*('
   	let funcname= substitute(funcline,'^\s*\(\h\w*\)\s*:=\s*proc\s*(.*$','\1','')
"   call Decho("funcname<".funcname.">")
    call StlSetFunc(funcname."()")
   else
    call StlSetFunc("")
   endif
  endif

  " set the status line and return
"  call Dret("StlShowFunc_mv")
endfun

" ---------------------------------------------------------------------
"  Plugin Enabling: {{{1
StlShowFunc mv

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
ftplugin/maple/StlShowFunc_mv.vim	[[[1
85
" StlShowFunc_mv.vim :	a ftplugin for Maple V files
" Author:	Charles E. Campbell, Jr.
" Date:		Apr 03, 2010
" Version:  2e	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_mv") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_mv= "v2e"

" ---------------------------------------------------------------------
" StlShowFunc_mv: show function name associated with the line under the cursor {{{1
"DechoTabOn
fun! StlShowFunc_mv()
"  call Dfunc("StlShowFunc_mv() line#".line(".")." mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_mv")
   return
  endif
  if !exists("b:mvshowfunc_bgn")
   let b:mvshowfunc_bgn= -2
   let b:mvshowfunc_end= -2
  endif

  if getline(".") =~ ':=\s*proc\s*('
   let bgnfuncline= line(".")
  else
   sil! keepj let bgnfuncline = search(':=\s*proc\s*(','Wbn')
   if bgnfuncline == 0
   	let endfuncline= 0
   endif
  endif
  if bgnfuncline != 0
   if getline(".") =~ '^\s*end:\=\s*$'
    let endfuncline= line(".")
   else
	sil! keepj let endfuncline = search('^\s*end:\=\s*$','Wbn')
	if endfuncline < line(".") && endfuncline > bgnfuncline
	 let bgnfuncline= 0
	 let endfuncline= 0
	else
	 sil! keepj let endfuncline = search('^\s*end:\=\s*$','Wn')
	endif
   endif
  endif
"  call Decho("previous bgn,end[".b:mvshowfunc_bgn.",".b:mvshowfunc_end."]")
"  call Decho("current  bgn,end[".bgnfuncline.",".endfuncline."]")

  if bgnfuncline == b:mvshowfunc_bgn && endfuncline == b:mvshowfunc_end
   " looks like we're in the same region -- no change
"   call Dret("StlShowFunc_mv : no change")
   return
  endif

  let b:mvshowfunc_bgn     = bgnfuncline
  let b:mvshowfunc_end     = endfuncline
  keepj let endprvfuncline = search('^\s*endf\%[unction]\>','Wbn')
"  call Decho("endprvfuncline=".endprvfuncline)

  if bgnfuncline < endprvfuncline || (endprvfuncline == 0 && bgnfuncline == 0)
   call StlSetFunc("")
  else
   " extract the function name from the bgnfuncline
   let funcline= getline(bgnfuncline)
   if funcline =~ '^.\{-}:=\s*proc\s*('
   	let funcname= substitute(funcline,'^\s*\(\h\w*\)\s*:=\s*proc\s*(.*$','\1','')
"   call Decho("funcname<".funcname.">")
    call StlSetFunc(funcname."()")
   else
    call StlSetFunc("")
   endif
  endif

  " set the status line and return
"  call Dret("StlShowFunc_mv")
endfun

" ---------------------------------------------------------------------
"  Plugin Enabling: {{{1
StlShowFunc mv

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
ftplugin/matlab/StlShowFunc_m.vim	[[[1
73
" StlShowFunc_m.vim :	an ftplugin for matlab
" Author:	Charles E. Campbell, Jr.
" Date:		Apr 03, 2010
" Version:  2d	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_m") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_m= "v2d"

" ---------------------------------------------------------------------
" StlShowFunc_m: show function name associated with the line under the cursor {{{1
"DechoTabOn
fun! StlShowFunc_m()
"  call Dfunc("StlShowFunc_m() line#".line(".")." mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_m")
   return
  endif
  if !exists("b:mshowfunc_bgn")
   let b:mshowfunc_bgn= -2
   let b:mshowfunc_end= -2
  endif

  sil! keepj let bgnfuncline = search('^\s*function\>','Wbn')
  sil! keepj let endfuncline = search('^\s*\%(end\)\=function\>','Wn')
  if getline(".") =~ '^\s*function\>'
   let bgnfuncline= line(".")
   let endfuncline= bgnfuncline
  endif
  if getline(".") =~ '^\s*endfunction\>'
   let endfuncline= line(".")
  endif
"  call Decho("previous bgn,end[".b:mshowfunc_bgn.",".b:mshowfunc_end."]")
"  call Decho("current  bgn,end[".bgnfuncline.",".endfuncline."]")

  if bgnfuncline == b:mshowfunc_bgn && endfuncline == b:mshowfunc_end
   " looks like we're in the same region -- no change
"   call Dret("StlShowFunc_m : no change")
   return
  endif

  let            b:mshowfunc_bgn = bgnfuncline
  let            b:mshowfunc_end = endfuncline
  sil! keepj let endprvfuncline  = search('^\s*endfunction\>','Wbn')
"  call Decho("endprvfuncline=".endprvfuncline)

  if bgnfuncline < endprvfuncline || (endprvfuncline == 0 && bgnfuncline == 0)
   call StlSetFunc("")
  else
   " extract the function name from the bgnfuncline
   let funcline= getline(bgnfuncline)
   if funcline =~ '^\s*function\s\+\%(.\{-}=\s*\)\=\h\w*\s*('
    let funcname= substitute(funcline,'^\s*function\s\+\%(.\{-}=\s*\)\=\(\h\w*\)\s*(.*$','\1','')
"   call Decho("funcname<".funcname.">")
    call StlSetFunc(funcname."()")
   else
    call StlSetFunc("")
   endif
  endif

  " set the status line and return
"  call Dret("StlShowFunc_m")
endfun

" ---------------------------------------------------------------------
"  Plugin Enabling: {{{1
StlShowFunc m

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
ftplugin/perl/StlShowFunc_pm.vim	[[[1
78
" StlShowFunc_pm.vim :	a ftplugin for Perl
" Author:	Charles E. Campbell, Jr.
" Date:		Apr 03, 2010
" Version:  2e	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_pm") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_pm= "v2e"

" ---------------------------------------------------------------------
" StlShowFunc_pm: show function name associated with the line under the cursor {{{1
"DechoTabOn
fun! StlShowFunc_pm()
"  call Dfunc("StlShowFunc_pm() line#".line(".")." mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_pm")
   return
  endif
  if !exists("b:perlshowfunc_bgn")
   let b:perlshowfunc_bgn= -2
   let b:perlshowfunc_end= -2
  endif

  if getline(".") =~ '^\s*sub\s'
   let bgnfuncline= line(".")
   if bgnfuncline != 0 && getline(bgnfuncline) =~ '^\s*sub\s\+\h\w*\s*{}\s*$'
    let endfuncline= line(".")
   else
	sil! keepj let endfuncline = search('^\s*}\s*$','Wn')
   endif
  elseif getline(".") =~ '^\s*}\s*$'
   sil! keepj let bgnfuncline = search('^\s*sub\s\+\h\w*\s*[({]','Wbn')
   let            endfuncline = line(".")
  else
   sil! keepj let bgnfuncline = search('^\s*sub\s\+\h\w*\s*[({]','Wbn')
   sil! keepj let endfuncline = search('^\s*}\s*$','Wn')
   if bgnfuncline != 0 && getline(bgnfuncline) =~ '^\s*sub\s\+\h\w*\s*{}\s*$'
   	let endfuncline= bgnfuncline
   endif
  endif
"  call Decho("previous bgn,end[".b:perlshowfunc_bgn.",".b:perlshowfunc_end."]")
"  call Decho("current  bgn,end[".bgnfuncline.",".endfuncline."]")

  if bgnfuncline == b:perlshowfunc_bgn && endfuncline == b:perlshowfunc_end
   " looks like we're in the same region -- no change
"   call Dret("StlShowFunc_pm : no change")
   return
  endif

  let        b:perlshowfunc_bgn = bgnfuncline
  let        b:perlshowfunc_end = endfuncline
  sil! keepj let endprvfuncline = search('^}$','Wbn')
"  call Decho("endprvfuncline=".endprvfuncline)

  if bgnfuncline < endprvfuncline || (endprvfuncline == 0 && bgnfuncline == 0)
   call StlSetFunc("")
  else
   let funcline= getline(bgnfuncline)
   if funcline =~ '^\s*sub\s*\h\w*'
   	let funcname= substitute(funcline,'^\s*sub\s*\(\h\w*\).\{-}$','\1','')
"    call Decho("funcname<".funcname.">")
    call StlSetFunc(funcname."()")
   endif
  endif

  " set the status line and return
"  call Dret("StlShowFunc_pm")
endfun

" ---------------------------------------------------------------------
"  Enable FtPlugin: {{{1
StlShowFunc pm

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
ftplugin/sh/StlShowFunc_sh.vim	[[[1
99
" StlShowFunc_sh.vim :	a ftplugin for Borne shell, Korn/Posix shell, and Bash
" Author:	Charles E. Campbell, Jr.
" Date:		Apr 03, 2010
" Version:  2f	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Enable Plugin For All Sh FileTypes: {{{1
if &diff
 finish
endif
augroup STLSHOWFUNC_SH
 au!
 exe "au CursorMoved ".expand("%")." call StlShowFunc_sh()"
augroup END
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_sh") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_sh= "v2f"

" ---------------------------------------------------------------------
" StlShowFunc_sh: show function name associated with the line under the cursor {{{1
"DechoTabOn
fun! StlShowFunc_sh()
"  call Dfunc("StlShowFunc_sh() line#".line(".")." mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_sh")
   return
  endif

  if !exists("b:shshowfunc_bgn")
   let b:shshowfunc_bgn= -2
   let b:shshowfunc_end= -2
  endif

  let curlinenum = line(".")
  let swp        = SaveWinPosn(0)
  if getline(".") =~ '^\s*function\>'
   let bgnfuncline = line(".")
  else
   sil! keepj let bgnfuncline= search('^\s*function\>','bW')
  endif
"  call Decho("preliminary bgnfuncline=".bgnfuncline)
  if bgnfuncline > 0
   sil! keepj let shfuncstart= search('^\s*{','W')
   if shfuncstart != 0
	sil! keepj let endfuncline= searchpair('{','','}',"Wn")
	if endfuncline <= 0
	 let bgnfuncline= 0
	endif
   else
    let bgnfuncline = 0
    let endfuncline = 0
   endif
  else
   let bgnfuncline= 0
   let endfuncline= 0
  endif
  if curlinenum < bgnfuncline || endfuncline < curlinenum
   let bgnfuncline= 0
   let endfuncline= 0
  endif
  call RestoreWinPosn(swp)
"  call Decho("previous bgn,end[".b:shshowfunc_bgn.",".b:shshowfunc_end."]")
"  call Decho("current  bgn,end[".bgnfuncline.",".endfuncline."]")

  if bgnfuncline == b:shshowfunc_bgn && endfuncline == b:shshowfunc_end
   " looks like we're in the same region -- no change
"   call Dret("StlShowFunc_sh : no change")
   return
  endif

  let b:shshowfunc_bgn = bgnfuncline
  let b:shshowfunc_end = endfuncline
  let endprvfuncline     = search('^}$','Wbn')
"  call Decho("endprvfuncline=".endprvfuncline)

  if bgnfuncline < endprvfuncline || (endprvfuncline == 0 && bgnfuncline == 0)
   call StlSetFunc("")
  else
   let funcline= getline(bgnfuncline)
   if funcline =~ '^\s*function\s*\h\w*'
   	let funcname= substitute(funcline,'^\s*function\s*\(\h\w*\).\{-}$','\1','')
"    call Decho("funcname<".funcname.">")
    call StlSetFunc(funcname."()")
   endif
  endif

  " set the status line and return
"  call Dret("StlShowFunc_sh")
endfun

" ---------------------------------------------------------------------
"  Enable FtPlugin: {{{1
StlShowFunc sh

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
ftplugin/tex/StlShowFunc_tex.vim	[[[1
74
" StlShowFunc_tex.vim :	an ftplugin for LaTeX
" Author:	Charles E. Campbell, Jr.
" Date:		Apr 03, 2010
" Version:  1a	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_m") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_tex= "v1a"

" ---------------------------------------------------------------------
" StlShowFunc_m: show function name associated with the line under the cursor {{{1
"DechoTabOn
fun! StlShowFunc_tex()
"  call Dfunc("StlShowFunc_tex() line#".line(".")." mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_tex")
   return
  endif
  if !exists("b:mshowfunc_bgn")
   let b:mshowfunc_bgn= -2
   let b:mshowfunc_end= -2
  endif

  sil! keepj let bgnfuncline = search('\\\%(part\|chapter\|section\|subsubsection\|subsection\)\>','Wbn')
  sil! keepj let endfuncline = search('\\\%(part\|chapter\|section\|subsubsection\|subsection\)\>','Wn')
  if getline(".") =~ '^\s*function\>'
   let bgnfuncline= line(".")
   let endfuncline= bgnfuncline
  endif
  if getline(".") =~ '^\s*endfunction\>'
   let endfuncline= line(".")
  endif
"  call Decho("previous bgn,end[".b:mshowfunc_bgn.",".b:mshowfunc_end."]")
"  call Decho("current  bgn,end[".bgnfuncline.",".endfuncline."]")

  if bgnfuncline == b:mshowfunc_bgn && endfuncline == b:mshowfunc_end
   " looks like we're in the same region -- no change
"   call Dret("StlShowFunc_tex : no change")
   return
  endif

  let            b:mshowfunc_bgn = bgnfuncline
  let            b:mshowfunc_end = endfuncline
  sil! keepj let endprvfuncline  = search('\\\%(part\|chapter\|section\|subsubsection\|subsection\)\>','Wbn')
"  call Decho("endprvfuncline=".endprvfuncline)

  if bgnfuncline < endprvfuncline || (endprvfuncline == 0 && bgnfuncline == 0)
   call StlSetFunc("")
  else
   " extract the section/title name from the bgnfuncline
   let title_line= getline(bgnfuncline)
"   call Decho("title_line<".title_line.">")
   if title_line =~ '\\\%(part\|chapter\|section\|subsubsection\|subsection\)\s*{'
	let title= substitute(title_line,'^.*\\\%(part\|chapter\|section\|subsubsection\|subsection\)\s*{\([^}]\+\)}.*$','\1','')
"    call Decho("title<".title.">")
    call StlSetFunc(title)
   else
    call StlSetFunc("")
   endif
  endif

  " set the status line and return
"  call Dret("StlShowFunc_tex")
endfun

" ---------------------------------------------------------------------
"  Plugin Enabling: {{{1
StlShowFunc tex

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
ftplugin/vim/StlShowFunc_vim.vim	[[[1
78
" StlShowFunc_vim.vim :	a ftplugin for  vim
" Author:	Charles E. Campbell, Jr.
" Date:		Apr 03, 2010
" Version:  2e	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_vim") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_vim= "v2e"

" ---------------------------------------------------------------------
" StlShowFunc_vim: show function name associated with the line under the cursor {{{1
"DechoTabOn
fun! StlShowFunc_vim()
"  call Dfunc("StlShowFunc_vim() line#".line(".")." mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_vim")
   return
  endif
  if !exists("b:vimshowfunc_bgn")
   let b:vimshowfunc_bgn= -2
   let b:vimshowfunc_end= -2
"   call Decho("init b:vimshowfunc_bgn and b:vimshowfunc_end")
  endif

  sil! keepj let bgnfuncline = search('^\s*fu\%[nction]\>','Wbn')
  sil! keepj let endfuncline = search('^\s*endf\%[unction]\>','Wn')
  if getline(".") =~ '^\s*fu\%[nction]\>'
   let bgnfuncline= line(".")
  endif
  if getline(".") =~ '^\s*endf\%[unction]\>'
   let endfuncline= line(".")
  endif
"  call Decho("previous bgn,end[".b:vimshowfunc_bgn.",".b:vimshowfunc_end."]")
"  call Decho("current  bgn,end[".bgnfuncline.",".endfuncline."]")
"  call Decho((bgnfuncline == b:vimshowfunc_bgn)? "[bgnfuncline".bgnfuncline."] == [b:vimshowfunc_bgn=".b:vimshowfunc_bgn."]" : "[bgnfuncline=".bgnfuncline."] != [b:vimshowfunc_bgn=".b:vimshowfunc_bgn."]")
"  call Decho((endfuncline == b:vimshowfunc_end)? "[endfuncline".endfuncline."] == [b:vimshowfunc_end=".b:vimshowfunc_end."]" : "[endfuncline=".endfuncline."] != [b:vimshowfunc_end=".b:vimshowfunc_end."]")

  if bgnfuncline == b:vimshowfunc_bgn && endfuncline == b:vimshowfunc_end
   " looks like we're in the same region -- no change
"   call Dret("StlShowFunc_vim : no change")
   return
  endif

  let            b:vimshowfunc_bgn= bgnfuncline
  let            b:vimshowfunc_end= endfuncline
  sil! keepj let endprvfuncline   = search('^\s*endf\%[unction]\>','Wbn')
"  call Decho("[bgnfuncline=".bgnfuncline."]".((bgnfuncline < endprvfuncline)? "<" : "≮")."[endprvfuncline=".endprvfuncline."]")

  if bgnfuncline < endprvfuncline || (endprvfuncline == 0 && bgnfuncline == 0)
"   call Decho('calling StlSetFunc("") (case 1)')
   call StlSetFunc("")
  else
   " extract the function name from the bgnfuncline
   let funcline= getline(bgnfuncline)
"   call Decho("extract function name from bgnfuncline#".bgnfuncline."<".funcline.">")
   if funcline =~ '^\s*fu\%[nction]!\=\s\+\(\%([sS]:\|<[sS][iI][dD]>\)\=\h[a-zA-Z0-9_#]*\).\{-}$'
    let funcname= substitute(funcline,'^\s*fu\%[nction]!\=\s\+\(\%([sS]:\|<[sS][iI][dD]>\)\=\h[a-zA-Z0-9_#]*\).\{-}$','\1','')
"	call Decho('calling StlSetFunc('.funcname.'()')
    call StlSetFunc(funcname."()")
   else
"    call Decho('calling StlSetFunc("") (case 2)')
    call StlSetFunc("")
   endif
  endif

  " set the status line and return
"  call Dret("StlShowFunc_vim")
endfun

" ---------------------------------------------------------------------
"  Plugin Enabling: {{{1
StlShowFunc vim

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
