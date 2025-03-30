## CoC Extensions

This document outlines the CoC extensions installed in this Vim environment that aren't documented in language-specific files.

### Diagnostic Integration

#### coc-diagnostic

* **Extension**: [coc-diagnostic](https://github.com/iamcco/coc-diagnostic)
* **Purpose**: Provides a bridge between external linters/formatters and CoC
* **Features**: 
  - Integrates with diagnostic-languageserver
  - Enables linting for various file types
  - Supports custom linter configurations

* **Configuration**: Configured in `coc-settings.json` under the `diagnostic-languageserver` section
* **Current Usage**: Used for integrating proselint for text files and shellcheck for shell scripts

### Version Control Integration

#### coc-git

* **Extension**: [coc-git](https://github.com/neoclide/coc-git)
* **Purpose**: Provides Git integration within CoC
* **Features**:
  - Git status in the gutter
  - Git blame information
  - Git chunk navigation and operations
  - Commit browser

* **Configuration**: Currently disabled in `coc-settings.json` (commented out)
* **Potential Usage**: Could be enabled to provide Git information directly in the editor
* **Note**: Some functionality overlaps with vim-gitgutter and vim-fugitive

### Language Support

#### coc-toml

* **Extension**: [coc-toml](https://github.com/kkiyama117/coc-toml)
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

### Integration with Other Extensions

These extensions work together with language-specific extensions to provide a cohesive development environment:

* **coc-diagnostic** works with diagnostic-languageserver to provide linting for various file types
* **coc-git** can complement vim-fugitive and vim-gitgutter for Git operations
* **coc-toml** is useful for projects that use TOML for configuration, such as Rust and Python projects

### Default or Inapplicable Sections

These extensions use default settings without additional configuration beyond what's in `coc-settings.json`. No additional setup is required for basic functionality.
