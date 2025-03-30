<!-- TODO: Investigate potential ALE fixers for Ansible. -->
## Ansible

This document outlines the support for Ansible development within the Vim
environment, integrating the `coc-ansible` extension for enhanced
functionality.

### External Packages Used

Install via `pipx`:
* [`ansible`](https://www.ansible.com/) - Automation tool for provisioning,
    configuration management, and deployment.
* [`ansible-lint`](https://github.com/ansible-community/ansible-lint) - Lints
    Ansible playbooks for best practices and potential errors. Installed with
    ansible via pipx.
* [`yamllint`](https://github.com/adrienverge/yamllint) - Linter for YAML files
    to ensure consistent formatting. Installed with ansible via pipx.

Install via `npm`:
* [`ansible-language-server`](https://github.com/ansible/ansible-language-server)
    - Provides language features like auto-completion and linting for Ansible.

### Plugins and Extensions Used

* [`@yaegassy/coc-ansible`](https://github.com/yaegassy/coc-ansible) (CoC
    Extension) - Provides auto-completion, linting, and other language features
    for Ansible.
* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin)
    - A collection of language packs for Vim, which includes support for
    Ansible syntax highlighting and filetype detection.

### Configuration Files Used

* [yaml.vim](../.vim/pack/settings/start/settings/after/ftplugin/yaml.vim)
  Configures Vim to recognize YAML files, which are commonly used by Ansible.
* `coc-settings` - Use `:CocConfig` to edit this file.

### Syntax Highlighting

Ansible syntax is highlighted through the `vim-polyglot` plugin.

### Linting and Static Analysis

`ansible-lint` is integrated through the `coc-ansible` extension and provides
automated, as-you-type linting for Ansible playbooks.

`yamllint` is included as part of the `ansible-lint` checks, ensuring YAML
files adhere to consistent formatting standards.

### Auto Completion

The `coc-ansible` extension, which uses `ansible-language-server`, provides
auto-completion features for Ansible.

### Default or Inapplicable Sections

Features such as Error Highlighting, Code Folding, Snippets, Schema or
Contract Validation, Version Control Integration, Comment Support, and
Filetype Detection are handled by the default settings of Vim, the
`coc-ansible` extension, and the `vim-polyglot` plugin.

No additional configuration is documented here as these features are provided
out of the box by the aforementioned tools and extensions.
