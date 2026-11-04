# Python

This document outlines the support for Python development within the Vim
environment.

Note: The configuration leverages CoC and ALE for enhanced functionality,
providing comprehensive language support for Python development with a focus
on code quality and consistency.

## External Packages Used

Install via `pipx`:

* [`isort`](https://pycqa.github.io/isort/) - A Python utility to sort imports
    alphabetically and automatically separate them into sections and by type.
* [`yapf`](https://github.com/google/yapf) - A Python code formatter. Used
    only when installed.
* [`flake8`](https://flake8.pycqa.org/) - A Python linter that checks Python
    code for style and syntax errors.

[`pyright`](https://github.com/microsoft/pyright), Microsoft's static type
checker and language server, does not need installing: `coc-pyright` ships
its own copy.

### Language Server Options

Several Python language servers are available, each with different strengths:

1. **`Pyright`** (Current choice) - Microsoft's static type checker and
    language server
   * Pros: Fast, lightweight, excellent type checking, works well with type
       annotations
   * Cons: Less comprehensive than some alternatives for certain features
   * Install: `npm install -g pyright`

2. **`Python LSP Server (pylsp)`** - Community-maintained language server
   * Pros: Highly extensible with plugins, good integration with various tools
   * Cons: Can be slower than `Pyright`
   * Install: `pipx install python-lsp-server`

3. **`Jedi Language Server`** - Based on the `Jedi` static analysis tool
   * Pros: Lightweight, good completion and navigation
   * Cons: Less feature-rich than some alternatives
   * Install: `pipx install jedi-language-server`

4. **`Palantir's Python Language Server (pyls)`** - Original Python LSP
    implementation
   * Note: Deprecated in favor of `python-lsp-server`

## Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) -
    Provides enhanced syntax highlighting for Python.
* [`coc.nvim`](https://github.com/neoclide/coc.nvim) (Vim Plugin) -
    Intellisense engine that integrates with pyright for Python language
    server features.
* [`coc-pyright`](https://github.com/fannheyward/coc-pyright) (CoC
    Extension) - CoC extension that provides Python language server support.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Used for
    formatting Python files with isort and yapf.

### Alternative CoC Extensions for Python

* [`coc-jedi`](https://github.com/pappasam/coc-jedi) - CoC extension that uses
    Jedi language server
* [`coc-pylsp`](https://github.com/fannheyward/coc-pylsp) - CoC extension for
    python-lsp-server

## Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Turns on flake8
    through `coc-pyright`.
* [`ale.vim`][ale.vim] - Global ALE configuration.
* [`python.vim`][python.vim] - The Python fixers for ALE, and the
    indentation settings.

## Syntax Highlighting

Provided by vim-polyglot, which includes enhanced support for Python syntax
highlighting.

## Linting and Static Analysis

* **Tool**: `Pyright` and `flake8`, both through `coc-pyright`, which runs
    flake8 as one of its external linters. ALE runs no Python linter.
* **Configuration**: `coc-settings` turns flake8 on
    (`python.linting.flake8Enabled`), feeds it the buffer on standard input
    (`python.linting.flake8Stdin`), and passes `--append-config=.flake8`, so
    a project's `.flake8` file is read.
* **Usage**: CoC hands the problems to ALE, which shows them in the gutter
    and the quickfix list (see [The Gutter](gutter.md))
* **Features**: Type checking, style enforcement, syntax error detection

## Auto Completion

* **Tool**: `Pyright` via `coc-pyright`, with its default settings
* **Features**: Function completion, variable completion, import completion

## Formatting and Beautification

* **Tool**: `isort`, then `yapf`, via `ALE`
* **Configuration**: Set as fixers in `python.vim`, each only when it is
    installed. With neither installed, Python files get the fixers every
    file gets (trailing whitespace and trailing blank lines).
* **Usage**: Runs on save, or manually with `:ALEFix`
* **Features**: isort sorts imports alphabetically and by sections; yapf
    reformats the code
* **Poetry Support**: isort runs through `poetry` when a `poetry.lock` is
    found in the file's directory or above (`b:ale_python_isort_auto_poetry`)
* **Indentation**: `python.vim` sets 2-space indentation: `tabstop`,
    `softtabstop` and `shiftwidth` at 2, with `expandtab`

## Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Error Highlighting (handled by CoC and ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for Python)
* Schema or Contract Validation (not applicable for Python)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by vim-polyglot)

[ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/ale.vim
[python.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/ftplugin/python.vim
