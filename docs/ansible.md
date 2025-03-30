<!-- TODO: Investigate potential ALE fixers for Ansible. -->
## Ansible

This document outlines the support for Ansible development within the Vim environment.

### External Packages Used

Install via `pipx`:
* [`ansible`](https://www.ansible.com/) - Automation tool for provisioning, configuration management, and deployment.
* [`ansible-lint`](https://github.com/ansible-community/ansible-lint) - Lints Ansible playbooks for best practices and potential errors. Installed with ansible via pipx.
* [`yamllint`](https://github.com/adrienverge/yamllint) - Linter for YAML files to ensure consistent formatting. Installed with ansible via pipx.

Install via `npm`:
* [`ansible-language-server`](https://github.com/ansible/ansible-language-server) - Provides language features like auto-completion and linting for Ansible.

### VIm Plugins Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) - A collection of language packs for Vim, which includes support for Ansible syntax highlighting and filetype detection.

### CoC Extensions Used

* [`@yaegassy/coc-ansible`](https://github.com/yaegassy/coc-ansible) (CoC Extension) - Provides auto-completion, linting, and other language features for Ansible.

### Configuration Files Used

* [yaml.vim](../.vim/pack/settings/start/settings/after/ftplugin/yaml.vim) - Configures Vim to recognize YAML files, which are commonly used by Ansible.
* `coc-settings` - Use `:CocConfig` to edit this file.

### Configured Features

#### Syntax Highlighting
Provided by `vim-polyglot`, which includes enhanced support for Ansible syntax highlighting.

#### Linting and Static Analysis
* **Tool**: `ansible-lint` and `yamllint` via `coc-ansible`
* **Configuration**: Integrated through the `coc-ansible` extension
* **Features**: Checks for best practices, potential errors, and consistent YAML formatting

#### Auto Completion
* **Tool**: `ansible-language-server` via `coc-ansible`
* **Configuration**: Provided by the `coc-ansible` extension
* **Features**: Module completion, variable completion, role completion

### Default or Inapplicable Sections

The following features use default settings without additional configuration:
* Error Highlighting (handled by CoC)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for Ansible)
* Schema Validation (handled by `coc-ansible`)
* Documentation Tools (not configured specifically for Ansible)
* Debugging Support (not configured specifically for Ansible)
* Testing Tools (not configured specifically for Ansible)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by `vim-polyglot`)
