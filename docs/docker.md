# Docker

This document outlines the support for Docker development within the Vim
environment.

Note: The configuration leverages CoC for language server features and
vim-polyglot for syntax highlighting, providing a streamlined experience for
working with Dockerfiles.

## External Packages Used

Install via npm:

* [`dockerfile-language-server-nodejs`][dockerfile-language-server-nodejs] -
    Language server that provides intelligent code completion, validation, and
    other language features for Dockerfiles.

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
    Provides Docker integration for CoC.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Lints
    Dockerfiles with hadolint.

## Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration
    for the Dockerfile language server.
* [`ale.vim`][ale.vim] - Sets hadolint as ALE's linter for Dockerfiles.

## Syntax Highlighting

Provided by vim-polyglot, which includes enhanced support for Dockerfile
syntax highlighting.

## Linting and Static Analysis

* **Tools**: `dockerfile-language-server` via `CoC`, and `hadolint` via
    `ALE`
* **Configuration**: The language server in `coc-settings.json`; hadolint in
    `ale.vim`
* **Usage**: Both report to ALE, which shows the problems in the gutter and
    the quickfix list (see [The Gutter](gutter.md))
* **Features**: Syntax validation, best practices checking

## Auto Completion

* **Tool**: `dockerfile-language-server` via `CoC`
* **Configuration**: Configured in `coc-settings.json`
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
