## [NAME]

This document outlines the support for [NAME] development within the Vim environment.

Note: Prefer Vim's built-in functionality when available. Document why external
tools were chosen over built-in options when applicable. Include rationale for
tool selection or changes if multiple solutions were evaluated.

### External Packages Used

* [package-name](link) - Brief description of the package and its purpose.
    Include installation method (prefer pipx over pip where applicable).

### Plugins and Extensions Used

* [plugin-name](link) (Plugin/Extension type) - Brief description including
    supported features (e.g., linting, completion, syntax).

### Configuration Files Used

For CoC-based configuration:
* `coc-settings` - Use `:CocConfig` to edit this file.
* [coc-extension-name](link) - Install with `:CocInstall coc-extension-name`

For ALE-based configuration:
* [`ale.vim`](../.vim/pack/settings/start/settings/plugin/ale.vim) - Global ALE configuration
* [`filetype.vim`](../.vim/pack/settings/start/settings/ftplugin/filetype.vim) - Language-specific ALE settings

Additional configuration files:
* [filename](/path/to/file) - Purpose and scope of the configuration

### Configured Features

Document only features requiring specific configuration. Each feature should include:
* Tools/plugins used
* Configuration details
* Usage instructions (if not obvious)

Common features to document if configured:
* Syntax Highlighting
* Linting and Static Analysis
* Auto Completion
* Formatting
* Error Highlighting
* Code Folding
* Snippets
* Schema Validation
* Documentation Tools
* Debugging Support
* Testing Tools

### Default or Inapplicable Sections

List features that:
* Use default settings without modification
* Are not applicable to this language/environment
* Are handled by listed plugins/extensions without additional configuration
