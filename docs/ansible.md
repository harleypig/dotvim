<!-- TODO: Investigate potential ALE fixers for Ansible. -->
# Ansible

This document outlines the support for Ansible development within the Vim
environment.

## External Packages Used

Install each via `pipx` (`bin/post-clone` installs all three). The `ansible`
package brings neither linter: it depends only on `ansible-core`.

* [`ansible`](https://www.ansible.com/) - Automation tool for provisioning,
    configuration management, and deployment.
* [`ansible-lint`](https://github.com/ansible-community/ansible-lint) - Lints
    Ansible playbooks for best practices and potential errors.
* [`yamllint`](https://github.com/adrienverge/yamllint) - Linter for YAML
    files to ensure consistent formatting.

[`ansible-language-server`][ansible-language-server], which provides
completion and runs ansible-lint, needs no install of its own:
`@yaegassy/coc-ansible` bundles it.

## Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) - A
    collection of language packs for Vim, which includes support for Ansible
    syntax highlighting and filetype detection.
* [`@yaegassy/coc-ansible`](https://github.com/yaegassy/coc-ansible) (CoC
    Extension) - Provides auto-completion, linting, and other language
    features for Ansible.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Runs
    yamllint, as on every YAML file.

## Configuration Files Used

* [yaml.vim][yaml.vim] - Adds yamllint to ALE's linters. Ansible files have
    the `yaml.ansible` filetype, so it applies to them.
* `coc-settings` - Use `:CocConfig` to edit this file. Turns off
    `ansible.ansible.useFullyQualifiedCollectionNames`, so completion inserts
    short module names rather than fully qualified ones.

## Syntax Highlighting

Provided by `vim-polyglot`, which includes enhanced support for Ansible syntax
highlighting.

## Linting and Static Analysis

* **Tools**: `ansible-lint` via `coc-ansible`, and `yamllint` via `ALE`
* **Configuration**: ansible-lint through the `coc-ansible` extension;
    yamllint in `yaml.vim`
* **Usage**: Both report to ALE, which shows the problems in the gutter and
    the quickfix list (see [The Gutter](gutter.md))
* **Features**: Checks for best practices, potential errors, and consistent
    YAML formatting

## Auto Completion

* **Tool**: `ansible-language-server` via `coc-ansible`
* **Configuration**: Provided by the `coc-ansible` extension
* **Features**: Module completion, variable completion, role completion

## Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for Ansible)
* Schema or Contract Validation (handled by `coc-ansible`)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by `vim-polyglot`)

[yaml.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/ftplugin/yaml.vim
[ansible-language-server]: https://github.com/ansible/ansible-language-server
