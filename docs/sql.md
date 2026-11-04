# SQL

This document outlines the support for SQL development within the Vim
environment.

Note: SQL files get a linter and a fixer through ALE. There is no language
server for SQL.

## External Packages Used

Install via `pipx` (`bin/post-clone` installs it):

* [`sqlparse`](https://github.com/andialbrecht/sqlparse) - A SQL parser
    whose command-line tool, `sqlformat`, is ALE's SQL fixer.

Install manually (`bin/post-clone` prints this step; no apt or dnf repository
carries it):

* [`sqlint`](https://github.com/purcell/sqlint) - A SQL linter that checks
    against ANSI syntax using the PostgreSQL parser. It is a Ruby gem.

```bash
gem install sqlint
```

## Plugins and Extensions Used

* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Lints SQL
    with sqlint and formats it with sqlformat.

## Configuration Files Used

* [`ale.vim`][ale.vim] - Sets sqlint as ALE's linter and sqlformat as its
    fixer for the `sql` filetype.

## Linting and Static Analysis

* **Tool**: `sqlint` via `ALE`
* **Configuration**: `g:ale_linters.sql` in `ale.vim`. sqlint has no support
    for non-standard dialects such as MySQL, so their syntax can be reported
    as errors.
* **Usage**: Runs as you type. Problems show in the gutter and the quickfix
    list (see [The Gutter](gutter.md)).

## Formatting and Beautification

* **Tool**: `sqlformat` via `ALE`, on save
* **Configuration**: `g:ale_fixers.sql` in `ale.vim`. No options are passed
    to it, so it does not reindent statements or change keyword case; it
    removes trailing whitespace and trailing blank lines.
* **Usage**: Naming a fixer for SQL replaces the global fixers for it, so
    the trailing-whitespace and trailing-blank-line clean-up every other
    file type gets comes from sqlformat alone. `<leader>fb` runs it without
    saving (see [ALE and CoC Setup](coc-ale-setup.md)).

## Default or Inapplicable Sections

The following features use default settings or are not applicable:

* Syntax Highlighting and Filetype Detection (Vim and vim-polyglot, no
    settings changed)
* Auto Completion (no CoC extension for SQL)
* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured)
* Schema or Contract Validation (not applicable)
* Version Control Integration (uses global Git integration)
* Comment Support (Vim's default)

[ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/ale.vim
