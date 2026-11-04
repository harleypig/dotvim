# PowerShell

This document outlines the support for PowerShell development within the Vim
environment.

Note: PowerShell files get one linter, a syntax check run by PowerShell
itself, through ALE. There is no language server and no formatter.

## External Packages Used

Install manually; `bin/post-clone` does not install it:

* [`pwsh`](https://github.com/PowerShell/PowerShell) - The cross-platform
    PowerShell. ALE runs it to parse the script. Microsoft's
    install steps for each Linux distribution are in
    [Install PowerShell on Linux][install].

## Plugins and Extensions Used

* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Checks
    PowerShell scripts for syntax errors with `pwsh`.

## Configuration Files Used

* [`ale.vim`][ale.vim] - Sets `powershell` as ALE's linter for the `ps1`
    filetype.

## Linting and Static Analysis

* **Tool**: ALE's `powershell` linter, which runs `pwsh`
* **Configuration**: `g:ale_linters.ps1` in `ale.vim`. Vim gives `.ps1`,
    `.psd1`, `.psm1` and `.pssc` files the `ps1` filetype, which ALE treats
    as PowerShell. ALE starts `pwsh -NoProfile` on a temporary copy of the
    buffer and has PowerShell parse it into a script block without running
    it, so only parse errors are reported, not style or best-practice
    problems.
* **Usage**: Runs as you type. Problems show in the gutter and the quickfix
    list (see [The Gutter](gutter.md)). With no `pwsh` on `PATH`, ALE skips
    the linter and nothing is reported.

## Default or Inapplicable Sections

The following features use default settings or are not applicable:

* Syntax Highlighting and Filetype Detection (Vim and vim-polyglot, no
    settings changed)
* Formatting and Beautification (only the global fixers, which remove
    trailing whitespace and trailing blank lines on save; see
    [ALE and CoC Setup](coc-ale-setup.md))
* Auto Completion (no CoC extension for PowerShell)
* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured)
* Schema or Contract Validation (not applicable)
* Version Control Integration (uses global Git integration)
* Comment Support (Vim's default)

[install]: https://learn.microsoft.com/powershell/scripting/install/installing-powershell-on-linux
[ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/ale.vim
