# Vim Configuration

A comprehensive Vim configuration with support for multiple languages and development environments.

## Quick Start

After cloning this repository, run the post-clone script to set up all necessary dependencies:

```bash
./bin/post-clone
```

This script will:
- Initialize git submodules
- Install required npm packages
- Install required pipx packages
- Install system packages
- Provide instructions for manual installations

## Documentation

### Core Setup
- [Global Defaults](docs/GLOBAL.md) - Global settings and conventions across all configurations
- [CoC and ALE Setup](docs/coc-ale-setup.md) - Setup and configuration for CoC and ALE
- [Statusline](docs/statusline.md) - Custom statusline configuration with diagnostic integration
- [Utility Plugins](docs/utility.md) - Documentation for utility plugins like gitgutter, fzf, and fugitive

### Language Support
- [Ansible](docs/ansible.md) - Support for Ansible playbooks and roles
- [Docker](docs/docker.md) - Support for Dockerfile development
- [HashiCorp](docs/hashicorp.md) - Support for Terraform, Packer, and other HashiCorp tools
- [HTML](docs/html.md) - Support for HTML and template development
- [JSON](docs/json.md) - Support for JSON files with linting and formatting
- [Python](docs/python.md) - Comprehensive Python development environment
- [Shell Scripting](docs/shell.md) - Support for shell script development
- [Vim Files](docs/vim-files.md) - Support for Vim script development

### Additional Tools
- [Proselint](docs/proselint.md) - Prose linting for documentation and text files

### Development
- [Plugins to Try](docs/plugins-to-try.md) - List of plugins to consider adding
- [Todo](docs/todo.md) - Ongoing development tasks and ideas

## Features

- Language server protocol (LSP) support via CoC
- Asynchronous linting via ALE
- Git integration
- Syntax highlighting for numerous languages
- Intelligent code completion
- Code formatting and linting
- Customizable statusline
- XDG Base Directory specification compliance

## License

This project is licensed under the MIT License - see the LICENSE file for details.
