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



### ALE and CoC Configuration Settings

### Plugins and Extensions Used

The following plugins and extensions are utilized by ALE and CoC within this repository:

* [ALE](https://github.com/dense-analysis/ale) - An Asynchronous Lint Engine for Vim and Neovim.
* [CoC](https://github.com/neoclide/coc.nvim) - Conquer of Completion, an intellisense engine for Vim/Neovim with LSP support.

The settings for ALE and CoC are distributed across several files within this
repository.

Here is a broad overview of the configuration for ALE and CoC.


* ALE Settings: ALE settings are primarily located in
    `.vim/pack/settings/start/settings/plugin/ale.vim`. This file contains
    ALE-specific Vimscript settings such as disabling linting when CoC is
    active, setting linting behaviors, and defining ALE fixers.

* CoC Settings: CoC's main configuration is found in
    `.vim/coc-settings.json`, which is a JSON file that dictates the behavior
    of CoC features, including diagnostics display, formatting, and language
    server configurations.
