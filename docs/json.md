## JSON

For working with JSON files in this repository, the following external packages are configured and need to be installed:

- **jq**: A lightweight and flexible command-line JSON processor.
- **eslint**: A pluggable and configurable linter tool for identifying and reporting on patterns in JavaScript.

These packages are used by the ALE plugin for linting and formatting JSON files as specified in the `.vim/pack/settings/start/settings/ftplugin/json.vim` configuration file.

### CoC Extensions Required for JSON

The current configuration requires the following CoC extensions and Vim plugins to be installed for JSON support:

- `coc-json`: For JSON language support and features like schema validation and auto-completion.

### Vim Plugins for JSON

The following Vim plugins are used for enhanced JSON editing:

- `vim-jq`: Provides syntax highlighting for JSON and integration with the `jq` tool.
- `jsonc.vim`: Sets the filetype to `jsonc` for `.jsonc` files and provides syntax highlighting for JSON with comments.
