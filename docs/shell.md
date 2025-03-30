## Shell Scripting

This document outlines the support for shell script development within the Vim environment.

Note: While Vim has built-in syntax highlighting for shell scripts, external tools are used to provide enhanced functionality like linting and formatting to ensure script quality and consistency.

### External Packages Used

Install via package manager:
* [`shellcheck`](https://github.com/koalaman/shellcheck) - A static analysis tool for shell scripts that provides warnings and suggestions for bash/sh shell scripts.
* [`shfmt`](https://github.com/mvdan/sh) - A shell parser, formatter, and interpreter with bash support.

### Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) - Provides enhanced syntax highlighting for shell scripts.
* [`coc.nvim`](https://github.com/neoclide/coc.nvim) (Vim Plugin) - Intellisense engine that integrates with bash-language-server.
* [`coc-sh`](https://github.com/josa42/coc-sh) (CoC Extension) - CoC extension that provides bash language server support.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Used for linting shell scripts with shellcheck and formatting with shfmt.
* [`diagnostic-languageserver`](https://github.com/iamcco/diagnostic-languageserver) (Language Server) - Provides additional diagnostic capabilities for shellcheck.

### Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration for the bash language server and shellcheck integration.
* [`ale.vim`](../.vim/pack/settings/start/settings/plugin/ale.vim) - Global ALE configuration including shell script linting and formatting settings.
* [`sh.vim`](../.vim/pack/settings/start/settings/after/ftplugin/sh.vim) - Shell-specific settings for editing shell script files.

### Configured Features

#### Syntax Highlighting
Provided by `vim-polyglot`, which includes enhanced support for shell script syntax highlighting.

#### Linting and Static Analysis
* **Tool**: `shellcheck` via `ALE` and `diagnostic-languageserver`
* **Configuration**: Configured in `coc-settings.json` and `ale.vim`
* **Usage**: Errors and warnings appear in the location list and gutter
* **Features**: Detects common shell script issues, suggests best practices

#### Auto Completion
* **Tool**: bash-language-server via `coc-sh`
* **Configuration**: Configured in `coc-settings.json`
* **Features**: Command completion, variable completion, path completion

#### Formatting
* **Tool**: `shfmt` via `ALE`
* **Configuration**: Set as a fixer in `ale.vim`
* **Usage**: Automatically formats code on save or manually with `:ALEFix`
* **Features**: Consistent indentation, spacing, and line breaks

### Default or Inapplicable Sections

The following features use default settings without additional configuration:
* Error Highlighting (handled by ALE and CoC)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for shell scripts)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by Vim's built-in detection and vim-polyglot)
