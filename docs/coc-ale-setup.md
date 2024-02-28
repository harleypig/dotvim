## ALE and CoC Setup

### External Packages Used

To utilize CoC and ALE as configured in this repository, the following
external packages must be installed:

* [Node.js](https://nodejs.org/) - A JavaScript runtime built on Chrome's V8
    JavaScript engine, required for running the CoC extension host.
* [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/) - Package
    managers for JavaScript, used to install CoC extensions.

#### Node.js Installation Options

For installing Node.js, you can either:

* Use nvm (Node Version Manager) to install and manage multiple Node.js versions.
* Use the nodesource repository to install a specific version of Node.js.
* npm or yarn: Used to install CoC extensions.

### Plugins and Extensions Used

The following plugins and extensions are utilized by ALE and CoC within this repository:

* [ALE](https://github.com/dense-analysis/ale) - An Asynchronous Lint Engine
    for Vim and Neovim.
* [CoC](https://github.com/neoclide/coc.nvim) - Conquer of Completion, an
    intellisense engine for Vim/Neovim with LSP support.

### Configuration Files Used

Configuration for ALE and CoC is managed through the following files:

* [`ale.vim`](.vim/pack/settings/start/settings/plugin/ale.vim) - Contains
    ALE-specific Vimscript settings, such as disabling linting when CoC is
    active, setting linting behaviors, and defining ALE fixers.
* `coc-settings` - Use `:CocConfig` to edit this file.

### Syntax Highlighting

Syntax highlighting in Vim is typically handled by the editor's built-in features and is enhanced by various plugins. CoC can also provide additional syntax highlighting through its extensions, which may offer more advanced features like semantic highlighting based on language server information.

For languages supported by CoC extensions, syntax highlighting is automatically managed and updated as you type, reflecting the real-time understanding of the code structure by the language server.

In this setup, no additional Vim plugins are specifically dedicated to syntax highlighting, as the default Vim syntax highlighting and CoC extensions are deemed sufficient. If any language-specific plugins are used for syntax highlighting, they would be documented in the respective `ftplugin` files for each language.

