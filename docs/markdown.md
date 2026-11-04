# Markdown

This document outlines the support for Markdown editing within the Vim
environment.

Note: Markdown files get two linters through ALE: markdownlint for the
Markdown itself and proselint for the prose in it. There is no Markdown
fixer beyond the global ones; the *Formatting and Beautification* section
says why.

## External Packages Used

Install via `npm` (`bin/post-clone` installs it):

* [`markdownlint-cli`](https://github.com/igorshubovych/markdownlint-cli) -
    The `markdownlint` command, which checks Markdown files against the
    markdownlint rules.

proselint is installed and set up as described in [Proselint](proselint.md).

## Plugins and Extensions Used

* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Lints
    Markdown with markdownlint and proselint.

## Configuration Files Used

* [`markdown.vim`][markdown.vim] - Sets the buffer's ALE linters, and points
    markdownlint at the project's configuration file.
* `.markdownlint.yaml` - markdownlint's rule settings. This repository keeps
    one at its top level, [`.markdownlint.yaml`][markdownlint.yaml], which
    sets the 78-column line length and asterisk bullets.

## Linting and Static Analysis

* **Tools**: `markdownlint` and `proselint` via `ALE`
* **Configuration**: `markdown.vim` sets both as the buffer's linters.
    markdownlint-cli reads a configuration file only from the directory it
    runs in, and ALE runs it from Vim's, so `markdown.vim` finds the file
    itself and passes it with `--config`. It looks for
    `.markdownlint.jsonc`, `.markdownlint.json`, `.markdownlint.yaml` and
    `.markdownlint.yml`, in that order, in the file's directory and each
    directory above it, and uses the first name it finds. With none found,
    no `--config` is passed. proselint's settings are in
    [Proselint](proselint.md).
* **Usage**: markdownlint reads the file on disk, which limits it to
    opening and saving the file; proselint runs as you type. Problems show
    in the gutter and the quickfix list (see [The Gutter](gutter.md)).

## Formatting and Beautification

* **Tool**: The global fixers, via `ALE`, on save
* **Configuration**: With no fixer named for Markdown, the global ones in
    `ale.vim` run: they remove trailing whitespace and trailing blank lines
    (see [ALE and CoC Setup](coc-ale-setup.md)). Removing trailing
    whitespace also removes a line break written as two trailing spaces;
    write it as a backslash at the end of the line instead.
* **Why not prettier**: prettier writes every bullet as `-` and has no
    option to keep `*`, which `CONVENTIONS.md` and the markdownlint
    configuration ask for. It is left out for that reason.

## Default or Inapplicable Sections

The following features use default settings or are not applicable:

* Syntax Highlighting and Filetype Detection (Vim and vim-polyglot, no
    settings changed)
* Auto Completion (no CoC extension for Markdown)
* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured)
* Schema or Contract Validation (not applicable)
* Version Control Integration (uses global Git integration)
* Comment Support (Vim's default)

[markdown.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/ftplugin/markdown.vim
[markdownlint.yaml]: https://github.com/harleypig/dotvim/blob/master/.markdownlint.yaml
