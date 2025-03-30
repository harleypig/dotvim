## JSON

This document outlines the support for JSON development within the Vim environment.

Note: The configuration leverages CoC and ALE for enhanced functionality, providing comprehensive language support for JSON files.

### External Packages Used

Install via npm:
* [`eslint`](https://eslint.org/) - A pluggable and configurable linter tool for identifying and reporting on patterns in JavaScript and related languages.

Install via package manager:
* [`jq`](https://stedolan.github.io/jq/) - A lightweight and flexible command-line JSON processor used for formatting JSON files.

### Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) - A collection of language packs for Vim that includes syntax highlighting for JSON.
* [`coc-eslint`](https://github.com/neoclide/coc-eslint) (CoC Extension) - Integrates ESLint into Vim, providing linting for JavaScript and related languages within the CoC framework.
* [`coc-json`](https://github.com/neoclide/coc-json) (CoC Extension) - Provides JSON language support including schema validation, auto-completion, and more.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Used for formatting JSON files with jq.

### Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration for JSON language server and schema validation.
* [`ale.vim`](../.vim/pack/settings/start/settings/plugin/ale.vim) - Global ALE configuration including JSON formatting settings.
* [`json.vim`](../.vim/pack/settings/start/settings/after/ftplugin/json.vim) - Configures ALE to use jq as a fixer for JSON files and sets up Vim folding for JSON syntax.
* [`.eslintrc.json`](../.eslintrc.json) - Contains the ESLint configuration for linting JavaScript and related languages, including JSON.

### Configured Features

#### Syntax Highlighting
Provided by vim-polyglot, which includes support for JSON syntax highlighting.

#### Linting and Static Analysis
* **Tool**: `ESLint` via `coc-eslint`
* **Configuration**: Configured in `.eslintrc.json`
* **Usage**: Errors and warnings appear in the location list and gutter

#### Auto Completion
* **Tool**: `coc-json`
* **Configuration**: Configured in `coc-settings.json`
* **Features**: Property completion, schema-based suggestions

#### Formatting
* **Tool**: `jq` via `ALE`
* **Configuration**: Set as a fixer in `ale.vim` and `json.vim`
* **Usage**: Automatically formats code on save or manually with `:ALEFix`

#### Schema Validation
* **Tool**: `coc-json`
* **Configuration**: Schema mappings in `coc-settings.json`
* **Features**: Validates JSON against schemas, provides contextual help

### Default or Inapplicable Sections

The following features use default settings without additional configuration:
* Error Highlighting (handled by CoC and ALE)
* Code Folding (configured in json.vim with syntax-based folding)
* Version Control Integration (uses global Git integration)
* Snippets (not configured specifically for JSON)
* Filetype Detection (handled by vim-polyglot)
