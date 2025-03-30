## HashiCorp Configuration

This document outlines the support for HashiCorp tools development within the Vim environment, specifically focusing on Terraform and Packer.

Note: The configuration leverages language servers for enhanced functionality over built-in options, providing more comprehensive language support for HashiCorp's domain-specific languages.

### External Packages Used

Install via package manager:
* [terraform](https://www.terraform.io/) - Infrastructure as code tool for provisioning and managing cloud infrastructure.
* [packer](https://www.packer.io/) - Tool for creating identical machine images for multiple platforms from a single configuration.
* [terraform-ls](https://github.com/hashicorp/terraform-ls) - Language server providing Terraform language support for editors and IDEs.

Install manually:

#### tflint

[tflint](https://github.com/terraform-linters/tflint) - Pluggable Terraform linter focused on possible errors, best practices, and naming conventions.

Using installation script (Linux):
```bash
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
```

Using package managers:
```bash
# macOS
brew install tflint

# Windows
choco install tflint
```

Using GitHub CLI:
```bash
# Linux
gh release download --repo terraform-linters/tflint --pattern "*_linux_amd64.zip"
unzip tflint_*_linux_amd64.zip
sudo mv tflint /usr/local/bin/

# macOS
gh release download --repo terraform-linters/tflint --pattern "*_darwin_amd64.zip"
unzip tflint_*_darwin_amd64.zip
sudo mv tflint /usr/local/bin/

# Windows
gh release download --repo terraform-linters/tflint --pattern "*_windows_amd64.zip"
unzip tflint_*_windows_amd64.zip
# Move to a directory in your PATH
```

Verification (recommended):
```bash
# Using GitHub CLI
gh attestation verify checksums.txt -R terraform-linters/tflint
sha256sum --ignore-missing -c checksums.txt
```

### Plugins and Extensions Used

* [vim-polyglot](https://github.com/sheerun/vim-polyglot) (Vim Plugin) - Provides syntax highlighting for Terraform and HCL files.
* [coc.nvim](https://github.com/neoclide/coc.nvim) (Vim Plugin) - Intellisense engine that integrates with terraform-ls for language server features.
* [ALE](https://github.com/dense-analysis/ale) (Vim Plugin) - Used for linting Terraform files with tflint and formatting with terraform fmt.

### Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration for the terraform-ls language server.
* [`ale.vim`](../.vim/pack/settings/start/settings/plugin/ale.vim) - Global ALE configuration including Terraform linting and formatting settings.

### Configured Features

#### Syntax Highlighting
Provided by vim-polyglot, which includes support for Terraform (HCL) syntax highlighting.

#### Linting and Static Analysis
* **Tool**: tflint via ALE
* **Configuration**: Configured in ale.vim to run automatically on file save
* **Usage**: Errors and warnings appear in the location list and gutter

#### Auto Completion
* **Tool**: terraform-ls via CoC
* **Configuration**: Configured in coc-settings.json
* **Features**: Variable completion, resource type completion, attribute completion

#### Formatting
* **Tool**: terraform fmt via ALE
* **Configuration**: Set as a fixer in ale.vim
* **Usage**: Automatically formats code on save or manually with `:ALEFix`

### Default or Inapplicable Sections

The following features use default settings without additional configuration:
* Error Highlighting (handled by ALE and CoC)
* Code Folding (uses Vim's default folding mechanisms)
* Schema Validation (handled by terraform-ls)
* Version Control Integration (uses global Git integration)
* Snippets (not configured specifically for Terraform)
* Filetype Detection (handled by vim-polyglot)
