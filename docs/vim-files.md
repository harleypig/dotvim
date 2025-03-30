## Vim Files

This document outlines the support for Vim script development within the Vim environment.

Note: While Vim has built-in support for its own scripting language, external tools are used to provide enhanced functionality like linting and intelligent code completion.

### External Packages Used

Install via npm:
* [`vim-language-server`](https://github.com/iamcco/vim-language-server) - Language server that provides intelligent code completion, go to definition, and other language features for Vim script files.

Install via pipx:
* [`vint`](https://github.com/Vimjas/vint) - A linter for Vim script that checks for style issues and potential errors.

### Plugins and Extensions Used

* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Used for linting Vim script files with vint.

### CoC Extensions Used

* [`coc-vimlsp`](https://github.com/iamcco/coc-vimlsp) (CoC Extension) - CoC extension that provides Vim script language server support.

### Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration for the Vim language server.
* [`ale.vim`](../.vim/pack/settings/start/settings/plugin/ale.vim) - Global ALE configuration.
* [`vim.vim`](../.vim/pack/settings/start/settings/after/ftplugin/vim.vim) - Vim-specific settings for editing Vim script files.

### Configured Features

#### Syntax Highlighting
Provided by Vim's built-in syntax highlighting for Vim script files.

#### Linting and Static Analysis
* **Tool**: `vint` via `ALE`
* **Configuration**: Configured in `ale.vim`
* **Usage**: Errors and warnings appear in the location list and gutter

#### Auto Completion
* **Tool**: `vim-language-server` via `coc-vimlsp`
* **Configuration**: Configured in `coc-settings.json`
* **Features**: Function completion, variable completion, keyword completion

#### Error Highlighting
* **Tool**: `vint` via `ALE`
* **Configuration**: Configured in `ale.vim`
* **Usage**: Syntax errors and style issues are highlighted in the editor

### Default or Inapplicable Sections

The following features use default settings without additional configuration:
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for Vim script)
* Schema Validation (not applicable for Vim script)
* Documentation Tools (not configured specifically for Vim script)
* Debugging Support (not configured specifically for Vim script)
* Testing Tools (not configured specifically for Vim script)
* Version Control Integration (uses global Git integration)
* Formatting (not configured specifically for Vim script)
