# HashiCorp Configuration

This document outlines the support for HashiCorp tools development within the
Vim environment: Terraform files (`terraform` filetype) and other HCL files
(`hcl`).

Note: The configuration leverages language servers for enhanced functionality
over built-in options, providing more comprehensive language support for
HashiCorp's domain-specific languages.

## External Packages Used

Install via package manager:

* [`terraform`](https://www.terraform.io/) - Infrastructure as code tool for
    provisioning and managing cloud infrastructure.
* [`terraform-ls`](https://github.com/hashicorp/terraform-ls) - Language
    server providing Terraform language support for editors and IDEs.

Install manually:

### tflint

[`tflint`](https://github.com/terraform-linters/tflint) - Pluggable Terraform
linter focused on possible errors, best practices, and naming conventions.

Using installation script (Linux):

```bash
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
```

Using GitHub CLI:

```bash
# Linux
gh release download --repo terraform-linters/tflint --pattern "*_linux_amd64.zip" --pattern "checksums.txt"
sha256sum --ignore-missing -c checksums.txt
unzip tflint_*_linux_amd64.zip
sudo install -m 755 tflint /usr/local/bin/
```

## Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) -
    Provides syntax highlighting for Terraform and HCL files.
* [`coc.nvim`](https://github.com/neoclide/coc.nvim) (Vim Plugin) -
    Intellisense engine that integrates with `terraform-ls` for language
    server features, on Terraform files only.
* [`ALE`](https://github.com/dense-analysis/ale) (Vim Plugin) - Lints
    Terraform files with `tflint`, and formats Terraform and HCL files with
    `terraform fmt`.

## Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Runs terraform-ls for
    the `terraform` and `tf` filetypes.
* [`terraform.vim`][terraform.vim] - The ALE linter and fixer, folding and
    comment string for Terraform files.
* [`hcl.vim`][hcl.vim] - The ALE fixer, folding and comment string for HCL
    files.

## Syntax Highlighting

Provided by `vim-polyglot`, which includes support for Terraform (HCL) syntax
highlighting.

## Linting and Static Analysis

* **Tool**: `tflint` via `ALE`, on Terraform files. HCL files get no ALE
    linter: ALE has none for HCL, and tflint is Terraform's.
* **Configuration**: Set as the buffer's linter in `terraform.vim`. ALE
    lints as you type, on leaving Insert mode, on opening and on saving
    ([ALE and CoC Setup](coc-ale-setup.md)).
* **Usage**: Errors and warnings appear in the gutter and the quickfix list
    (see [The Gutter](gutter.md))

## Auto Completion

* **Tool**: `terraform-ls` via `CoC`, on Terraform files
* **Configuration**: Configured in `coc-settings.json`
* **Features**: Variable completion, resource type completion, attribute
    completion

## Formatting and Beautification

* **Tool**: `terraform fmt` via `ALE`, on Terraform and HCL files
* **Configuration**: Set as the buffer's fixer in `terraform.vim` and
    `hcl.vim`, so the trailing-whitespace fixers every other file gets do not
    run here
* **Usage**: Automatically formats code on save or manually with `:ALEFix`

## Code Folding

Both `terraform.vim` and `hcl.vim` set `foldmethod=syntax`, so blocks fold.

## Comment Support

Both `terraform.vim` and `hcl.vim` set `commentstring` to `# %s`, with a
space after the `#`.

## Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Error Highlighting (handled by ALE)
* Schema or Contract Validation (handled by `terraform-ls`)
* Version Control Integration (uses global Git integration)
* Snippets (not configured specifically for Terraform)
* Filetype Detection (handled by `vim-polyglot`)

[terraform.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/ftplugin/terraform.vim
[hcl.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/after/ftplugin/hcl.vim
