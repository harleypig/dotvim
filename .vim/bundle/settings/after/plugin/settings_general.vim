" Why do I include settings that are defaults?
" Because I don't want to get surprised by changes.

" !!! See what you can rip off from vim-sensible!
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim

" Sort this section by doing the following (it will ignore the 'set no' or
" 'set   ' and sort by keywords :

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,6)cmp substr$b,6}@a'

set   autoread
set nocursorline
set   expandtab
set nohidden
"set   list " This overrides SpaceHi, so don't set it.
set   number
set   showcmd
set   showmatch
set   terse
set   title
set   wildmenu
"set   spell

" <range>!perl -ne 'push@a,$_}{print$_ for sort{substr($a,4)cmp substr$b,4}@a'

set   background=dark
set   backupdir=/tmp,~/tmp
set   clipboard+=unnamed
set   directory=/tmp,~/tmp
set   encoding=utf-8
set   history=1000
"set   listchars=
set   matchpairs+=<:>
set   mouse=
set   numberwidth=5
set   pastetoggle=<Leader>paste
set   path=.,$HOME
set   report=1
set   shortmess=a
set   softtabstop=2
set   tabstop=2
set   undolevels=1000
set   updatecount=10
set   updatetime=3000
set   viminfo=h,%10,'50,s1000,/1000,:1000
set   virtualedit=block
set   wildignore+=*/.git/
set   wildignore+=*/CVS/
set   wildignore+=*/SVN/
set   wildmode=list:longest,full

set   hlsearch

" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/95139#95139
" Comment to this answer: Instead of manually typing nohlsearch, try mapping
" it. Ctrl-L already redraws the screen, so I make it also and remove search
" highlighting: ... pydave Feb 23 at 19:04
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

" Wrapping
set   formatoptions=tcroq1
set   wrapmargin=2
set   backspace=indent,eol,start
set   textwidth=132

" Indenting
set   autoindent
set   smartindent
set nocopyindent
set   shiftwidth=2

" See http://www.shallowsky.com/linux/noaltscreen.html for an explanation of set t_ti= t_te=
set   t_te=
set   t_ti=

"===========================================================================================
" Refactor starts here

" Movement

set   whichwrap=b,s,<,>,[,] " list of flags specifying which commands wrap to another line
set noautochdir             " change to directory of file in buffer
set   wrapscan              " search commands wrap around the end of the buffer
set   incsearch             " show match for partly typed search command
set   magic                 " change the way backslashes are used in search patterns
set   ignorecase            " ignore case when using a search pattern
set   smartcase             " override 'ignorecase' when pattern has upper case characters

" Display

