## Proselint

This document outlines the support for prose linting within the Vim environment using Proselint.

Note: Proselint was chosen over built-in options for its comprehensive prose checking capabilities, focusing on clarity, consistency, and avoiding common writing errors.

### External Packages Used

Install via `pipx`:
* [`proselint`](https://github.com/amperser/proselint) - A linter for prose that identifies errors in style, usage, and consistency in writing.

### Plugins and Extensions Used

* [`coc.nvim`](https://github.com/neoclide/coc.nvim) (Vim Plugin) - Integrates with diagnostic-languageserver to provide Proselint functionality.
* [`diagnostic-languageserver`](https://github.com/iamcco/diagnostic-languageserver) (Language Server) - Provides a bridge between Proselint and CoC.

### Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration for diagnostic-languageserver to use Proselint.
* `.proselint-config.json` - Custom configuration file for Proselint rules and settings.

### Configured Features

#### Linting and Static Analysis
* **Tool**: `proselint` via diagnostic-languageserver
* **Configuration**: Configured in `coc-settings.json` to run on text files
* **Usage**: Errors and warnings appear in the location list and gutter

### Default or Inapplicable Sections

The following features use default settings or are not applicable:
* Syntax Highlighting (uses Vim's default text highlighting)
* Auto Completion (not applicable for prose linting)
* Formatting (not provided by Proselint)
* Error Highlighting (handled by CoC's diagnostic display)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for prose)
* Schema Validation (not applicable for prose)
* Version Control Integration (uses global Git integration)
