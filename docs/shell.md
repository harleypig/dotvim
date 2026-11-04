# Shell Scripting

This document outlines the support for shell script development within the Vim
environment.

Note: While Vim has built-in syntax highlighting for shell scripts, external
tools are used to provide enhanced functionality like linting and formatting
to ensure script quality and consistency.

## External Packages Used

Install via package manager (`bin/post-clone` installs both):

* [`shellcheck`](https://github.com/koalaman/shellcheck) - A static analysis
    tool for shell scripts that provides warnings and suggestions for
    `bash`/`sh` shell scripts.
* [`shfmt`](https://github.com/mvdan/sh) - A shell parser, formatter, and
    interpreter with `bash` support.

The two language servers need no install of their own: `coc-sh` bundles
[`bash-language-server`](https://github.com/bash-lsp/bash-language-server),
and `coc-diagnostic` bundles
[`diagnostic-languageserver`][diagnostic-languageserver], which runs
shellcheck.

## Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) -
    Provides enhanced syntax highlighting for shell scripts.
* [`coc.nvim`](https://github.com/neoclide/coc.nvim) (Vim Plugin) -
    Intellisense engine that integrates with bash-language-server.
* [`coc-sh`](https://github.com/josa42/coc-sh) (CoC Extension) - CoC extension
    that provides bash language server support.
* [`coc-diagnostic`](https://github.com/iamcco/coc-diagnostic) (CoC
    Extension) - Runs command-line linters as a language server; here, it
    runs shellcheck on `sh` buffers.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Formats
    shell scripts with shfmt. It runs no shell linter.

## Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Sends `sh` buffers to
    shellcheck through `coc-diagnostic` (`diagnostic-languageserver.filetypes`
    and `diagnostic-languageserver.linters`).
* [`sh.vim`][sh.vim] - Sets `g:is_bash`, and shfmt as ALE's fixer, with its
    options and fixing on save.

## Syntax Highlighting

Provided by `vim-polyglot`, which includes enhanced support for shell script
syntax highlighting. `sh.vim` sets `g:is_bash`, so a file with the `sh`
filetype is highlighted as bash.

## Linting and Static Analysis

* **Tool**: `shellcheck` via `coc-diagnostic`. ALE runs no linter for
    `sh`: `g:ale_linters_explicit` is on and none is named for it.
* **Configuration**: `coc-settings` reads shellcheck's JSON output and maps
    its `style` level to a hint.
* **Usage**: CoC hands the problems to ALE, which shows them in the gutter
    and the quickfix list (see [The Gutter](gutter.md))
* **Features**: Detects common shell script issues, suggests best practices

## Auto Completion

* **Tool**: `bash-language-server` via `coc-sh`
* **Features**: Command completion, variable completion, path completion

## Formatting and Beautification

* **Tool**: `shfmt` via `ALE`
* **Configuration**: Set as the buffer's only fixer in `sh.vim`, so the
    trailing-whitespace fixers every other file gets do not run here. Its
    options are `--indent 2 --simplify --binary-next-line --case-indent
    --space-redirects`, kept in step with the shfmt keys in the
    repository's `.editorconfig`.
* **Usage**: Formats on save (`b:ale_fix_on_save`), or manually with
    `:ALEFix`
* **Features**: Consistent indentation, spacing, and line breaks

## Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for shell scripts)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by Vim's built-in detection and vim-polyglot)

[sh.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/ftplugin/sh.vim
[diagnostic-languageserver]: https://github.com/iamcco/diagnostic-languageserver
