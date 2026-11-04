# Vim Files

This document outlines the support for Vim script development within the Vim
environment.

Note: While Vim has built-in support for its own scripting language, external
tools are used to provide enhanced functionality like linting and intelligent
code completion.

## External Packages Used

Install via pipx:

* [`vint`](https://github.com/Vimjas/vint) - A linter for Vim script that
    checks for style issues and potential errors.

[`vim-language-server`](https://github.com/iamcco/vim-language-server), which
provides completion, go to definition and other language features, needs no
install of its own: `coc-vimlsp` bundles it.

## Plugins and Extensions Used

* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Used for
    linting Vim script files with vint, its only Vim linter.
* [`coc-vimlsp`](https://github.com/iamcco/coc-vimlsp) (CoC Extension) - CoC
    extension that provides Vim script language server support.

## Configuration Files Used

* [`vim.vim`][vim.vim] - Sets vint as ALE's linter for Vim script, and the
    indent of continuation lines.

## Syntax Highlighting

Provided by Vim's built-in syntax highlighting for Vim script files.

## Linting and Static Analysis

* **Tool**: `vint` via `ALE`. ALE does not run vim-language-server: it is an
    LSP linter, and ALE's LSP features are off (`g:ale_disable_lsp`).
* **Configuration**: Set as the buffer's linter in `vim.vim`
* **Usage**: Errors and warnings, vint's and vim-language-server's (which CoC
    hands to ALE), appear in the gutter and the quickfix list (see [The
    Gutter](gutter.md))

## Auto Completion

* **Tool**: `vim-language-server` via `coc-vimlsp`, with its default settings
* **Features**: Function completion, variable completion, keyword completion

## Formatting and Beautification

`vim.vim` sets `g:vim_indent` so that a continuation line (one starting with
a backslash) is indented one `shiftwidth` past the line it continues, instead
of Vim's default of three.

## Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for Vim script)
* Schema or Contract Validation (not applicable for Vim script)
* Version Control Integration (uses global Git integration)

[vim.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/ftplugin/vim.vim
