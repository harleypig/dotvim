# JSON

This document outlines the support for JSON development within the Vim
environment.

Note: The configuration leverages CoC and ALE for enhanced functionality,
providing comprehensive language support for JSON files.

## External Packages Used

Install via package manager:

* [`jq`](https://stedolan.github.io/jq/) - A lightweight and flexible
    command-line JSON processor used for formatting JSON files.

## Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) - A
    collection of language packs for Vim that includes syntax highlighting for
    JSON.
* [`coc-json`](https://github.com/neoclide/coc-json) (CoC Extension) -
    Provides JSON language support including schema validation,
    auto-completion, and more.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Used for
    formatting JSON files with jq.

## Configuration Files Used

* [`json.vim`][json.vim] - Sets jq as ALE's fixer for JSON and JSONC files
    and turns on syntax folding. It runs only for `json` and `jsonc` buffers,
    and only with filetype plugins on; Vim's own `jsonc` ftplugin sources it.

## Syntax Highlighting

Provided by vim-polyglot, which includes support for JSON syntax highlighting.

## Linting and Static Analysis

* **Tool**: `coc-json`, which reports syntax errors and schema problems.
    ALE runs no JSON linter: `g:ale_linters_explicit` is on and `ale.vim`
    names none for `json`.
* **Usage**: CoC hands the problems to ALE, which shows them in the gutter
    and the quickfix list (see [The Gutter](gutter.md))

## Auto Completion

* **Tool**: `coc-json`, with its default settings
* **Features**: Property completion, schema-based suggestions

## Formatting and Beautification

* **Tool**: `jq` via `ALE`
* **Configuration**: Set as a fixer in `json.vim`
* **Usage**: Automatically formats code on save or manually with `:ALEFix`

## Schema or Contract Validation

* **Tool**: `coc-json`, with its default settings: no schema mappings are
    configured. A file is checked against the schema its `$schema` key
    names, or the one coc-json's built-in SchemaStore catalog matches to its
    file name.
* **Features**: Validates JSON against schemas, provides contextual help

## Code Folding

`json.vim` sets `foldmethod=syntax`, so objects and arrays fold.

## Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Error Highlighting (handled by CoC and ALE)
* Version Control Integration (uses global Git integration)
* Snippets (not configured specifically for JSON)
* Filetype Detection (handled by vim-polyglot)

[json.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/ftplugin/json.vim
