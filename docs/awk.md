# Awk

This document outlines the support for awk development within the Vim
environment.

Note: awk files get one linter, gawk's own `--lint`, through ALE. There is no
language server and no formatter for awk.

## External Packages Used

Install via package manager (`bin/post-clone` installs it):

* [`gawk`](https://www.gnu.org/software/gawk/) - GNU awk. Its `--lint`
    option reports constructs that are wrong or not portable to other awks.

## Plugins and Extensions Used

* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Lints awk
    files with gawk.

## Configuration Files Used

* [`ale.vim`][ale.vim] - Sets gawk as ALE's linter for the `awk` filetype.

## Linting and Static Analysis

* **Tool**: `gawk` via `ALE`
* **Configuration**: `g:ale_linters.awk` in `ale.vim`. ALE adds a
    `BEGIN { exit }` rule to the script and gives it `/dev/null` as input:
    gawk parses the script and stops before running any of it. What
    comes back is syntax errors and the lint warnings gawk gives while
    parsing; warnings gawk can only give at run time do not appear.
* **Usage**: Runs as you type, like every linter that reads the buffer.
    Problems show in the gutter and the quickfix list (see
    [The Gutter](gutter.md)).

## Default or Inapplicable Sections

The following features use default settings or are not applicable:

* Syntax Highlighting and Filetype Detection (Vim and vim-polyglot, no
    settings changed)
* Formatting and Beautification (only the global fixers, which remove
    trailing whitespace and trailing blank lines on save; see
    [ALE and CoC Setup](coc-ale-setup.md))
* Auto Completion (no CoC extension for awk)
* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured)
* Schema or Contract Validation (not applicable)
* Version Control Integration (uses global Git integration)
* Comment Support (Vim's default)

[ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/ale.vim
