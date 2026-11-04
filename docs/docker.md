# Docker

This document outlines the support for Docker development within the Vim
environment.

Note: The configuration leverages CoC (through coc-docker) for language
server features and vim-polyglot for syntax highlighting, providing a
streamlined experience for working with Dockerfiles.

## External Packages Used

Install manually (no apt or dnf repository carries it; `bin/post-clone`
prints these steps):

* [`hadolint`](https://github.com/hadolint/hadolint) - A Dockerfile linter
    that checks instructions against best practices, and the shell in `RUN`
    lines with shellcheck's rules.

```bash
gh release download --repo hadolint/hadolint --pattern "hadolint-linux-x86_64"
sudo install -m 755 hadolint-linux-x86_64 /usr/local/bin/hadolint
```

## Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) -
    Provides enhanced syntax highlighting for Dockerfiles.
* [`coc-docker`](https://github.com/josa42/coc-docker) (CoC Extension) -
    Starts its own bundled copy of
    [`dockerfile-language-server-nodejs`][dockerfile-language-server-nodejs],
    so nothing needs installing for it.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Lints
    Dockerfiles with hadolint.

## Configuration Files Used

* [`ale.vim`][ale.vim] - Sets hadolint as ALE's linter for Dockerfiles.

## Syntax Highlighting

Provided by vim-polyglot, which includes enhanced support for Dockerfile
syntax highlighting.

## Linting and Static Analysis

* **Tools**: `dockerfile-language-server` via `coc-docker`, and `hadolint`
    via `ALE`
* **Configuration**: The language server uses coc-docker's defaults;
    hadolint is set in `ale.vim`
* **Usage**: Both report to ALE, which shows the problems in the gutter and
    the quickfix list (see [The Gutter](gutter.md))
* **Features**: Syntax validation, best practices checking

## Auto Completion

* **Tool**: `dockerfile-language-server` via `coc-docker`
* **Configuration**: coc-docker's defaults
* **Features**: Directive completion, instruction completion, context-aware
    suggestions

## Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Formatting and Beautification (not specifically configured for Dockerfiles)
* Snippets (not configured specifically for Dockerfiles)
* Schema or Contract Validation (not applicable for Dockerfiles)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by `vim-polyglot`)

[dockerfile-language-server-nodejs]: https://github.com/rcjsuen/dockerfile-language-server-nodejs
[ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/ale.vim
