## TOML

This document outlines the support for TOML (Tom's Obvious, Minimal Language) development within the Vim environment.

Note: The configuration leverages CoC for language server features and vim-polyglot/vim-toml for syntax highlighting, providing a streamlined experience for working with TOML configuration files.

### External Packages Used

No additional external packages are required beyond what's already installed for CoC.

### Plugins and Extensions Used

* [`vim-polyglot`](https://github.com/sheerun/vim-polyglot) (Vim Plugin) - Provides basic syntax highlighting for TOML files.
* [`vim-toml`](https://github.com/cespare/vim-toml) (Vim Plugin) - Provides enhanced syntax highlighting specifically for TOML files.

### CoC Extensions Used

* [`coc-toml`](https://github.com/kkiyama117/coc-toml) (CoC Extension) - Provides language server support for TOML files.

### Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration for the TOML language server.

### Configured Features

#### Syntax Highlighting
Provided by both vim-polyglot and vim-toml, which include enhanced support for TOML syntax highlighting. The vim-toml plugin offers more specialized highlighting for TOML-specific constructs.

#### Auto Completion
* **Tool**: TOML language server via `coc-toml`
* **Configuration**: No specific configuration in `coc-settings.json`
* **Features**: Key completion, value suggestions based on schema (when available)

#### Schema Validation
* **Tool**: TOML language server via `coc-toml`
* **Features**: Validates TOML files against schemas when available
* **Common Use Cases**: 
  - Cargo.toml for Rust projects
  - pyproject.toml for Python projects
  - Various configuration files for tools and applications

### Default or Inapplicable Sections

The following features use default settings without additional configuration:
* Linting and Static Analysis (handled by the TOML language server)
* Error Highlighting (handled by CoC)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for TOML)
* Documentation Tools (not configured specifically for TOML)
* Debugging Support (not applicable for TOML)
* Testing Tools (not applicable for TOML)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by vim-polyglot and vim-toml)
