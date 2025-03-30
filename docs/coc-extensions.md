## CoC Extensions

This document outlines the CoC extensions installed in this Vim environment that aren't documented in language-specific files.

### External Packages Used

No additional external packages are required for these extensions beyond what's already installed for CoC.

### Plugins and Extensions Used

No additional Vim plugins are required specifically for these extensions.

### CoC Extensions Used

* [`coc-diagnostic`](https://github.com/iamcco/coc-diagnostic) (CoC Extension) - Provides a bridge between external linters/formatters and CoC.
* [`coc-git`](https://github.com/neoclide/coc-git) (CoC Extension) - Provides Git integration within CoC.
* [`coc-toml`](https://github.com/kkiyama117/coc-toml) (CoC Extension) - Provides language server support for TOML files.

### Configuration Files Used

* `coc-settings` - Use `:CocConfig` to edit this file. Contains configuration for these extensions.

### Configured Features

#### Diagnostic Integration (coc-diagnostic)
* **Purpose**: Provides a bridge between external linters/formatters and CoC
* **Features**: 
  - Integrates with diagnostic-languageserver
  - Enables linting for various file types
  - Supports custom linter configurations
* **Configuration**: Configured in `coc-settings.json` under the `diagnostic-languageserver` section
* **Current Usage**: Used for integrating proselint for text files and shellcheck for shell scripts

#### Version Control Integration (coc-git)
* **Purpose**: Provides Git integration within CoC
* **Features**:
  - Git status in the gutter
  - Git blame information
  - Git chunk navigation and operations
  - Commit browser
* **Configuration**: Currently disabled in `coc-settings.json` (commented out)
* **Potential Usage**: Could be enabled to provide Git information directly in the editor
* **Note**: Some functionality overlaps with vim-gitgutter and vim-fugitive

#### TOML Language Support (coc-toml)
* **Purpose**: Provides language server support for TOML files
* **Features**:
  - Syntax validation
  - Auto-completion
  - Formatting
* **Configuration**: No specific configuration in `coc-settings.json`
* **Usage**: Provides basic language server features for TOML files
* **Common Use Cases**: 
  - Cargo.toml for Rust projects
  - pyproject.toml for Python projects
  - Configuration files for various tools

### Default or Inapplicable Sections

The following features use default settings without additional configuration:
* Syntax Highlighting (handled by vim-polyglot for TOML files)
* Error Highlighting (handled by CoC)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured specifically for these extensions)
* Schema Validation (not applicable for these extensions)
* Documentation Tools (not configured specifically for these extensions)
* Debugging Support (not configured specifically for these extensions)
* Testing Tools (not applicable for these extensions)
* Filetype Detection (handled by vim-polyglot for TOML files)
