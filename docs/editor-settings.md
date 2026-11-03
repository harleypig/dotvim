# General Editor Settings

The options this configuration sets for every buffer, whatever its file
type, plus how help windows open and the colors shared by the diagnostic
signs and the statusline. Only settings that differ from Vim's defaults are
described. A language page covers what its own file type changes, [The
Gutter](gutter.md) covers the sign column and line numbers, and
[Statusline Configuration](statusline.md) covers the statusline. Mappings
are listed in Vim, under `:help learning`.

## Configuration Files Used

* [`set.vim`][set.vim] - the general options.
* [`fold.vim`][fold.vim] - the text shown for a closed fold.
* [`help.vim`][help.vim] - where help windows open, and two help-buffer
    mappings.
* [`helptags.vim`][helptags.vim] - builds help tags at startup.
* [`diagnostic-colors.vim`][diagnostic-colors.vim] - one palette for
    errors, warnings, info and hints.

Where Vim keeps its backup, swap, undo and view files, and how long they are
kept, is in the [README's Setup][setup].

## Files and History

* `autoread` - a file changed outside Vim, and not changed inside it, is
    read again.
* `encoding=utf-8`, whatever the locale says.
* `history=1000` - command-line and search history keep 1000 entries.
* `updatecount=10` and `updatetime=1000` - the swap file is written after
    10 typed characters, or after one second without typing. One second is
    also how long Vim waits before a `CursorHold` event, which redraws the
    statusline.

## Display

* `termguicolors` - Vim uses each highlight group's GUI colors
    (`guifg`, `guibg`) in the terminal too, in 24-bit color. A group that
    sets only `ctermfg` and `ctermbg` shows none of those colors; the
    statusline's mode colors are one ([Statusline
    Configuration](statusline.md)).
* `background=dark`.
* `list`, with `listchars` holding only a `tab:` of two spaces - tabs are
    drawn as blanks and no `$` marks line ends, so the text looks as it does
    without `list`, but the cursor sits at the start of a tab instead of its
    end.
* `linebreak` - a long line wraps at a word boundary (a character in
    `breakat`) instead of mid-word.
* `display=uhex,lastline` - unprintable characters show as hex (`<1b>`),
    and a long last line is shown as far as it fits instead of as `@` lines.
* `scrolloff=999999` - the cursor line stays in the middle of the window,
    except near the start and end of the file.
* `showmatch` - typing a closing bracket briefly jumps to its match.
* `title` - the terminal's title shows the file name.
* `concealcursor=nc` - concealed text stays concealed on the cursor line
    in Normal mode and while typing a command line.

## Editing

* `clipboard+=unnamed` - yanks, deletes and puts use the `*` register (the
    X selection), when Vim is built with clipboard support.
* `matchpairs+=<:>` - `%` also jumps between `<` and `>`.
* `virtualedit=block` - in Visual block mode the cursor can move past the
    end of a line, so a block can be rectangular over lines of different
    lengths.
* `report=1` - a message is given whenever more than one line changes.
* `shortmess=a` - file and change messages are abbreviated (`[+]` for
    `[Modified]`, `999L, 888B` for lines and bytes, and the like).

### Text wrapping

These are the global values; many file types' own plugins change
`formatoptions`, and some change `textwidth`.

* `textwidth=78` - typed text wraps at 78 columns.
* `formatoptions=tcroq1` - wrap text and comments as you type, continue a
    comment on `<Enter>` and on `o` / `O`, let `gq` format comments, and do
    not end a line after a one-letter word.

### Indenting

* `tabstop=2`, `softtabstop=2`, `shiftwidth=2` and `expandtab` - indent
    two spaces, and insert spaces for `<Tab>`.
* `autoindent` and `smartindent` - a new line takes the previous line's
    indent, and C-like code is indented a step after `{` and similar.

## Searching and Moving

* `incsearch` and `hlsearch` - matches show while a pattern is typed, and
    all matches of the last search stay highlighted. `<C-l>` clears the
    highlighting (see `:help learning`).
