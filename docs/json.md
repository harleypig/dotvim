## JSON

### External Packages Used

* [ESLint](https://eslint.org/): A pluggable and configurable linter tool for
    identifying and reporting on patterns in JavaScript and related languages.
* [jq](https://stedolan.github.io/jq/): A lightweight and flexible
    command-line JSON processor that is used for formatting JSON files.

### Plugins and Extensions Used

The following plugins and extensions are used for JSON support in this development environment:

* [`coc-eslint`](https://github.com/neoclide/coc-eslint) (CoC Extension): Integrates ESLint into Vim, providing linting for JavaScript and related languages within the CoC framework.
*
* [`coc-json`](https://github.com/neoclide/coc-json) (CoC Extension): Provides JSON
language support including schema validation, auto-completion, and more. It is
a CoC extension and can be installed via the CoC extensions marketplace.

* [`vim-jq`](https://github.com/vito-c/jq.vim) (Vim Plugin): Provides syntax
highlighting for JSON and integration with the `jq` tool.

* [`jsonc.vim`](https://github.com/neoclide/jsonc.vim) (Vim Plugin): Sets the
filetype to `jsonc` for `.jsonc` files and provides syntax highlighting for
JSON with comments.

### Configuraiton Files Used

The following configuration files are used for JSON support in this development environment and adhere to the conventions:

* [`coc-settings.json`](../.vim/coc-settings.json): Use `:CocConfig` to edit this file. It contains the configuration for CoC extensions, including `coc-json` for JSON language support.
* [`ale.vim`](../.vim/pack/settings/start/settings/plugin/ale.vim): Specifies ALE fixers and linters for various file types, including JSON.
* [`json.vim`](../.vim/pack/settings/start/settings/ftplugin/json.vim): Configures ALE to use `jq` as a fixer for JSON files and sets up Vim folding for JSON syntax.
* [`.eslintrc.json`](../.eslintrc.json): Contains the ESLint configuration for linting JavaScript and related languages, including JSON.

### Language Server

The `coc-json` extension is the JSON language server. The defaults for this
extension are fine, so there are no settings to be documented.

### Auto Completion

The current configuration requires the following CoC extensions and Vim
plugins to be installed for JSON support:

* `coc-json`: For JSON language support and features like schema validation
    and auto-completion.

### Syntax Highlighting

The following Vim plugins are used for enhanced JSON editing:

* `vim-jq`: Provides syntax highlighting for JSON and integration with the
    `jq` tool.
* `jsonc.vim`: Sets the filetype to `jsonc` for `.jsonc` files and provides
    syntax highlighting for JSON with comments.

Note: While `jsonc.vim` provides syntax highlighting for JSONC files, full
language support features such as schema validation and auto-completion are
provided by the `coc-json` extension in conjunction with CoC. This ensures
a comprehensive editing experience for JSONC within Vim.

The `vim-jq` plugin provides syntax highlighting for JSON and integration with
the `jq` tool.

### Schema or Contract Validation

The configuration for JSON handling is spread across different files depending
on the tool:

* ALE Configuration: The ALE linter settings for JSON are located in
    `.vim/pack/settings/start/settings/ftplugin/json.vim`. This file specifies
    which linters and fixers ALE should use for JSON files.

* Vim Plugin Configuration: Vim plugin settings, such as those for
    `jsonc.vim` and `vim-jq`, are typically set in the plugin's own
    documentation or help files. For `jsonc.vim`, the relevant settings are in
    the plugin's repository README or within the plugin's Vim help tags.

### Linting and Static Analysis

Linting for JSON files is performed by `eslint`, which is configured in the
ALE settings within the `.vim/pack/settings/start/settings/ftplugin/json.vim`
file.

### Formatting and Beautification

The `jq` tool is configured as a fixer in ALE to format JSON files. This is
set up in the `.vim/pack/settings/start/settings/ftplugin/json.vim` file.

### Code Folding
