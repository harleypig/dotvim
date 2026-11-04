# Proselint

This document outlines the support for prose linting within the Vim
environment using Proselint.

Note: Proselint was chosen over built-in options for its comprehensive prose
checking capabilities, focusing on clarity, consistency, and avoiding common
writing errors.

## External Packages Used

Install via `pipx`:

* [`proselint`](https://github.com/amperser/proselint) - A linter for prose
  that identifies errors in style, usage, and consistency in writing.

Install via `npm`:

* [`diagnostic-languageserver`](https://github.com/iamcco/diagnostic-languageserver)
  (Language Server) - Provides a bridge between Proselint and CoC. Install via
  npm.

## Plugins and Extensions Used

* [`coc.nvim`](https://github.com/neoclide/coc.nvim) (Vim Plugin) - Integrates
  with diagnostic-languageserver to provide Proselint functionality.

## Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration
  for diagnostic-languageserver to use Proselint.
* `proselint.json` - Proselint's rule settings, optional. This repository
  sets none. Proselint looks for one itself: `proselint.json` in the working
  directory or any directory above it, then
  `$XDG_CONFIG_HOME/proselint/config.json`, then its built-in defaults.

## Linting and Static Analysis

* **Tool**: `proselint` via `diagnostic-languageserver`, on text files
* **Configuration**: Configured in `coc-settings.json` to run on text files,
  as `proselint check` reading the buffer on stdin. That is the command line
  from proselint 0.16.0 on; earlier releases do not have the `check`
  command.
* **Tools**: `proselint` and `markdownlint` via `ALE`, on Markdown files
* **Configuration**: Both are set as the buffer's linters by the Markdown
  ftplugin, which also gives markdownlint the nearest `.markdownlint.yaml`
  above the file (or its `.jsonc`, `.json` or `.yml` form). ALE asks
  proselint for its version and runs `proselint check` from 0.16.0 on, and
  `proselint` on earlier releases.
* **Usage**: Both report to ALE, which shows the problems in the gutter and
  the quickfix list (see [The Gutter](gutter.md))

## Default or Inapplicable Sections

The following features use default settings or are not applicable:

* Syntax Highlighting (uses Vim's default text highlighting)
* Auto Completion (not applicable for prose linting)
* Formatting and Beautification (not provided by Proselint)
* Error Highlighting (handled by CoC's diagnostic display)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for prose)
* Schema or Contract Validation (not applicable for prose)
* Version Control Integration (uses global Git integration)
