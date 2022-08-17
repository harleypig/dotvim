# VIm Dotfiles

This repo holds my vim dotfiles and plugins.

To install, link **$HOME/.vim** and **$HOME/.vimrc** to this repository's
files of the same name.

I am currently migrating plugins from the pathogen **bundle** directory to
vim's builtin **pack** method.

!!! Fix these:

* .vim/bundle/cscope_macros: submodule

## How do I?

* toggle between no line numbers, relative line numbers and plain line numbers?

## Plugins

Plugins that have earned permanent status. These are stored in
**.vim/pack/&lt;category&gt;/&lt;plugin&gt;/start**.

Any settings for plugins (with some very rare exceptions) will be in the
**.vim/pack/active/mystuff/start** plugin directory, wherever it's supposed to fit.

### mystuff

My configuration for various of the plugins that need it.

XXX: Add notes/reminders about the directory structure and what should go
     where.

### statusline

My status line setup.

XXX: Add notes about what is being done here (or maybe do that in the plugin?)

### Categories

#### General (Active)

* [tabular](https://github.com/godlygeek/tabular.git)
* [vim-endwise](https://github.com/tpope/vim-endwise.git)
* [vim-eunuch](https://github.com/tpope/vim-eunuch.git)
* [vim-repeat](https://github.com/tpope/vim-repeat.git)
* [vim-surround](https://github.com/tpope/vim-surround.git)
* [vim-unimpaired](https://github.com/tpope/vim-unimpaired.git)

#### Applications

* [coc.nvim](https://github.com/neoclide/coc.nvim.git)
* [jupyter-vim](https://github.com/jupyter-vim/jupyter-vim)
* [vim-fake](https://github.com/tkhren/vim-fake.git)
* [vim-fugitive](https://github.com/tpope/vim-fugitive.git)
* [vim-healthcheck](https://github.com/rhysd/vim-healthcheck.git)
* [vim-man](https://github.com/vim-utils/vim-man.git)
* [vimwiki](https://github.com/vimwiki/vimwiki.git)

#### DrChip's Stuff

* [Align](https://github.com/vim-scripts/Align.git)
* [AnsiEsc](https://github.com/vim-scripts/AnsiEsc.vim.git)
* [AutoAlign](https://github.com/vim-scripts/AutoAlign.git)

##### Evaluate

* [WhereFrom](https://www.drchip.org/astronaut/vim/index.html#WHEREFROM)
* [AutoAlign](https://www.drchip.org/astronaut/vim/index.html#AUTOALIGN)

#### Linter

* [mccabe](https://github.com/PyCQA/mccabe)
* [syntastic](https://github.com/scrooloose/syntastic.git)
* [vim-flake8](https://github.com/nvie/vim-flake8)
* [vim-lint](https://github.com/dbakker/vim-lint.git)
* [vim-sleuth](https://github.com/tpope/vim-sleuth.git)

#### Syntax

* [apiblueprint](https://github.com/kylef/apiblueprint.vim.git)
* [awk](https://github.com/vim-scripts/awk.vim)
* [jq](https://github.com/vito-c/jq.vim.git)
* [MatchTag](https://github.com/gregsexton/MatchTag.git)
* [nginx](https://github.com/chr4/nginx.vim)
* [SimpylFold](https://github.com/tmhedberg/SimpylFold.git)
* [vim-colorschemes](https://github.com/flazz/vim-colorschemes.git)
* [vim-irssi-syntax](https://github.com/isundil/vim-irssi-syntax.git)
* [vim-terraform](https://github.com/hashivim/vim-terraform.git)
* [vim-yaml](https://github.com/stephpy/vim-yaml)

#### Being Tested

* [ale](https://github.com/dense-analysis/ale.git)
* [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim.git)
* [FastFold](https://github.com/Konfekt/FastFold.git)
* [vim-devicons](https://github.com/ryanoasis/vim-devicons.git)
* [vim-jdaddy](https://github.com/tpope/vim-jdaddy.git)
* [vim-markdown](https://github.com/preservim/vim-markdown.git)
* [vim-speeddating](https://github.com/tpope/vim-speeddating.git)

#### To Be Moved

* [cscope_macros](https://github.com/vim-scripts/cscope_macros.vim.git)

#### To Be Tested

* [ansible-vim](https://github.com/pearofducks/ansible-vim.git)
* [astroid](https://github.com/PyCQA/astroid)
* [async](https://github.com/prabirshrestha/async.vim.git)
* [asyncomplete](https://github.com/prabirshrestha/asyncomplete.vim.git)
* [asyncomplete-lsp](https://github.com/prabirshrestha/asyncomplete-lsp.vim.git)
* [autopep8](https://github.com/hhatto/autopep8)
* [bats](https://github.com/aliou/bats.vim)
* [black](https://github.com/ambv/black)
* [bufexplorer](https://github.com/jlanzarotta/bufexplorer.git)
* [bufferize](https://github.com/AndrewRadev/bufferize.vim.git)
* [calendar](https://github.com/itchyny/calendar.vim)
* [csv](https://github.com/chrisbra/csv.vim.git)
* [ctrlp-funky](https://github.com/tacahiroy/ctrlp-funky.git)
* [ctrlp](https://github.com/ctrlpvim/ctrlp.vim)
* [delimitMate](https://github.com/Raimondi/delimitMate.git)
* [gitv](https://github.com/gregsexton/gitv)
* [hledger-vim](https://github.com/anekos/hledger-vim.git)
* [indentLine](https://github.com/Yggdroot/indentLine.git)
* [ledger](https://github.com/vim-scripts/ledger.vim.git)
* [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
* [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin.git)
* [nerdtree](https://github.com/preservim/nerdtree.git)
* [nerdtree-project-plugin](https://github.com/scrooloose/nerdtree-project-plugin.git)
* [onestatus](https://github.com/narajaon/onestatus.git)
* [perlomni](https://github.com/c9s/perlomni.vim.git)
* [pycodestyle](https://github.com/PyCQA/pycodestyle)
* [pydocstyle](https://github.com/PyCQA/pydocstyle)
* [pyflakes](https://github.com/PyCQA/pyflakes)
* [pylama](https://github.com/klen/pylama)
* [pylint](https://github.com/PyCQA/pylint)
* [rainbow](https://github.com/luochen1990/rainbow.git)
* [rope](https://github.com/python-rope/rope)
* [snowball_py](https://github.com/diraol/snowball_py)
* [supertab](https://github.com/ervandew/supertab.git)
* [tagbar](https://github.com/preservim/tagbar.git)
* [taglist](https://github.com/vim-scripts/taglist.vim.git)
* [targets](https://github.com/wellle/targets.vim.git)
* [tmuxline](https://github.com/edkolev/tmuxline.vim.git)
* [toml](https://github.com/uiri/toml.git)
* [traces](https://github.com/markonm/traces.vim.git)
* [ttags_vim](https://github.com/tomtom/ttags_vim.git)
* [ultisnips](https://github.com/SirVer/ultisnips.git)
* [undotree](https://github.com/mbbill/undotree.git)
* [vim-abolish](https://github.com/tpope/vim-abolish.git)
* [vim-asterisk](https://github.com/haya14busa/vim-asterisk.git)
* [vim-autoclose](https://github.com/Townk/vim-autoclose.git)
* [vim-autotag](https://github.com/craigemery/vim-autotag)
* [vim-characterize](https://github.com/tpope/vim-characterize.git)
* [vim-commentary](https://github.com/tpope/vim-commentary.git)
* [VimCompletesMe](https://github.com/ackyshake/VimCompletesMe.git)
* [vim-conflicted](https://github.com/christoomey/vim-conflicted.git)
* [vim-dadbod](https://github.com/tpope/vim-dadbod.git)
* [vim-db](https://github.com/tpope/vim-db.git)
* [vim-diff-enhanced](https://github.com/chrisbra/vim-diff-enhanced.git)
* [vim-dirvish](https://github.com/justinmk/vim-dirvish.git)
* [vim-dispatch](https://github.com/tpope/vim-dispatch.git)
* [vim-docker-tools](https://github.com/kevinhui/vim-docker-tools)
* [vim-easytags](https://github.com/xolox/vim-easytags.git)
* [vim-ExtractMatches](https://github.com/inkarkat/vim-ExtractMatches.git)
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter.git)
* [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags.git)
* [vim-indent-rainbow](https://github.com/adi/vim-indent-rainbow.git)
* [vim-ingo-library](https://github.com/inkarkat/vim-ingo-library.git)
* [vim-jsbeautify](https://github.com/maksimr/vim-jsbeautify.git)
* [vim-LanguageTool](https://github.com/dpelle/vim-LanguageTool.git)
* [vim-lion](https://github.com/tommcdo/vim-lion.git)
* [vim-lsp-ale](https://github.com/rhysd/vim-lsp-ale.git)
* [vim-lsp](https://github.com/prabirshrestha/vim-lsp.git)
* [vim-lsp-settings](https://github.com/mattn/vim-lsp-settings.git)
* [vim-markify](https://github.com/dhruvasagar/vim-markify)
* [vim-misc](https://github.com/xolox/vim-misc.git)
* [vim-notes-cli](https://github.com/rhysd/vim-notes-cli.git)
* [vim-OnSyntaxChange](https://github.com/inkarkat/vim-OnSyntaxChange.git)
* [vim-pathogen](https://github.com/tpope/vim-pathogen.git)
* [vim-perl](https://github.com/vim-perl/vim-perl.git)
* [vim-python-pep8-indent](https://github.com/hynek/vim-python-pep8-indent)
* [vim-pythonsense](https://github.com/jeetsukumaran/vim-pythonsense.git)
* [vim-qf](https://github.com/romainl/vim-qf.git)
* [vim-qlist](https://github.com/romainl/vim-qlist.git)
* [vim-rsi](https://github.com/tpope/vim-rsi.git)
* [vim-sensible](https://github.com/tpope/vim-sensible.git)
* [vim-showmarks](https://github.com/jacquesbh/vim-showmarks.git)
* [vim-signify](https://github.com/mhinz/vim-signify.git)
* [vim-sneak](https://github.com/justinmk/vim-sneak.git)
* [vim-snippets](https://github.com/honza/vim-snippets.git)
* [vimspector](https://github.com/puremourning/vimspector.git)
* [vim-superman](https://github.com/jez/vim-superman.git)
* [vim-tmux](https://github.com/tmux-plugins/vim-tmux.git)
* [vimux](https://github.com/preservim/vimux.git)
* [vim-virtualenv](https://github.com/jmcantrell/vim-virtualenv)
* [vim-visual-multi](https://github.com/mg979/vim-visual-multi)
* [yapf](https://github.com/google/yapf)

#### Rejected

* [docker-compose](https://github.com/skanehira/docker-compose.vim)
* [evervim](https://github.com/kakkyz81/evervim.git)
* [gitolite](https://github.com/tmatilai/gitolite.vim.git)
* [gitv](https://github.com/gregsexton/gitv)
* [vim-github](https://github.com/thinca/vim-github.git)
* [vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides.git)
* [vim-rsi](https://github.com/tpope/vim-rsi.git)
* [DrawIt](https://github.com/vim-scripts/DrawIt.git)

## Resources

### VIm

* [VIm Homepage](https://www.vim.org/)
* [VIm Help](https://www.vimhelp.org/)
* [VIm Script Search](https://www.vim.org/scripts/script_search_results.php)
* [VIm Wiki](https://vim.fandom.com/wiki/Vim_Tips_Wiki)
* [VIm FAQ](https://github.com/chrisbra/vim_faq/)
* [VIm Awesome](https://vimawesome.com/)

### Github

* [nerd fonts](https://github.com/ryanoasis/nerd-fonts)
* [overview](https://microsoft.github.io/language-server-protocol/overviews/lsp/overview/)

### Reddit

* [which_lsp_plugin_should_i_use](https://www.reddit.com/r/vim/comments/7lnhrt/which_lsp_plugin_should_i_use/)
* [a_guide_to_lsp_auto_completion_in_vim](https://www.reddit.com/r/vim/comments/b33lc1/a_guide_to_lsp_auto_completion_in_vim/)
* [must have?](https://www.reddit.com/r/vim/comments/ulphgp/what_are_your_musthave_vimnvim_extensions/)

### Miscellaneous

* [vim-clangd](http://aliquote.org/post/vim-clangd/)
* [clangd.llvm.org](https://clangd.llvm.org/)
* [langserver.org](https://langserver.org/)
* [spell-and-grammar-checking-on-vim](https://ncona.com/2018/12/spell-and-grammar-checking-on-vim/)
* [setting up lsp in vim](https://ncona.com/2021/12/setting-up-lsp-in-vim)