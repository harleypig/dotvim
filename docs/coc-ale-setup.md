## ALE and CoC Setup

### External Packages Used

To utilize CoC and ALE as configured in this repository, the following
external packages must be installed:

* [`Node.js`](https://nodejs.org/) - A JavaScript runtime built on Chrome's V8
    JavaScript engine, required for running the CoC extension host.
* [`npm`](https://www.npmjs.com/) or [`yarn`](https://yarnpkg.com/) - Package
    managers for JavaScript, used to install CoC extensions.

#### Node.js Installation Options

For installing Node.js, you can either:

* Use nvm (Node Version Manager) to install and manage multiple Node.js versions.
* Use the nodesource repository to install a specific version of Node.js.

##### Installing nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | PROFILE='/dev/null' bash
# Or using wget
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | PROFILE='/dev/null' bash
```

You will need to reload your bash setup (assuming you're using my `dotfiles`
configuration):
```bash
source ~/.bash_profile
```

Then install Node.js:
```bash
nvm install --lts  # Install latest LTS version
nvm use --lts      # Use the installed LTS version
```

##### Installing npm and yarn

**npm:**
npm comes bundled with Node.js. After installing Node.js using nvm, npm will be available.

To verify:
```bash
npm --version
```

**yarn:**
```bash
# Install yarn using npm
npm install -g yarn

# Verify installation
yarn --version
```

### VIm Plugins Used

The following plugins are utilized by ALE and CoC within this repository:

* [`ALE`](https://github.com/dense-analysis/ale) - An Asynchronous Lint Engine
    for Vim and Neovim.
* [`CoC`](https://github.com/neoclide/coc.nvim) - Conquer of Completion, an
    intellisense engine for Vim/Neovim with LSP support.

### Configuration Files Used

Configuration for ALE and CoC is managed through the following files:

* [`ale.vim`](../.vim/pack/settings/start/settings/plugin/ale.vim) - Contains
    ALE-specific Vimscript settings.
* [`coc.vim`](../.vim/pack/settings/start/settings/plugin/coc.vim) - Contains
    CoC-specific Vimscript settings.
* `coc-settings` - Use `:CocConfig` to edit this file.

#### Settings for CoC

* Diagnostic settings are configured to integrate with ALE, enabling virtual
    text diagnostics and customizing their appearance and behavior.
* Preferences for CoC are set to disable automatic formatting on save, check
    for extension updates daily, and use quickfix for navigation.
    Additionally, auto-updating of the current function symbol is enabled, and
    signature help is disabled.
* Visual enhancements include enabling colors and aligning columns in lists,
    as well as enabling status line progress notifications.

#### Settings for CoC.vim

The `coc.vim` file configures key mappings and behaviors for using CoC
(Conquer of Completion) effectively within Vim. Here's a breakdown of the
settings:

* `<Tab>` key in insert mode: This key is used for multiple purposes based on
    the context. If the completion popup is visible, it navigates to the next
    item. If Copilot suggestions are available, it accepts the suggestion.
    Otherwise, it either inserts a tab character or triggers the completion
    depending on whether the cursor is at the start of a line or not.
* `<CR>` (Enter key) in insert mode: This key confirms the selected completion
    item from the popup if it's visible. If not, it simply inserts a new line.
* `<C-Space>` in insert mode: This keybinding is used to manually trigger the
    completion popup, but only if Copilot is not active.
* `gd`, `gy`, `gi`, `gr` in normal mode: These mappings are shortcuts for "go
    to" commands provided by CoC, allowing quick navigation to definitions,
    type definitions, implementations, and references of the symbol under the
    cursor, respectively.

#### Settings for ALE

The ALE settings in the `ale.vim` file are grouped to optimize the plugin's
behavior and integration with CoC.

LSP features are disabled to prevent conflicts with CoC's LSP capabilities.

Linters are disabled to prevent conflicts with CoC's linting configuration.

Virtual text for inline error messages is disabled for a cleaner editing
interface.

Automatic fixing on file save is enabled.

ALE fixers are set up to clean up whitespace and other formatting issues
across various file types.

`<leader>fb` mapping is provided for triggering fixes manually.
