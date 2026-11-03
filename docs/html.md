# HTML

This document outlines the support for HTML development within the Vim
environment.

Note: The configuration leverages CoC for language server features and
vim-polyglot for syntax highlighting, providing a streamlined experience for
working with HTML files.

## Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) -
    Provides enhanced syntax highlighting for HTML files, and syntax
    highlighting and indentation for Mustache and Handlebars templates.
* [`coc-html`](https://github.com/neoclide/coc-html) (CoC Extension) -
    Runs the HTML language server, which it bundles, so nothing is installed
    outside Vim. It provides completion, formatting and diagnostics.

## Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Sets
    `html.filetypes`, the filetypes coc-html serves.

## Syntax Highlighting

Provided by vim-polyglot, which includes enhanced support for HTML syntax
highlighting. vim-polyglot also highlights and indents Mustache and
Handlebars templates, using the vim-mustache-handlebars plugin it bundles.

## Auto Completion

* **Tool**: `coc-html`
* **Configuration**: `html.filetypes` in `coc-settings` adds `html.mustache`,
    the filetype vim-polyglot gives Mustache templates, to coc-html's
    defaults (`html`, `handlebars`, `htmldjango` and `blade`). CoC passes the
    whole filetype to the server, so `mustache` alone would not match.
* **Features**: Tag completion, attribute completion, context-aware
    suggestions

## Formatting and Beautification

* **Tool**: `coc-html`, run with `:call CocAction('format')`. Nothing formats
    HTML on save: CoC's format on save is off, and ALE has no HTML fixer
    configured.

## Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Linting and Static Analysis (handled by the HTML language server)
* Error Highlighting (handled by CoC)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for HTML)
* Schema or Contract Validation (not applicable for HTML)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by vim-polyglot)
