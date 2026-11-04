# Statusline Configuration

The statusline is built by [`statusline.vim`][statusline.vim], which loads
from `after/plugin/` so it runs after every plugin. It is always shown
(`laststatus=2`).

## Layout

Left-aligned, in order:

* **Buffer block**, in brackets: the buffer number (two digits), the
  filetype (`none` when there is none), and one status marker:
  * `X` - not modifiable; this wins over the rest
  * `RO` - read-only, or `+RO` when also modified
  * `+` - modified, `-` - not modified
* **Warnings**, separated by spaces, each shown only when it applies:
  * the file format between asterisks (`*dos*`) when it is not unix
  * the file encoding between asterisks when it is set and is not utf-8
  * `[mixed indenting]` when some lines start with a tab and others with a
    space, or `[&et]` when lines start only with the one 'expandtab' would
    not produce (spaces with it off, tabs with it on)
  * `[trailing space]` when any line ends in whitespace
  * `[PASTE]` when 'paste' is on

  The indent and trailing-space checks are skipped in help buffers. They
  search the whole buffer, so their results are kept, and checked again on
  `CursorHold` and after each write.
* **ALE counts**, only when ALE has problems for the buffer, such as
  `[E2W1I3:\qf]`: errors (style errors included), warnings (style warnings
  included) and info, each in its own highlight group. CoC's diagnostics
  are counted here, because CoC hands them to ALE (`diagnostic.displayByAle`
  in `coc-settings`). `\qf` is the `<leader>qf` mapping that toggles the
  quickfix window, where the problems are listed.
* **Position**, in brackets: the column (with the screen column after a `-`
  when they differ), line and total lines, percentage through the file, and
  the file size: bytes under 1 KiB, then `k`, then `TooDamnBig!` from 1 MiB
  up. An empty or unsaved file shows no size.
* **Character under the cursor**, in brackets, in decimal and hexadecimal.
* **Syntax group under the cursor**, in brackets, when there is one.

Right-aligned:

* The file's permissions, such as `rw-r--r--`, when the file exists.
* The full file path, cut to its last 20 characters, with `<` marking the
  cut.

The statusline is redrawn on `CursorHold` and after each write, when the
warnings are checked again.

## Colors

The `StatusLine` highlight changes with the mode, and each change sets the
same colors for terminals (`ctermbg`, `ctermfg`) and the GUI (`guibg`,
`guifg`). `termguicolors` is on ([General Editor
Settings](editor-settings.md)), so a terminal shows the GUI colors. No color
scheme is loaded, so `StatusLine` keeps Vim's default `reverse` attribute,
which swaps the two colors on screen:

| When | Set to | Shows as |
| ---- | ------ | -------- |
| Startup | background Black, foreground White | black text on white |
| Insert mode | background Yellow, foreground Blue | yellow text on blue |
| Command-line window | background Gray, foreground Red | gray text on red |

Leaving Insert mode or the command-line window restores the startup colors.

The ALE counts use `DiagnosticError`, `DiagnosticWarning` and
`DiagnosticInfo`, set in [`diagnostic-colors.vim`][diagnostic-colors.vim].
The warnings use `warningmsg`.

## Customization

Every marker and warning text above comes from one dictionary, `g:yasl`,
with `buffer`, `warnings` and `format` sections; the file lists its keys.
It is set only when `g:yasl` does not already exist, so a `g:yasl` defined
before the file loads replaces it whole and has to carry every key.

## Functions

* `YASL_BufferInfo()` - the buffer block
* `YASL_Warnings()` - the warnings
* `YASL_LinterStatus()` - the ALE counts
* `YASL_FileSize()` - the file size in the position block

## Integration with Plugins

* ALE - the problem counts, through `ale#statusline#Count()`.
* CoC - its diagnostics only, inside ALE's counts. There is no CoC status
  or current-function segment.

[statusline.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/plugin/statusline.vim
[diagnostic-colors.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/diagnostic-colors.vim
