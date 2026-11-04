# systemd

This document outlines the support for editing systemd unit files within the
Vim environment.

Note: unit files get one linter, `systemd-analyze verify`, through ALE.
There is no language server and no formatter.

## External Packages Used

* [`systemd-analyze`][systemd-analyze] - Part of systemd, and already
    installed wherever systemd is. `bin/post-clone` does not install it.

## Plugins and Extensions Used

* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Lints unit
    files with `systemd-analyze verify`.

## Configuration Files Used

* [`ale.vim`][ale.vim] - Sets `systemd-analyze` as ALE's linter for the
    `systemd` filetype.

## Linting and Static Analysis

* **Tool**: `systemd-analyze` via `ALE`
* **Configuration**: `g:ale_linters.systemd` in `ale.vim`. ALE runs
    `systemd-analyze --user verify` on the file, which checks every unit as
    the user's service manager would load it, including one meant for the
    system. Each problem it reports is shown as a warning.
* **Usage**: The linter reads the file on disk instead of the buffer. It
    runs when the file is opened and when it is saved, not as you type.
    Problems show in the gutter and the quickfix list (see
    [The Gutter](gutter.md)).

## Default or Inapplicable Sections

The following features use default settings or are not applicable:

* Syntax Highlighting and Filetype Detection (Vim and vim-polyglot, no
    settings changed)
* Formatting and Beautification (only the global fixers, which remove
    trailing whitespace and trailing blank lines on save; see
    [ALE and CoC Setup](coc-ale-setup.md))
* Auto Completion (no CoC extension for unit files)
* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured)
* Schema or Contract Validation (not applicable)
* Version Control Integration (uses global Git integration)
* Comment Support (Vim's default)

[systemd-analyze]: https://www.freedesktop.org/software/systemd/man/latest/systemd-analyze.html
[ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/ale.vim
