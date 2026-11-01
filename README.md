# Vim Configuration

This repository contains a comprehensive Vim configuration with language
support, linting, and completion features.

## Requirements

### Node.js

Node.js is needed for CoC (Conquer of Completion) and its extensions.
Without `node` on `PATH`, Vim still starts: CoC is switched off, and ALE and
the rest of the configuration work as usual.

* **Minimum version**: Node.js 14.14 or higher
* **Installation**:
  * **Arch Linux**: `pacman -S nodejs npm`
  * **Ubuntu**: `apt install nodejs npm`
  * **Alternative**: Use [Node Version Manager
      (nvm)](https://github.com/nvm-sh/nvm) for version management

### Other Dependencies

Additional language-specific tools are documented in their respective language
documentation files in the `docs/` directory.

## Setup

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
