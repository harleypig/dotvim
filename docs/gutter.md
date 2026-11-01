# The Gutter

The gutter is the sign column at the left edge of each window, beside the
line numbers. This page says what appears there today, where each sign comes
from, and what else it could show.

## Plugins and Extensions Used

* [`ALE`](https://github.com/dense-analysis/ale) (plugin) - places a sign on
    each line with a linter or language-server problem, including the
    problems CoC finds.
* [`coc-git`](https://github.com/neoclide/coc-git) (CoC extension) - places a
    sign on each line changed since the last Git commit. It is installed
    through `g:coc_global_extensions` in `.vimrc`. It runs inside CoC, so
    when `.vimrc` switches CoC off for want of Node.js there are no Git signs.

CoC itself places no diagnostic signs: `diagnostic.displayByAle` hands its
diagnostics to ALE, which displays them (see [ALE and CoC
Setup](coc-ale-setup.md)).

## Configuration Files Used

* [`gutter.vim`][gutter.vim] - keeps the sign column open, turns on line
    numbers, and defines the two toggles below.
* [`diagnostic-colors.vim`][diagnostic-colors.vim] - colors for ALE's signs.
* `coc-settings` - Use `:CocConfig` to edit this file. Turns on
    `diagnostic.displayByAle`; coc-git's sign settings are left at their
    defaults.

## What the Gutter Shows

### Column and line numbers

* The sign column is always shown (`signcolumn=yes`), so text does not shift
    sideways when the first sign appears.
* Absolute line numbers are on (`number`), with `numberwidth=1` so the number
    column is only as wide as the largest line number needs.
* The sign column's background is cleared (`highlight SignColumn
    ctermbg=NONE guibg=NONE`), so it takes the window's background.

### Problem signs (ALE)

ALE's sign text is left at its defaults;
[`diagnostic-colors.vim`][diagnostic-colors.vim] colors them.

| Sign | Meaning | Colors |
| ---- | ------- | ------ |
| `E` | error | white on dark red |
| `W` | warning | black on yellow (gold in the GUI) |
| `I` | info | white on blue (royal blue in the GUI) |

Style errors and style warnings use `E` and `W` as well. The same problems go
to the quickfix list (`g:ale_set_quickfix`), where `c[` and `c]` move through
them when CoC is loaded (they are defined in `coc.vim`).

### Git change signs (coc-git)

coc-git's defaults apply:

| Sign | Meaning |
| ---- | ------- |
| `+` | line added |
| `~` | line changed |
| `_` | line(s) removed below this line |
| `‾` | line(s) removed from the top of the file (shown on line 1) |
| `≃` | lines changed, with more removed than added |

Signs update as you type (`git.realtimeGutters`). Staged changes are not
shown (`git.enableStagedGutters` is off by default). coc-git also offers
commands on the change under the cursor, such as `:CocCommand
git.chunkStage`, `:CocCommand git.chunkUndo` and `:CocCommand
git.chunkInfo`; none of them is mapped.

### When both land on one line

Vim shows one sign per line: the one with the highest priority. ALE's
priority is 30 (`g:ale_sign_priority`) and coc-git's is 10
(`git.signPriority`), so a problem sign hides a Git change sign on the same
line.

## Toggles

* `<leader>signs` - hide the sign column; press again to bring it back. While
    line numbers are shown it comes back as `signcolumn=number`, drawing the
    signs in the number column instead of a column of its own; with no line
    numbers it comes back as its own column.
* `<leader>ln` - cycle the line numbers: absolute, relative, both, none,
    then absolute again.

Both are also listed in `:help learning-gutter`.

## Things to Try

None of these is configured; each is a starting point, with the setting or
plugin that would do it.

* **Different problem sign text.** `g:ale_sign_error`, `g:ale_sign_warning`
    and `g:ale_sign_info` replace `E`, `W` and `I` (for example `>>`), and
    `g:ale_sign_style_error` / `g:ale_sign_style_warning` would tell style
    problems apart from real ones.
* **Staged changes.** Setting `git.enableStagedGutters` makes coc-git mark
    staged lines too, with their own signs (`┃`, `╻`) and priority.
* **Git sign colors.** The commented-out `git.*Sign.hlGroup` block in
    `coc-settings` would set coc-git's sign colors; today they use `DiffAdd`,
    `DiffChange` and `DiffDelete`.
* **Mappings for coc-git.** Change navigation (`git.nextChunk`,
    `git.prevChunk`), staging and undo, and `git.toggleGutters` to hide only
    the Git signs.
* **Marks.** [vim-showmarks](https://github.com/jacquesbh/vim-showmarks)
    shows marks in the gutter; it is on [Plugins to Try](plugins-to-try.md),
    and older showmarks settings are kept in [`showmarks.vim`][showmarks.vim]
    under `OLD_FILES/`, which Vim does not load.
* **Test coverage.** [coc-coverage](https://github.com/ruanyl/coc-coverage)
    marks uncovered lines with a sign; it is on [CoC Extensions to
    Try](extensions-to-try.md).
* **Breakpoints.** [vimspector](https://github.com/puremourning/vimspector)
    places breakpoint and program-counter signs; it is on [Plugins to
    Try](plugins-to-try.md).
* **Signs in the number column by default.** Starting with
    `signcolumn=number` instead of `yes` would save the width of a column, at
    the cost of hiding the line number on any line that has a sign.

Already tried and rejected: `g:ale_change_sign_column_color`, which colors
the whole sign column when a buffer has problems. The note in
[`ale.vim`][ale.vim] keeps it from being tried again.

[gutter.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/gutter.vim
[diagnostic-colors.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/diagnostic-colors.vim
[showmarks.vim]: https://github.com/harleypig/dotvim/blob/master/OLD_FILES/showmarks.vim
[ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/ale.vim
