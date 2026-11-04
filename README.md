# Vim Configuration

This repository contains a comprehensive Vim configuration with language
support, linting, and completion features.

## Requirements

### Vim

CoC (Conquer of Completion) needs Vim 9.0.0438 or later.

### Node.js

Node.js is needed for CoC and its extensions. Without `node` on `PATH`, Vim
still starts: CoC is switched off, and ALE and the rest of the configuration
work as usual.

* **Minimum version**: Node.js 16.18.0 or later, the oldest the installed
    CoC supports
* **Installation**:
  * **Arch Linux**: `pacman -S nodejs npm`
  * **Ubuntu 24.04 or later**: `apt install nodejs npm` (24.04 ships
      Node.js 18; 22.04 ships 12, below the minimum, so use nvm there)
  * **Alternative**: Use [Node Version Manager
      (nvm)](https://github.com/nvm-sh/nvm) for version management

### Other Dependencies

Additional language-specific tools are documented in their respective language
documentation files in the `docs/` directory.

## Setup

### Running it

Vim runs this configuration from the checkout; nothing is copied into
`~/.vim`. The plugins are git submodules, so fetch them first, then start
Vim with `XDG_DOTVIM` set to the checkout. From the top of the checkout:

```bash
git submodule update --init
export XDG_DOTVIM="$PWD"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
vim -N -u "$XDG_DOTVIM/.vimrc"
```

The other two `XDG_` values shown are the XDG defaults, which the settings
fall back to when either is unset or empty; set them only to choose other
directories. `-u` on its own leaves Vim in Vi-compatible mode, which this
`.vimrc` cannot load in, hence `-N`. A `~/.vimrc` symlinked to this
repository's `.vimrc` needs neither flag.

* `XDG_DOTVIM` puts the checkout's `.vim` directory at the front of
  `runtimepath` and `packpath`.
* `$XDG_STATE_HOME/vim` holds the backup, swap, undo and view directories
  and the viminfo file. `$XDG_DATA_HOME/vim` is netrw's home and holds a
  `spell` directory. Startup creates the directories.

### What it deletes

Every startup deletes files older than 90 days from the backup, swap, undo
and view directories under `$XDG_STATE_HOME/vim`, and deletes the viminfo
file there once it is older than 180 days. An old swap file is deleted
whether or not it was ever recovered.

### Checking and testing

Run `bin/check-setup` to verify that required tools are installed for your
development environment.

The scripts in `bin/` are listed in [docs/scripts.md](docs/scripts.md); each
one shows its usage with `--help`.

Run `bats tests/shell` to test the scripts in `bin/` (needs
[bats-core](https://github.com/bats-core/bats-core) with the bats-support and
bats-assert libraries).

Run `bats tests/vim` to test the Vim configuration in headless Vim. It needs
the plugin submodules checked out (`git submodule update --init`) and the
same bats libraries.

GitHub Actions runs both suites, and markdownlint over the repository's own
Markdown files, on every pull request to `master` and every push to it.
