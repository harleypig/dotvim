## Docker

This document outlines the support for Docker development within the Vim environment.

Note: The configuration leverages CoC for language server features and vim-polyglot for syntax highlighting, providing a streamlined experience for working with Dockerfiles.

### External Packages Used

Install via npm:
* [`dockerfile-language-server-nodejs`](https://github.com/rcjsuen/dockerfile-language-server-nodejs) - Language server that provides intelligent code completion, validation, and other language features for Dockerfiles.

### VIm Plugins Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) - Provides enhanced syntax highlighting for Dockerfiles.

### CoC Extensions Used

* [`coc-docker`](https://github.com/josa42/coc-docker) (CoC Extension) - Provides Docker integration for CoC.

### Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration for the Dockerfile language server.

### Configured Features

#### Syntax Highlighting
Provided by vim-polyglot, which includes enhanced support for Dockerfile syntax highlighting.

#### Auto Completion
* **Tool**: `dockerfile-language-server` via `CoC`
* **Configuration**: Configured in `coc-settings.json`
* **Features**: Directive completion, instruction completion, context-aware suggestions

#### Linting and Validation
* **Tool**: `dockerfile-language-server` via `CoC`
* **Configuration**: Configured in `coc-settings.json`
* **Features**: Syntax validation, best practices checking

### Default or Inapplicable Sections

The following features use default settings without additional configuration:
* Error Highlighting (handled by CoC)
* Code Folding (uses Vim's default folding mechanisms)
* Formatting (not specifically configured for Dockerfiles)
* Snippets (not configured specifically for Dockerfiles)
* Schema Validation (not applicable for Dockerfiles)
* Documentation Tools (not configured specifically for Dockerfiles)
* Debugging Support (not configured specifically for Dockerfiles)
* Testing Tools (not applicable for Dockerfiles)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by `vim-polyglot`)
