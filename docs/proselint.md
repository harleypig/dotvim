# proselint

## Installation and Sources

Probably need to `pip install proselint`.

- [Repository](https://github.com/amperser/proselint)

ArchLinux's `proselint` package won't install; use the pip install method.

$Work won't let me use 'universe' for ubuntu, so need to use the pip install
method there too.

Probably should just stick with the pip install method all around.

There is no `coc-proselint` (yet) so see Configuration below for details.

## Configuration

See this
[discussion](https://github.com/neoclide/coc.nvim/discussions/2028#discussioncomment-198844)
for `coc` configuration details.

There's not a whole lot to configure though, as far as calling the program
itself. See `coc-settings.json` for what is currently being used for setup.

As for the [configuration file](https://github.com/amperser/proselint#checks)
itself, the order of search is the following (I think):

- $XDG_CONFIG_HOME/proselint/config.json
- $HOME/.config/proselint/config.json
- $XDG_CONFIG_HOME/proselint/config.json (legacy)
- $HOME/.proselintrc.json (legacy)

Additionally, proselint has the `--config` option which I'm using to make it
easier to manage.
