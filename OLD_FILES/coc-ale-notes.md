# Using coc.nvim and ALE together

ALE has a good paragraph on the [subject](https://github.com/dense-analysis/ale#faq-coc-nvim):

- ALE is primarily focused on integrating with external programs through
  virtually any means, provided the plugin remains almost entirely written
  in Vim script.
- coc.nvim is primarily focused on bringing IDE features to Vim.

# coc.nvim

########################################################################

## Incorporate

prereqs

- must have node installed
- must have yarn installed
- in directory coc is install run

  - yarn install

- add a way to dump cocinfo to README
- look for extensions here

  - https://www.npmjs.com/search?q=keywords%3Acoc.nvim
  - https://vi.stackexchange.com/questions/39382/how-can-i-export-a-list-of-coc-extensions-and-install-it-on-another-machine
  - ~/.config/coc/extensions

- evaluate gnu diction and style for coc, ale, or polyglot?

  - https://www.gnu.org/software/diction/
  - docs: https://github.com/iamcco/coc-diagnostic

- use tab for autocomplete (if not already)

  - https://stackoverflow.com/questions/67370086/how-to-remap-coc-nvim-autocomplete-key

- implement this

  - https://stackoverflow.com/questions/61694504/how-to-make-coc-show-linting-popup-no-matter-where-the-cursor-is-on-the-line

- implement this (have tab trigger completion like enter, use ctrl-n/p to
  scroll through list (or hjkl?)

  - https://vi.stackexchange.com/a/37720

- mebbe:

  - https://vi.stackexchange.com/questions/26927/how-do-i-view-the-linting-errors

- change .coc-extensions.yml (rename?)

  - top level entries should be language support
  - docker:
    coc-extension: none
    requires:
    url: - https://github.com/rcjsuen/dockerfile-language-server-nodejs
    install:
    archlinux: pacman -S docker-language-server
    config: ?

    terraform:
    coc-extension: none
    requires:
    url: - https://github.com/hashicorp/terraform-ls
    install:
    archlinux: pacman -S terraform-ls

- modules

  - click: https://click.palletsprojects.com/
  - click plugins: https://github.com/orgs/click-contrib/repositories
  - click-params: https://click-params.readthedocs.io/en/latest/usage/domain/#url
  - click-aliases: https://github.com/click-contrib/click-aliases
  - click-option-group: https://click-option-group.readthedocs.io/en/stable/index.html
  - click-completion: https://github.com/click-contrib/click-completion
  - click-configfile: https://github.com/click-contrib/click-configfile
  - click-help-colors: https://github.com/click-contrib/click-help-colors

- bash completion https://click.palletsprojects.com/en/8.1.x/shell-completion/

- Possibly use the following text in the readme:

Welcome to the Git Plugin Manager command-line tool. This tool allows you to
manage your VIm plugins using Git submodules. You can use this tool to add,
move, and remove plugins, as well as view information about your plugins using
the `readme` and `learning` commands.

To use this tool, make sure you have Python and Git installed on your system,
and activate the virtual environment using `source venv/bin/activate`. You can
then run the tool using the `git-plugin` command, followed by a command and
any necessary arguments.

For more information on how to use this tool, please refer to the command help
pages by running `git-plugin --help` or `git-plugin <command> --help`.
