## JSON

For working with JSON files in this repository, the following external
packages are configured and need to be installed:

- **jq**: A lightweight and flexible command-line JSON processor.
- **eslint**: A pluggable and configurable linter tool for identifying and reporting on patterns in JavaScript.

These packages are used by the ALE plugin for linting and formatting JSON
files as specified in the
`.vim/pack/settings/start/settings/ftplugin/json.vim` configuration file.

### CoC Extensions Required for JSON

The current configuration requires the following CoC extensions and Vim
plugins to be installed for JSON support:

- `coc-json`: For JSON language support and features like schema validation and auto-completion.

### Vim Plugins for JSON

The following Vim plugins are used for enhanced JSON editing:

- `vim-jq`: Provides syntax highlighting for JSON and integration with the `jq` tool.
- `jsonc.vim`: Sets the filetype to `jsonc` for `.jsonc` files and provides syntax highlighting for JSON with comments.

Note: While `jsonc.vim` provides syntax highlighting for JSONC files, full
language support features such as schema validation and auto-completion are
provided by the `coc-json` extension in conjunction with CoC. This ensures
a comprehensive editing experience for JSONC within Vim.

### JSON Configuration Locations

The configuration for JSON handling is spread across different files depending on the tool:

- **ALE Configuration**: The ALE linter settings for JSON are located in `.vim/pack/settings/start/settings/ftplugin/json.vim`. This file specifies which linters and fixers ALE should use for JSON files.

- **CoC Configuration**: CoC settings for JSON, including language server settings, are found in `.vim/coc-settings.json`. This file contains the configuration for the `coc-json` extension and other language-specific settings.

- **Vim Plugin Configuration**: Vim plugin settings, such as those for `jsonc.vim` and `vim-jq`, are typically set in the plugin's own documentation or help files. For `jsonc.vim`, the relevant settings are in the plugin's repository README or within the plugin's Vim help tags.
