# HTML

This document outlines the support for HTML development within the Vim
environment.

Note: The configuration leverages CoC for language server features and
vim-polyglot for syntax highlighting, providing a streamlined experience for
working with HTML files.

## External Packages Used

Install via npm:

* [`vscode-html-languageservice`][vscode-html-languageservice] -
    Language service that provides intelligent code completion, validation,
    and other language features for HTML files.

## Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) -
    Provides enhanced syntax highlighting for HTML files, and syntax
    highlighting and indentation for Mustache and Handlebars templates.
* No specific CoC extension is used for HTML, but the HTML language server is
    configured directly in CoC settings.

## Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration
    for the HTML language server.

## Syntax Highlighting

Provided by vim-polyglot, which includes enhanced support for HTML syntax
highlighting. vim-polyglot also highlights and indents Mustache and
Handlebars templates, using the vim-mustache-handlebars plugin it bundles.

## Auto Completion

* **Tool**: `vscode-html-languageservice` via `CoC`
* **Configuration**: Configured in `coc-settings.json`
* **Features**: Tag completion, attribute completion, context-aware
    suggestions

## Formatting and Beautification

* **Tool**: `vscode-html-languageservice` via `CoC`
* **Configuration**: Configured in `coc-settings.json` with
    `provideFormatter: true`
* **Features**: Automatic formatting of HTML documents

## Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Linting and Static Analysis (handled by the HTML language server)
* Error Highlighting (handled by CoC)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for HTML)
* Schema or Contract Validation (not applicable for HTML)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by vim-polyglot)

[vscode-html-languageservice]: https://github.com/Microsoft/vscode-html-languageservice
