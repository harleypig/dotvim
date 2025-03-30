## Python

This document outlines the support for Python development within the Vim environment.

Note: The configuration leverages CoC and ALE for enhanced functionality, providing comprehensive language support for Python development with a focus on code quality and consistency.

### External Packages Used

Install via `pipx`:
* [`isort`](https://pycqa.github.io/isort/) - A Python utility to sort imports alphabetically and automatically separate them into sections and by type.
* [`flake8`](https://flake8.pycqa.org/) - A Python linter that checks Python code for style and syntax errors.

Install via `npm`:
* [`pyright`](https://github.com/microsoft/pyright) - Static type checker for Python, used by CoC for type checking and language server features.
* [`pyright-langserver`](https://github.com/microsoft/pyright) - The language server component of Pyright that provides IDE features.

#### Language Server Options

Several Python language servers are available, each with different strengths:

1. **`Pyright`** (Current choice) - Microsoft's static type checker and language server
   * Pros: Fast, lightweight, excellent type checking, works well with type annotations
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

4. **`Palantir's Python Language Server (pyls)`** - Original Python LSP implementation
   * Note: Deprecated in favor of `python-lsp-server`

### Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) - Provides enhanced syntax highlighting for Python.
* [`coc.nvim`](https://github.com/neoclide/coc.nvim) (Vim Plugin) - Intellisense engine that integrates with pyright for Python language server features.
* [`coc-pyright`](https://github.com/fannheyward/coc-pyright) (CoC Extension) - CoC extension that provides Python language server support.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Used for formatting Python files with isort.

#### Alternative CoC Extensions for Python

* [`coc-jedi`](https://github.com/pappasam/coc-jedi) - CoC extension that uses Jedi language server
* [`coc-pylsp`](https://github.com/fannheyward/coc-pylsp) - CoC extension for python-lsp-server

### Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration for the Python language server and flake8 integration.
* [`ale.vim`](../.vim/pack/settings/start/settings/plugin/ale.vim) - Global ALE configuration.
* [`python.vim`](../.vim/pack/settings/start/settings/after/ftplugin/python.vim) - Python-specific settings for editing Python files.

### Configured Features

#### Syntax Highlighting
Provided by vim-polyglot, which includes enhanced support for Python syntax highlighting.

#### Linting and Static Analysis
* **Tool**: `Pyright` via `coc-pyright` and `flake8` via `CoC`
* **Configuration**: Configured in `coc-settings.json`
* **Usage**: Errors and warnings appear in the location list and gutter
* **Features**: Type checking, style enforcement, syntax error detection

#### Auto Completion
* **Tool**: `Pyright` via `coc-pyright`
* **Configuration**: Configured in `coc-settings.json`
* **Features**: Function completion, variable completion, import completion
* **Settings**: Inlay hints for function return types and variable types are disabled

#### Formatting
* **Tool**: `isort` via `ALE`
* **Configuration**: Set as a fixer in `python.vim`
* **Usage**: Automatically formats imports on save or manually with `:ALEFix`
* **Features**: Sorts imports alphabetically and by sections
* **Poetry Support**: Automatically detects `Poetry` environments

#### Indentation
* **Configuration**: Set in python.vim
* **Settings**: 2-space indentation with expandtab, autoindent, and smartindent

### Default or Inapplicable Sections

The following features use default settings without additional configuration:
* Error Highlighting (handled by CoC and ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for Python)
* Schema Validation (not applicable for Python)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by vim-polyglot)
