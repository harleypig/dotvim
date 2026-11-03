# YAML Support

## External Packages Used

* [yamllint](https://github.com/adrienverge/yamllint) - A linter for YAML
    files that checks for syntax validity, key repetition, and cosmetic
    problems such as line length, trailing spaces, and indentation.

## Plugins and Extensions Used

* [ALE](https://github.com/dense-analysis/ale) - Provides linting via yamllint
* [vim-polyglot](https://github.com/sheerun/vim-polyglot) - Provides syntax
    highlighting for YAML files

## Configuration Files Used

* [`yaml.vim`][yaml.vim] - Adds yamllint to ALE's linters for the buffer.
* `.yamllint` - Optional configuration file for yamllint (can be placed in
    project root or home directory)

## Linting and Static Analysis

YAML files are linted using yamllint through ALE, which checks for:

* Syntax errors
* Key duplications
* Line length
* Trailing spaces
* Indentation
* Key ordering
* Comments formatting

## Filetype Detection

* Files with `.yml` and `.yaml` extensions are automatically detected as YAML
* vim-polyglot detects Ansible files as `yaml.ansible` by name and place, not
    by content, chiefly `playbook.yml`, `site.yml`, `main.yml`, `local.yml` and
    `requirements.yml` (or `.yaml`), and any file under a `group_vars/` or
    `host_vars/` directory. `yaml.vim` applies to them too, so yamllint runs
    on them (see [Ansible](ansible.md)).

## Default or Inapplicable Sections

The following features use default settings or are not applicable:

* Auto Completion
* Formatting and Beautification
* Error Highlighting (handled by ALE)
* Code Folding (uses Vim's default folding)
* Snippets
* Schema or Contract Validation
* Version Control Integration
* Comment Support (uses Vim's default comment support)

[yaml.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/ftplugin/yaml.vim
