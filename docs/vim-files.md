## Vim Files Configuration

This document outlines the plugins, extensions, and settings used specifically
for editing Vim configuration files within this development environment.

### Plugins and Extensions Used

coc-vimlsp

### Configuration Files Used

The following settings are specific to Vim script files and are set in the
`.vim/pack/settings/start/settings/ftplugin/vim.vim` file:

### Syntax Highlighting

Syntax highlighting for Vim script files is provided by Vim's built-in support
for the `vim` filetype.

### Linting and Static Analysis

- **ALE (Asynchronous Lint Engine)**: ALE is configured to use `vint` for
    linting Vim script files.

### Auto Completion

- **coc.nvim (Conqueror of Completion)**: CoC is configured with the
    `coc-vimlsp` extension to provide auto-completion for Vim script files.

### Error Highlighting

Error highlighting for Vim script files is provided by ALE with the `vint`
linter.
