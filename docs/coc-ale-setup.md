# ALE and CoC Setup

CoC and ALE divide the work. CoC provides the real-time, 'as you type',
features that come from language servers, such as completion and
diagnostics. ALE runs the linters and fixers configured for it, such as
formatting on save, and leaves language-server features to CoC. Where a
language page uses another plugin that overlaps either of them, the page
should say which one does the work and what was turned off.

## External Packages Used

To utilize CoC and ALE as configured in this repository, the following
external packages must be installed:

* [`Node.js`](https://nodejs.org/) - A JavaScript runtime built on Chrome's V8
    JavaScript engine, required for running the CoC extension host.
* [`npm`](https://www.npmjs.com/) or [`yarn`](https://yarnpkg.com/) - Package
    managers for JavaScript, used to install CoC extensions.

### Node.js Installation Options

For installing Node.js, you can either:

* Use nvm (Node Version Manager) to install and manage multiple Node.js
    versions.
* Use the nodesource repository to install a specific version of Node.js.

#### Installing nvm

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

#### Installing npm and yarn

**npm:** npm comes bundled with Node.js. After installing Node.js using nvm,
npm will be available.

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

## Plugins and Extensions Used

The following plugins are utilized by ALE and CoC within this repository:

* [`ALE`](https://github.com/dense-analysis/ale) - An Asynchronous Lint Engine
    for Vim and Neovim.
* [`CoC`](https://github.com/neoclide/coc.nvim) - Conquer of Completion, an
    intellisense engine for Vim/Neovim with LSP support.

## Configuration Files Used

Configuration for ALE and CoC is managed through the following files:

* [`ale.vim` (early)][early-ale.vim] - ALE settings that must be in place
    before ALE loads; most of ALE's behaviour is set here.
* [`ale.vim` (late)][ale.vim] - ALE's global fixers and the linter and fixer
    lists for file types that have no `after/ftplugin/` file yet.
* [`maps.vim`][maps.vim] - the `<leader>fb` mapping, among others.
* [`coc.vim`][coc.vim] - Contains
    CoC-specific Vimscript settings.
* `coc-settings` - Use `:CocConfig` to edit this file.

### Settings for CoC

* Diagnostics are handed to ALE for display (`diagnostic.displayByAle`),
    which turns off CoC's own diagnostic display. The `diagnostic.virtualText`
    settings in `coc-settings` therefore have no effect, and ALE's virtual
    text is disabled too, so no inline diagnostic messages appear.
* Preferences for CoC are set to disable automatic formatting on save, check
    for extension updates daily, and use quickfix for navigation.
    Additionally, auto-updating of the current function symbol is enabled, and
    signature help is disabled.
* Visual enhancements include enabling colors and aligning columns in lists,
    as well as enabling status line progress notifications.

### Settings for CoC.vim

The `coc.vim` file configures key mappings and behaviors for using CoC
(Conquer of Completion) effectively within Vim. Here's a breakdown of the
settings:

* `<Tab>` key in insert mode: if the completion popup is visible, it moves
    to the next item. Otherwise it inserts a tab when the cursor is at the
    start of the line or just after whitespace, and triggers completion
    anywhere else.
* `<CR>` (Enter key) in insert mode: This key confirms the selected completion
    item from the popup if it's visible. If not, it simply inserts a new line.
* `<C-Space>` in insert mode (mapped as `<C-@>`, which is what terminals send
    for it): triggers the completion popup.
* `<Tab>` and `<C-Space>` also check for Copilot, which is not installed, so
    those branches never apply.
* `gd`, `gy`, `gi`, `gr` in normal mode: These mappings are shortcuts for "go
    to" commands provided by CoC, allowing quick navigation to definitions,
    type definitions, implementations, and references of the symbol under the
    cursor, respectively.
* `c[` and `c]` in normal mode: move to the previous and next item in the
    quickfix list, where ALE's errors and warnings, CoC's included, are
    listed.

### Settings for ALE

ALE's settings are split between two files named `ale.vim`: the early one,
read before ALE loads, and the late one, read after.

The early `ale.vim` sets how ALE behaves:

* LSP features are disabled (`g:ale_disable_lsp`) to prevent conflicts with
    CoC's LSP capabilities.
* Only the linters listed for a file type run (`g:ale_linters_explicit`).
* Linting runs as you type in any mode (`g:ale_lint_on_text_changed`) and
    when you leave insert mode (`g:ale_lint_on_insert_leave`).
* Errors and warnings go to the quickfix list rather than the location list.
* Virtual text for inline error messages is disabled for a cleaner editing
    interface.
* Automatic fixing on file save is enabled.

The late `ale.vim` holds what ALE runs:

* For every file type, the fixers remove trailing blank lines at the end of
    the file and trailing whitespace.
* The linter and fixer lists for awk, Dockerfile, JSONC, Markdown,
    PowerShell, SQL, systemd, TOML and Vim help. Other file types set theirs
    in their `after/ftplugin/` file.

`<leader>fb` runs ALE's fixers on the current buffer (`<Plug>(ale_fix)`). It
is defined in `maps.vim`, not in either `ale.vim`.

[ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/ale.vim
[early-ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/000-settings/start/settings/plugin/ale.vim
[maps.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/maps.vim
[coc.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/coc.vim
