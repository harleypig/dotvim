## ALE and CoC Setup

ALE (Asynchronous Lint Engine) and CoC (Conqueror of Completion) are both
essential plugins for Vim that enhance the coding experience by providing
linting and intelligent code completion features. While ALE focuses on
asynchronous linting, allowing you to see errors and warnings in your code
without blocking the editor, CoC provides an Intellisense engine that powers
features like auto-completion, code navigation, and more. They differ in their
primary focus but can be configured to work together harmoniously within Vim.

### Required Packages for CoC and ALE

To use CoC and ALE as they are configured in this repository, the following
packages must be installed before attempting use these features:

- **Node.js**: Required for running the CoC extension host.
- **npm** or **yarn**: Used to install CoC extensions.

#### Node.js Installation Options

For installing Node.js, you can either:

- Use **nvm** (Node Version Manager) to install and manage multiple Node.js versions.
- Use the **nodesource** repository to install a specific version of Node.js.
- **npm** or **yarn**: Used to install CoC extensions.

### ALE and CoC Configuration Settings

The settings for ALE and CoC are distributed across several files within this
repository.

Here is a broad overview of the configuration for ALE and CoC.


- **ALE Settings**: ALE settings are primarily located in
    `.vim/pack/settings/start/settings/plugin/ale.vim`. This file contains
    ALE-specific Vimscript settings such as disabling linting when CoC is
    active, setting linting behaviors, and defining ALE fixers.

- **CoC Settings**: CoC's main configuration is found in
    `.vim/coc-settings.json`, which is a JSON file that dictates the behavior
    of CoC features, including diagnostics display, formatting, and language
    server configurations.
