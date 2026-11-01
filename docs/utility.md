# Utility Plugins

This document lists utility plugins that enhance the Vim experience by
providing specific functionalities. These utilities are documented here
because they are more specific in their application compared to global plugins
that affect the entire Vim environment.

## TODO

* Document utility plugins by providing:
  * A brief description of the plugin's functionality.
  * Any external requirements.
  * FIX (already installed): Instructions for installation and configuration.
  * Key mappings and commands, if applicable.
  * Links to official documentation or the plugin's homepage.

* Organize utility plugins into individual sections for clarity and detailed
    information.

## Existing Utility Plugins

The utility plugins installed in this Vim environment are the ones under
`.vim/pack/100-core/start/`:

* [`vim-eunuch`](https://github.com/tpope/vim-eunuch) (plugin): Vim commands
    for the Unix shell operations that need them most, such as `:Remove`,
    `:Move`, `:Chmod`, `:Mkdir` and `:SudoWrite`.
* [`vim-surround`](https://github.com/tpope/vim-surround) (plugin): mappings
    to delete, change and add surroundings in pairs, such as parentheses,
    brackets, quotes and XML tags.
* [`vim-repeat`](https://github.com/tpope/vim-repeat) (plugin): lets `.`
    repeat a whole plugin mapping, such as a vim-surround change, instead of
    only the last native command inside it.

[`vim-colorschemes`](https://github.com/EvitanRelta/vim-colorschemes), a collection
of colorschemes, is also installed, under `.vim/pack/400-ui/start/`. No
`colorscheme` command selects one of them, so Vim starts with its default
colorscheme; a comment in `colors.vim` names norwaytoday, which the collection
includes, but nothing loads it.

gitgutter, fzf and fugitive are not installed. Git change signs in the gutter
come from the coc-git extension instead (see [The Gutter](gutter.md) and [CoC
Extensions](coc-extensions.md)); fzf and vim-fugitive are on [Plugins to
Try](plugins-to-try.md).