set   scroll=11 " number of lines to scroll for CTRL-U and CTRL-D
set   scrolloff=999999 " number of screen lines to show around the cursor
set   wrap  " long lines wrap
set   linebreak  " wrap long lines at a character in 'breakat'
set   display=uhex,lastline " include "lastline" to show the last line even if it doesn't fit
"fillchars  characters to use for the status line, folds and filler lines
"   set fcs=vert:\|,fold:-
"cmdheight  number of lines used for the command-line
"   set ch=1
"columns  width of the display
"   set co=172
"lines  number of lines in the display
"   set lines=48
"window  number of lines to scroll for CTRL-F and CTRL-B
"   set window=47
"lazyredraw  don't redraw while executing macros
"   set nolz  lz
"redrawtime  timeout for 'hlsearch' and :match highlighting in msec
"   set rdt=2000
"writedelay  delay in msec for each char written to the display
"  (for debugging)
"   set wd=0
"list  show <Tab> as ^I and end-of-line as $
"  (local to window)
"   set nolist  list
"listchars  list of strings used for list mode
"   set lcs=eol:$
"number  show the line number for each line
"  (local to window)
"   set nu  nonu
"relativenumber  show the relative line number for each line
"  (local to window)
"   set nornu  rnu
"numberwidth  number of columns to use for the line number
"  (local to window)
"   set nuw=5
"conceallevel  controls whether concealable text is hidden
"  (local to window)
"   set cole=0
"concealcursor  modes in which text in the cursor line can be concealed
"  (local to window)
"   set cocu=
"
" 5 syntax, highlighting and spelling
"
"background  "dark" or "light"; the background color brightness
"   set bg=dark
"filetype  type of file; triggers the FileType event when set
"  (local to buffer)
"   set ft=vim
"syntax  name of syntax highlighting used
"  (local to buffer)
"   set syn=vim
"synmaxcol  maximum column to look for syntax items
"  (local to buffer)
"   set smc=3000
"highlight  which highlighting to use for various occasions
"   set hl=8:SpecialKey,@:NonText,d:Directory,e:ErrorMsg,i:IncSearch,l:Search,m:MoreMsg,M:ModeMsg,n:LineNr,r:Question,s:StatusLine,S:StatusLineNC,c:VertSplit,t:Title,v:Visual,V:VisualNOS,w:WarningMsg,W:WildMenu,f:Folded,F:FoldColumn,A:DiffAdd,C:DiffChange,D:DiffDelete,T:DiffText,>:SignColumn,-:Conceal,B:SpellBad,P:SpellCap,R:SpellRare,L:SpellLocal,+:Pmenu,=:PmenuSel,x:PmenuSbar,X:PmenuThumb,*:TabLine,#:TabLineSel,_:TabLineFill,!:CursorColumn,.:CursorLine,o:ColorColumn
"hlsearch  highlight all matches for the last used search pattern
"   set hls  nohls
"cursorcolumn  highlight the screen column of the cursor
"  (local to window)
"   set nocuc  cuc
"cursorline  highlight the screen line of the cursor
"  (local to window)
"   set nocul  cul
"colorcolumn  columns to highlight
"  (local to window)
"   set cc=
"spell  highlight spelling mistakes
"  (local to window)
"   set nospell  spell
"spelllang  list of accepted languages
"  (local to buffer)
"   set spl=en
"spellfile  file that "zg" adds good words to
"  (local to buffer)
"   set spf=
"spellcapcheck  pattern to locate the end of a sentence
"  (local to buffer)
"   set spc=[.?!]\\_[\\])'\"\  \ ]\\+
"spellsuggest  methods used to suggest corrections
"   set sps=best
"mkspellmem  amount of memory used by :mkspell before compressing
"   set msm=460000,2000,500
"
" 6 multiple windows
"
"laststatus  0, 1 or 2; when to use a status line for the last window
"   set ls=2
"statusline  alternate format to be used for a status line
"   set stl=[%02n%(\ %{strlen(&filetype)?&filetype:'none'}%)\ %(%{&modifiable&&&modified?'':'-'}%)%#warningmsg#%(%{&modifiable?&modified?'+':'':'X'}%)%(\ %{&fileformat!='unix'?'*'.&fileformat.'*':''}%)%(\ %{(&fileencoding!='utf-8'&&&fileencoding!='')?'*'.&fileencoding.'*':''}%)%(\ %{StatuslineMixedIndentWarning()}%)%(\ %{StatuslineTrailingSpaceWarning()}%)%(\ %{&paste?'PASTE':''}%)%*]%#warningmsg#%{SyntasticStatuslineFlag()}%*[%c%V:%02l/%02L\ %p%%][%03b:%02B]%(\ %{synIDattr(synID(line('.'),col('.'),1),'name')}%)%=%(\ %{VCSCommandGetStatusLine()}%)%(\ %{getfperm(expand('%'))}%)%(\ %{FileSize()}%)\ %-.20F
"equalalways  make all windows the same size when adding/removing windows
"   set ea  noea
"eadirection  in which direction 'equalalways' works: "ver", "hor" or "both"
"   set ead=both
"winheight  minimal number of lines used for the current window
"   set wh=1
"winminheight  minimal number of lines used for any window
"   set wmh=1
"winfixheight  keep the height of the window
"  (local to window)
"   set nowfh  wfh
"winfixwidth  keep the width of the window
"  (local to window)
"   set nowfw  wfw
"winwidth  minimal number of columns used for the current window
"   set wiw=20
"winminwidth  minimal number of columns used for any window
"   set wmw=1
"helpheight  initial height of the help window
"   set hh=20
"previewheight  default height for the preview window
"   set pvh=12
"previewwindow  identifies the preview window
"  (local to window)
"   set nopvw  pvw
"hidden  don't unload a buffer when no longer shown in a window
"   set nohid  hid
"switchbuf  "useopen" and/or "split"; which window to use when jumping
"  to a buffer
"   set swb=
"splitbelow  a new window is put below the current one
"   set nosb  sb
"splitright  a new window is put right of the current one
"   set nospr  spr
"scrollbind  this window scrolls together with other bound windows
"  (local to window)
"   set noscb  scb
"scrollopt  "ver", "hor" and/or "jump"; list of options for 'scrollbind'
"   set sbo=ver,jump
"cursorbind  this window's cursor moves together with other bound windows
"  (local to window)
"   set nocrb  crb
"
" 7 multiple tab pages
"
"showtabline  0, 1 or 2; when to use a tab pages line
"   set stal=1
"tabpagemax  maximum number of tab pages to open for -p and "tab all"
"   set tpm=10
"tabline  custom tab pages line
"   set tal=
"
" 8 terminal
"
"term  name of the used terminal
"   set term=screen
"ttytype  alias for 'term'
"   set tty=screen
"ttybuiltin  check built-in termcaps first
"   set tbi  notbi
"ttyfast  terminal connection is fast
"   set tf  notf
"weirdinvert  terminal that requires extra redrawing
"   set nowiv  wiv
"esckeys  recognize keys that start with <Esc> in Insert mode
"   set ek  noek
"scrolljump  minimal number of lines to scroll at a time
"   set sj=1
"ttyscroll  maximum number of lines to use scrolling instead of redrawing
"   set tsl=999
"title  show info in the window title
"   set title  notitle
"titlelen  percentage of 'columns' used for the window title
"   set titlelen=85
"titlestring  when not empty, string to be used for the window title
"   set titlestring=
"titleold  string to restore the title to when exiting Vim
"   set titleold=Thanks\ for\ flying\ Vim
"icon  set the text of the icon for this window
"   set noicon  icon
"iconstring  when not empty, text for the icon of this window
"   set iconstring=
"
" 9 using the mouse
"
"mouse  list of flags for using the mouse
"   set mouse=
"mousemodel  "extend", "popup" or "popup_setpos"; what the right
"  mouse button is used for
"   set mousem=extend
"mousetime  maximum time in msec to recognize a double-click
"   set mouset=500
"ttymouse  "xterm", "xterm2", "dec" or "netterm"; type of mouse
"   set ttym=xterm
"
"10 printing
"
"printoptions  list of items that control the format of :hardcopy output
"   set popt=paper:a4
"printdevice  name of the printer to be used for :hardcopy
"   set pdev=
"printexpr  expression used to print the PostScript file for :hardcopy
"   set pexpr=system('lpr'\ .\ (&printdevice\ ==\ ''\ ?\ ''\ :\ '\ -P'\ .\ &printdevice)\ .\ '\ '\ .\ v:fname_in)\ .\ delete(v:fname_in)\ +\ v:shell_error
"printfont  name of the font to be used for :hardcopy
"   set pfn=courier
"printheader  format of the header used for :hardcopy
"   set pheader=%<%f%h%m%=Page\ %N
"printencoding  encoding used to print the PostScript file for :hardcopy
"   set penc=
"printmbcharset  the CJK character set to be used for CJK output from :hardcopy
"   set pmbcs=
"printmbfont  list of font names to be used for CJK output from :hardcopy
"   set pmbfn=
"
"11 messages and info
"
"terse  add 's' flag in 'shortmess' (don't show search message)
"   set terse  noterse
"shortmess  list of flags to make messages shorter
"   set shm=a
"showcmd  show (partial) command keys in the status line
"   set sc  nosc
"showmode  display the current mode in the status line
"   set smd  nosmd
"ruler  show cursor position below each window
"   set ru  noru
"rulerformat  alternate format to be used for the ruler
"   set ruf=
"report  threshold for reporting number of changed lines
"   set report=1
"verbose  the higher the more messages are given
"   set vbs=0
"verbosefile  file to write messages in
"   set vfile=
"more  pause listings when the screen is full
"   set more  nomore
"confirm  start a dialog when a command fails
"   set nocf  cf
"errorbells  ring the bell for error messages
"   set noeb  eb
"visualbell  use a visual bell instead of beeping
"   set novb  vb
"helplang  list of preferred languages for finding help
"   set hlg=en
"
"12 selecting text
"
"selection  "old", "inclusive" or "exclusive"; how selecting text behaves
"   set sel=inclusive
"selectmode  "mouse", "key" and/or "cmd"; when to start Select mode
"  instead of Visual mode
"   set slm=
"keymodel  "startsel" and/or "stopsel"; what special keys can do
"   set km=
"
"13 editing text
"
"undolevels  maximum number of changes that can be undone
"   set ul=1000
"undoreload  maximum number lines to save for undo on a buffer reload
"   set ur=10000
"modified  changes have been made and not written to a file
"  (local to buffer)
"   set mod  nomod
"readonly  buffer is not to be written
"  (local to buffer)
"   set noro  ro
"modifiable  changes to the text are not possible
"  (local to buffer)
"   set ma  noma
"textwidth  line length above which to break a line
"  (local to buffer)
"   set tw=132
"wrapmargin  margin from the right in which to break a line
"  (local to buffer)
"   set wm=2
"backspace  specifies what <BS>, CTRL-W, etc. can do in Insert mode
"   set bs=indent,eol,start
"comments  definition of what comment lines look like
"  (local to buffer)
"   set com=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
"formatoptions  list of flags that tell how automatic formatting works
"  (local to buffer)
"   set fo=1croql
"formatlistpat  pattern to recognize a numbered list
"  (local to buffer)
"   set flp=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
"formatexpr  expression used for "gq" to format lines
"  (local to buffer)
"   set fex=
"complete  specifies how Insert mode completion works for CTRL-N and CTRL-P
"  (local to buffer)
"   set cpt=.,w,b,u,t,i
"completeopt  whether to use a popup menu for Insert mode completion
"   set cot=menu,preview
"pumheight  maximum height of the popup menu
"   set ph=0
"completefunc  user defined function for Insert mode completion
"  (local to buffer)
"   set cfu=
"omnifunc  function for filetype-specific Insert mode completion
"  (local to buffer)
"   set ofu=
"dictionary  list of dictionary files for keyword completion
"  (global or local to buffer)
"   set dict=
"thesaurus  list of thesaurus files for keyword completion
"  (global or local to buffer)
"   set tsr=
"infercase  adjust case of a keyword completion match
"  (local to buffer)
"   set noinf  inf
"digraph  enable entering digraps with c1 <BS> c2
"   set nodg  dg
"tildeop  the "~" command behaves like an operator
"   set notop  top
"operatorfunc  function called for the"g@"  operator
"   set opfunc=
"showmatch  when inserting a bracket, briefly jump to its match
"   set sm  nosm
"matchtime  tenth of a second to show a match for 'showmatch'
"   set mat=5
"matchpairs  list of pairs that match for the "%" command
"  (local to buffer)
"   set mps=(:),{:},[:],<:>
"joinspaces  use two spaces after '.' when joining a line
"   set js  nojs
"nrformats  "alpha", "octal" and/or "hex"; number formats recognized for
"  CTRL-A and CTRL-X commands
"  (local to buffer)
"   set nf=octal,hex
"
"14 tabs and indenting
"
"tabstop  number of spaces a <Tab> in the text stands for
"  (local to buffer)
"   set ts=2
"shiftwidth  number of spaces used for each step of (auto)indent
"  (local to buffer)
"   set sw=2
"smarttab  a <Tab> in an indent inserts 'shiftwidth' spaces
"   set nosta  sta
"softtabstop  if non-zero, number of spaces to insert for a <Tab>
"  (local to buffer)
"   set sts=2
"shiftround  round to 'shiftwidth' for "<<" and ">>"
"   set nosr  sr
"expandtab  expand <Tab> to spaces in Insert mode
"  (local to buffer)
"   set et  noet
"autoindent  automatically set the indent of a new line
"  (local to buffer)
"   set ai  noai
"smartindent  do clever autoindenting
"  (local to buffer)
"   set si  nosi
"cindent  enable specific indenting for C code
"  (local to buffer)
"   set nocin  cin
"cinoptions  options for C-indenting
"  (local to buffer)
"   set cino=
"cinkeys  keys that trigger C-indenting in Insert mode
"  (local to buffer)
"   set cink=0{,0},0),:,0#,!^F,o,O,e
"cinwords  list of words that cause more C-indent
"  (local to buffer)
"   set cinw=if,else,while,do,for,switch
"indentexpr  expression used to obtain the indent of a line
"  (local to buffer)
"   set inde=GetVimIndent()
"indentkeys  keys that trigger indenting with 'indentexpr' in Insert mode
"  (local to buffer)
"   set indk=0{,0},:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\
"copyindent  copy whitespace for indenting from previous line
"  (local to buffer)
"   set noci  ci
"preserveindent  preserve kind of whitespace when changing indent
"  (local to buffer)
"   set nopi  pi
"lisp  enable lisp mode
"  (local to buffer)
"   set nolisp  lisp
"lispwords  words that change how lisp indenting works
"   set lw=defun,define,defmacro,set!,lambda,if,case,let,flet,let*,letrec,do,do*,define-syntax,let-syntax,letrec-syntax,destructuring-bind,defpackage,defparameter,defstruct,deftype,defvar,do-all-symbols,do-external-symbols,do-symbols,dolist,dotimes,ecase,etypecase,eval-when,labels,macrolet,multiple-value-bind,multiple-value-call,multiple-value-prog1,multiple-value-setq,prog1,progv,typecase,unless,unwind-protect,when,with-input-from-string,with-open-file,with-open-stream,with-output-to-string,with-package-iterator,define-condition,handler-bind,handler-case,restart-bind,restart-case,with-simple-restart,store-value,use-value,muffle-warning,abort,continue,with-slots,with-slots*,with-accessors,with-accessors*,defclass,defmethod,print-unreadable-object
"
"15 folding
"
"foldenable  set to display all folds open
"  (local to window)
"   set fen  nofen
"foldlevel  folds with a level higher than this number will be closed
"  (local to window)
"   set fdl=0
"foldlevelstart  value for 'foldlevel' when starting to edit a file
"   set fdls=-1
"foldcolumn  width of the column used to indicate folds
"  (local to window)
"   set fdc=0
"foldtext  expression used to display the text of a closed fold
"  (local to window)
"   set fdt=CustomFoldText()
"foldclose  set to "all" to close a fold when the cursor leaves it
"   set fcl=
"foldopen  specifies for which commands a fold will be opened
"   set fdo=block,hor,mark,percent,quickfix,search,tag,undo
"foldminlines  minimum number of screen lines for a fold to be closed
"  (local to window)
"   set fml=1
"commentstring  template for comments; used to put the marker in
"   set cms=\"%s
"foldmethod  folding type: "manual", "indent", "expr", "marker" or "syntax"
"  (local to window)
"   set fdm=manual
"foldexpr  expression used when 'foldmethod' is "expr"
"  (local to window)
"   set fde=0
"foldignore  used to ignore lines when 'foldmethod' is "indent"
"  (local to window)
"   set fdi=#
"foldmarker  markers used when 'foldmethod' is "marker"
"  (local to window)
"   set fmr={{{,}}}
"foldnestmax  maximum fold depth for when 'foldmethod is "indent" or "syntax"
"  (local to window)
"   set fdn=20
"
"16 diff mode
"
"diff  use diff mode for the current window
"  (local to window)
"   set nodiff  diff
"diffopt  options for using diff mode
"   set dip=filler
"diffexpr  expression used to obtain a diff file
"   set dex=
"patchexpr  expression used to patch a file
"   set pex=
"
"17 mapping
"
"maxmapdepth  maximum depth of mapping
"   set mmd=1000
"remap  recognize mappings in mapped keys
"   set remap  noremap
"timeout  allow timing out halfway into a mapping
"   set to  noto
"ttimeout  allow timing out halfway into a key code
"   set nottimeout  ttimeout
"timeoutlen  time in msec for 'timeout'
"   set tm=1000
"ttimeoutlen  time in msec for 'ttimeout'
"   set ttm=-1
"
"18 reading and writing files
"
"modeline  enable using settings from modelines when reading a file
"  (local to buffer)
"   set ml  noml
"modelines  number of lines to check for modelines
"   set mls=5
"binary  binary file editing
"  (local to buffer)
"   set nobin  bin
"endofline  last line in the file has an end-of-line
"  (local to buffer)
"   set eol  noeol
"bomb  prepend a Byte Order Mark to the file
"  (local to buffer)
"   set nobomb  bomb
"fileformat  end-of-line format: "dos", "unix" or "mac"
"  (local to buffer)
"   set ff=unix
"fileformats  list of file formats to look for when editing a file
"   set ffs=unix,dos
"textmode  obsolete, use 'fileformat'
"  (local to buffer)
"   set notx  tx
"textauto  obsolete, use 'fileformats'
"   set ta  nota
"write  writing files is allowed
"   set write  nowrite
"writebackup  write a backup file before overwriting a file
"   set wb  nowb
"backup  keep a backup after overwriting a file
"   set nobk  bk
"backupskip  patterns that specify for which files a backup is not made
"   set bsk=/tmp/*
"backupcopy  whether to make the backup as a copy or rename the existing file
"   set bkc=auto
"backupdir  list of directories to put backup files in
"   set bdir=/tmp,/home/harleypig/tmp
"backupext  file name extension for the backup file
"   set bex=~
"autowrite  automatically write a file when leaving a modified buffer
"   set noaw  aw
"autowriteall  as 'autowrite', but works with more commands
"   set noawa  awa
"writeany  always write without asking for confirmation
"   set nowa  wa
"autoread  automatically read a file when it was modified outside of Vim
"  (global or local to buffer)
"   set ar  noar
"patchmode  keep oldest version of a file; specifies file name extension
"   set pm=
"fsync  forcibly sync the file to disk after writing it
"   set fs  nofs
"shortname  use 8.3 file names
"  (local to buffer)
"   set nosn  sn
"cryptmethod  encryption method for file writing: zip or blowfish
"  (local to buffer)
"   set cm=zip
"
"19 the swap file
"
"directory  list of directories for the swap file
"   set dir=/tmp,/home/harleypig/tmp
"swapfile  use a swap file for this buffer
"  (local to buffer)
"   set swf  noswf
"swapsync  "sync", "fsync" or empty; how to flush a swap file to disk
"   set sws=fsync
"updatecount  number of characters typed to cause a swap file update
"   set uc=10
"updatetime  time in msec after which the swap file will be updated
"   set ut=3000
"maxmem  maximum amount of memory in Kbyte used for one buffer
"   set mm=474864
"maxmemtot  maximum amount of memory in Kbyte used for all buffers
"   set mmt=474864
"
"20 command line editing
"
"history  how many command lines are remembered 
"   set hi=1000
"wildchar  key that triggers command-line expansion
"   set wc=9
"wildcharm  like 'wildchar' but can also be used in a mapping
"   set wcm=0
"wildmode  specifies how command line completion works
"   set wim=list:longest,full
"suffixes  list of file name extensions that have a lower priority
"   set su=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
"suffixesadd  list of file name extensions added when searching for a file
"  (local to buffer)
"   set sua=
"wildignore  list of patterns to ignore files for file name completion
"   set wig=*/.git/,*/CVS/,*/SVN/
"wildmenu  command-line completion shows a list of matches
"   set wmnu  nowmnu
"cedit  key used to open the command-line window
"   set cedit=
"cmdwinheight  height of the command-line window
"   set cwh=7
"undofile  automatically save and restore undo history
"   set noudf  udf
"undodir  list of directories for undo files
"   set udir=.
"
"21 executing external commands
"
"shell  name of the shell program used for external commands
"   set sh=/bin/bash
"shellquote  character(s) to enclose a shell command in
"   set shq=
"shellxquote  like 'shellquote' but include the redirection
"   set sxq=
"shellcmdflag  argument for 'shell' to execute a command
"   set shcf=-c
"shellredir  used to redirect command output to a file
"   set srr=>%s\ 2>&1
"shelltemp  use a temp file for shell commands instead of using a pipe
"   set stmp  nostmp
"equalprg  program used for "=" command
"  (global or local to buffer)
"   set ep=
"formatprg  program used to format lines with "gq" command
"   set fp=
"keywordprg  program used for the "K" command
"   set kp=man\ -s
"warn  warn when using a shell command and a buffer has changes
"   set warn  nowarn
"
"22 running make and jumping to errors
"
"errorfile  name of the file that contains error messages
"   set ef=errors.err
"errorformat  list of formats for error messages
"  (global or local to buffer)
"   set efm=%*[^\"]\"%f\"%*\\D%l:\ %m,\"%f\"%*\\D%l:\ %m,%-G%f:%l:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,%-G%f:%l:\ for\ each\ function\ it\ appears\ in.),%-GIn\ file\ included\ from\ %f:%l:%c,%-GIn\ file\ included\ from\ %f:%l,%-Gfrom\ %f:%l:%c,%-Gfrom\ %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,%D%*\\a[%*\\d]:\ Entering\ directory\ `%f',%X%*\\a[%*\\d]:\ Leaving\ directory\ `%f',%D%*\\a:\ Entering\ directory\ `%f',%X%*\\a:\ Leaving\ directory\ `%f',%DMaking\ %*\\a\ in\ %f,%f\|%l\|\ %m
"makeprg  program used for the ":make" command
"  (global or local to buffer)
"   set mp=make
"shellpipe  string used to put the output of ":make" in the error file
"   set sp=2>&1\|\ tee
"makeef  name of the errorfile for the 'makeprg' command
"   set mef=
"grepprg  program used for the ":grep" command
"  (global or local to buffer)
"   set gp=grep\ -n\ $*\ /dev/null
"grepformat  list of formats for output of 'grepprg'
"   set gfm=%f:%l:%m,%f:%l%m,%f\ \ %l%m
"
"23 language specific
"
"isfname  specifies the characters in a file name
"   set isf=@,48-57,/,.,-,_,+,,,#,$,%,~,=
"isident  specifies the characters in an identifier
"   set isi=@,48-57,_,192-255
"iskeyword  specifies the characters in a keyword
"  (local to buffer)
"   set isk=@,48-57,_,192-255,#
"isprint  specifies printable characters
"   set isp=@,161-255
"quoteescape  specifies escape characters in a string
"  (local to buffer)
"   set qe=\\
"rightleft  display the buffer right-to-left
"  (local to window)
"   set norl  rl
"rightleftcmd  when to edit the command-line right-to-left
"  (local to window)
"   set rlc=search
"revins  insert characters backwards
"   set nori  ri
"allowrevins  allow CTRL-_ in Insert and Command-line mode to toggle 'revins'
"   set noari  ari
"aleph  the ASCII code for the first letter of the Hebrew alphabet
"   set al=224
"hkmap  use Hebrew keyboard mapping
"   set nohk  hk
"hkmapp  use phonetic Hebrew keyboard mapping
"   set nohkp  hkp
"altkeymap  use Farsi as the second language when 'revins' is set
"   set noakm  akm
"fkmap  use Farsi keyboard mapping
"   set nofk  fk
"arabic  prepare for editing Arabic text
"  (local to window)
"   set noarab  arab
"arabicshape  perform shaping of Arabic characters
"   set arshape  noarshape
"termbidi  terminal will perform bidi handling
"   set notbidi  tbidi
"keymap  name of a keyboard mappping
"   set kmp=
"langmap  translate characters for Normal mode
"   set lmap=
"iminsert  in Insert mode: 1: use :lmap; 2: use IM; 0: neither
"  (local to window)
"   set imi=0
"imsearch  entering a search pattern: 1: use :lmap; 2: use IM; 0: neither
"  (local to window)
"   set ims=0
"
"24 multi-byte characters
"
"encoding  character encoding used in Vim: "latin1", "utf-8"
"  "euc-jp", "big5", etc.
"   set enc=utf-8
"fileencoding  character encoding for the current file
"  (local to buffer)
"   set fenc=utf-8
"fileencodings  automatically detected character encodings
"   set fencs=ucs-bom,utf-8,default,latin1
"termencoding  character encoding used by the terminal
"   set tenc=
"charconvert  expression used for character encoding conversion
"   set ccv=
"delcombine  delete combining (composing) characters on their own
"   set nodeco  deco
"maxcombine  maximum number of combining (composing) characters displayed
"   set mco=2
"ambiwidth  width of ambiguous width characters
"   set ambw=single
"
"25 various
"
"virtualedit  when to use virtual editing: "block", "insert" and/or "all"
"   set ve=block
"eventignore  list of autocommand events which are to be ignored
"   set ei=
"loadplugins  load plugin scripts when starting up
"   set lpl  nolpl
"exrc  enable reading .vimrc/.exrc/.gvimrc in the current directory
"   set noex  ex
"secure  safer working with script files in the current directory
"   set nosecure  secure
"gdefault  use the 'g' flag for ":substitute"
"   set nogd  gd
"edcompatible  'g' and 'c' flags of ":substitute" toggle
"   set noed  ed
"maxfuncdepth  maximum depth of function calls
"   set mfd=100
"sessionoptions  list of words that specifies what to put in a session file
"   set ssop=blank,buffers,curdir,folds,help,options,tabpages,winsize
"viewoptions  list of words that specifies what to save for :mkview
"   set vop=folds,options,cursor
"viewdir  directory where to store files with :mkview
"   set vdir=/home/harleypig/.vim/view
"viminfo  list that specifies what to write in the viminfo file
"   set vi=h,%10,'50,s1000,/1000,:1000
"bufhidden  what happens with a buffer when it's no longer in a window
"  (local to buffer)
"   set bh=
"buftype  "", "nofile", "nowrite" or "quickfix": type of buffer
"  (local to buffer)
"   set bt=
"buflisted  whether the buffer shows up in the buffer list
"  (local to buffer)
"   set bl  nobl
"debug  set to "msg" to see all error messages
"   set debug=