* `ignorecase` and `smartcase` - searches ignore case unless the pattern
    has a capital letter.
* `whichwrap=b,s,<,>,[,]` - `<BS>`, `<Space>` and the left and right arrow
    keys (in Normal and Insert mode) move on to the previous or next line.
* `path=.,$HOME` - `gf` and `:find` look in the current file's directory
    and in the home directory, not in `/usr/include`.
* `wildmode=list:longest,full` - the first `<Tab>` on the command line
    lists the matches and completes their longest common part; the next one
    steps through them. `wildignore` leaves out `.git/`, `CVS/` and `SVN/`
    directories.

## Code Folding

* `foldlevelstart=99` - every file opens with its folds open.
* A closed fold shows its first non-blank line, dotted out to the window
  edge, then its size in lines, its share of the buffer and its level, for
  example `function! Foo()....... 12 lines [3.4%] +--+--` (`fold.vim`).

## Terminal

`t_ti` and `t_te` are emptied, so Vim does not switch to the terminal's
alternate screen: what Vim showed stays in the terminal after it exits.

## Help Windows

* Help opens in a vertical split at the right edge of the screen, no wider
  than 80 columns.
* In a help buffer, `<Enter>` follows the link under the cursor (`<C-]>`)
  and `<C-[>` goes back (`<C-o>`). `<C-[>` is the same key as `<Esc>`, so
  `<Esc>` goes back too.
* At startup, help tags are built for each writable `doc` directory on the
  runtime path whose tags are missing or older than a file beside them, so
  `:help` finds the plugins' docs and this configuration's own.

## Diagnostic Colors

`diagnostic-colors.vim` holds one palette, `g:diagnostic_colors`, and sets
these highlight groups from it at startup and again after every
`:colorscheme`:

| Level | Terminal colors | GUI colors | Groups |
| ----- | --------------- | ---------- | ------ |
| error | white on dark red | white on dark red | `ALEErrorSign`, `CocErrorSign`, `ALEVirtualTextError`, `DiagnosticError` |
| warning | black on yellow | black on gold | `ALEWarningSign`, `CocWarningSign`, `ALEVirtualTextWarning`, `DiagnosticWarning` |
| info | white on blue | white on royal blue | `ALEInfoSign`, `CocInfoSign`, `ALEVirtualTextInfo`, `DiagnosticInfo` |
| hint | black on light grey | black on light grey | `CocHintSign` |

`termguicolors` is on, so the GUI colors are the ones shown, in a terminal
too. The `ALE*Sign` groups color the gutter's signs and the `Diagnostic*`
groups color the statusline's ALE counts. The `Coc*Sign` and
`ALEVirtualText*` groups are set but do not show today: CoC hands its
diagnostics to ALE instead of placing signs, and ALE's virtual text is off
([ALE and CoC Setup](coc-ale-setup.md)).

## Default or Inapplicable Sections

`set.vim` also sets these, but each already matches Vim's default (checked
on Vim 9.1.2141) or has no effect:

* Already the default: `undolevels=1000`, `nocursorline`, `nohidden`,
  `showcmd`, `wildmenu`, `backspace=indent,eol,start`, `mouse=`, `magic`,
  `wrap`, `wrapscan`, `noautochdir` and `nocopyindent`.
* `wrapmargin=2` has no effect, because `textwidth` is set.
* `terse` has no effect, because `shortmess=a`, set after it, drops the `s`
  flag `terse` adds.
* `scroll=11` has no effect: Vim sets `scroll` to half the window height
  when the window is sized at startup.

Diff colors are Vim's defaults; no color scheme is loaded ([Utility
Plugins](utility.md)).

[set.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/set.vim
[fold.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/fold.vim
[help.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/help.vim
[helptags.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/plugin/helptags.vim
[diagnostic-colors.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/diagnostic-colors.vim
[setup]: https://github.com/harleypig/dotvim/blob/master/README.md#setup
