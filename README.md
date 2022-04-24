# .vim Files

This repo holds my vim dotfiles and plugins.

To install, link **$HOME/.vim** and **$HOME/.vimrc** to this repository's
files of the same name.

I am currently migrating plugins from the pathogen **bundle** directory to
vim's builtin **pack** method.

!!! Fix these:

* .vim/bundle/sshconfig: find
* .vim/bundle/timestamp: find
* .vim/bundle/cscope_macros: submodule

## Plugins

Plugins that have earned permanent status. These are stored in
**.vim/pack/<category>/<plugin>/start**.

Any settings for plugins (with some very rare exceptions) will be in the
**.vim/pack/active/mystuff/start** plugin directory, wherever it's supposed to fit.

#### mystuff

My configuration for various of the plugins that need it.

XXX: Add notes/reminders about the directory structure and what should go
     where.

#### statusline

My status line setup.

XXX: Add notes about what is being done here (or maybe do that in the plugin?)

#### How do I ...

* toggle between no line numbers, relative line numbers and plain line numbers?

### Categories

* active
* app
* drchip
* linter
* syntax
* test
* tobemoved
* tobetested

#### General (Active)

* [helpful](https://github.com/tweekmonster/helpful.vim.git)
* [linediff](https://github.com/AndrewRadev/linediff.vim.git)
* [tabular](https://github.com/godlygeek/tabular.git)
* [vim-endwise](https://github.com/tpope/vim-endwise.git)
* [vim-eunuch](https://github.com/tpope/vim-eunuch.git)
* [vim-repeat](https://github.com/tpope/vim-repeat.git)
* [vim-surround](https://github.com/tpope/vim-surround.git)
* [vim-unimpaired](https://github.com/tpope/vim-unimpaired.git)

#### Applications

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
* [spacehi](https://github.com/jpalardy/spacehi.vim.git)
* [vim-colorschemes](https://github.com/flazz/vim-colorschemes.git)
* [vim-irssi-syntax](https://github.com/isundil/vim-irssi-syntax.git)
* [vim-yaml](https://github.com/stephpy/vim-yaml)

### Being Tested

* [ale](https://github.com/dense-analysis/ale.git)
* [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim.git)
* [FastFold](https://github.com/Konfekt/FastFold.git)
* [vim-devicons](https://github.com/ryanoasis/vim-devicons.git)
* [vim-jdaddy](https://github.com/tpope/vim-jdaddy.git)
* [vim-markdown](https://github.com/preservim/vim-markdown.git)
* [vim-speeddating](https://github.com/tpope/vim-speeddating.git)

### To Be Moved

* [astroid](https://github.com/PyCQA/astroid)
* [async](https://github.com/prabirshrestha/async.vim.git)
* [autopep8](https://github.com/hhatto/autopep8)
* [bats](https://github.com/aliou/bats.vim)
* [black](https://github.com/ambv/black)
* [bufexplorer](https://github.com/jlanzarotta/bufexplorer.git)
* [bufferize](https://github.com/AndrewRadev/bufferize.vim.git)
* [calendar](https://github.com/itchyny/calendar.vim)
* [cscope_macros](https://github.com/vim-scripts/cscope_macros.vim.git)
* [gitv](https://github.com/gregsexton/gitv)
* [ledger](https://github.com/vim-scripts/ledger.vim.git)
* [perlomni](https://github.com/c9s/perlomni.vim.git)
* [pycodestyle](https://github.com/PyCQA/pycodestyle)
* [pydocstyle](https://github.com/PyCQA/pydocstyle)
* [pyflakes](https://github.com/PyCQA/pyflakes)
* [pylama](https://github.com/klen/pylama)
* [pylint](https://github.com/PyCQA/pylint)
* [snowball_py](https://github.com/diraol/snowball_py)
* [supertab](https://github.com/ervandew/supertab.git)
* [toml](https://github.com/uiri/toml.git)
* [ultisnips](https://github.com/SirVer/ultisnips.git)
* [vim-autoclose](https://github.com/Townk/vim-autoclose.git)
* [vim-autotag](https://github.com/craigemery/vim-autotag)
* [vim-conflicted](https://github.com/christoomey/vim-conflicted.git)
* [vim-db](https://github.com/tpope/vim-db.git)
* [vim-lsp](https://github.com/prabirshrestha/vim-lsp.git)
* [vim-notes-cli](https://github.com/rhysd/vim-notes-cli.git)
* [vim-pathogen](https://github.com/tpope/vim-pathogen.git)
* [vim-perl](https://github.com/vim-perl/vim-perl.git)
* [vim-python-pep8-indent](https://github.com/hynek/vim-python-pep8-indent)
* [vim-snippets](https://github.com/honza/vim-snippets.git)
* [vimspector](https://github.com/puremourning/vimspector.git)
* [vim-superman](https://github.com/jez/vim-superman.git)
* [vim-tmux](https://github.com/tmux-plugins/vim-tmux.git)
* [vim-virtualenv](https://github.com/jmcantrell/vim-virtualenv)

### To Be Tested

* [ansible-vim](https://github.com/pearofducks/ansible-vim.git)
* [asyncomplete](https://github.com/prabirshrestha/asyncomplete.vim.git)
* [asyncomplete-lsp](https://github.com/prabirshrestha/asyncomplete-lsp.vim.git)
* [csv](https://github.com/chrisbra/csv.vim.git)
* [ctrlp-funky](https://github.com/tacahiroy/ctrlp-funky.git)
* [ctrlp](https://github.com/ctrlpvim/ctrlp.vim)
* [delimitMate](https://github.com/Raimondi/delimitMate.git)
* [indentLine](https://github.com/Yggdroot/indentLine.git)
* [nerdcommenter](https://github.com/scrooloose/nerdcommenter)
* [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin.git)
* [nerdtree](https://github.com/preservim/nerdtree.git)
* [nerdtree-project-plugin](https://github.com/scrooloose/nerdtree-project-plugin.git)
* [onestatus](https://github.com/narajaon/onestatus.git)
* [rainbow](https://github.com/luochen1990/rainbow.git)
* [rope](https://github.com/python-rope/rope)
* [tagbar](https://github.com/preservim/tagbar.git)
* [taglist](https://github.com/vim-scripts/taglist.vim.git)
* [targets](https://github.com/wellle/targets.vim.git)
* [traces](https://github.com/markonm/traces.vim.git)
* [ttags_vim](https://github.com/tomtom/ttags_vim.git)
* [undotree](https://github.com/mbbill/undotree.git)
* [vim-abolish](https://github.com/tpope/vim-abolish.git)
* [vim-asterisk](https://github.com/haya14busa/vim-asterisk.git)
* [vim-characterize](https://github.com/tpope/vim-characterize.git)
* [vim-commentary](https://github.com/tpope/vim-commentary.git)
* [VimCompletesMe](https://github.com/ackyshake/VimCompletesMe.git)
* [vim-dadbod](https://github.com/tpope/vim-dadbod.git)
* [vim-diff-enhanced](https://github.com/chrisbra/vim-diff-enhanced.git)
* [vim-dirvish](https://github.com/justinmk/vim-dirvish.git)
* [vim-dispatch](https://github.com/tpope/vim-dispatch.git)
* [vim-docker-tools](https://github.com/kevinhui/vim-docker-tools)
* [vim-ExtractMatches](https://github.com/inkarkat/vim-ExtractMatches.git)
* [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags.git)
* [vim-indent-rainbow](https://github.com/adi/vim-indent-rainbow.git)
* [vim-ingo-library](https://github.com/inkarkat/vim-ingo-library.git)
* [vim-jsbeautify](https://github.com/maksimr/vim-jsbeautify.git)
* [vim-LanguageTool](https://github.com/dpelle/vim-LanguageTool.git)
* [vim-lion](https://github.com/tommcdo/vim-lion.git)
* [vim-lsp-ale](https://github.com/rhysd/vim-lsp-ale.git)
* [vim-lsp-settings](https://github.com/mattn/vim-lsp-settings.git)
* [vim-markify](https://github.com/dhruvasagar/vim-markify)
* [vim-OnSyntaxChange](https://github.com/inkarkat/vim-OnSyntaxChange.git)
* [vim-qf](https://github.com/romainl/vim-qf.git)
* [vim-qlist](https://github.com/romainl/vim-qlist.git)
* [vim-rsi](https://github.com/tpope/vim-rsi.git)
* [vim-sensible](https://github.com/tpope/vim-sensible.git)
* [vim-showmarks](https://github.com/jacquesbh/vim-showmarks.git)
* [vim-signify](https://github.com/mhinz/vim-signify.git)
* [vim-sneak](https://github.com/justinmk/vim-sneak.git)
* [vimux](https://github.com/preservim/vimux.git)
* [yapf](https://github.com/google/yapf)

### Rejected

* [docker-compose](https://github.com/skanehira/docker-compose.vim)
* [evervim](https://github.com/kakkyz81/evervim.git)
* [gitolite](https://github.com/tmatilai/gitolite.vim.git)
* [gitv](https://github.com/gregsexton/gitv)
* [vim-github](https://github.com/thinca/vim-github.git)
* [vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides.git)
* [vim-rsi](https://github.com/tpope/vim-rsi.git)
* [DrawIt](https://github.com/vim-scripts/DrawIt.git)

## Resources and Miscellaneous

* [vim-clangd](http://aliquote.org/post/vim-clangd/)
* [clangd.llvm.org](https://clangd.llvm.org/)
* [nerd fonts](https://github.com/ryanoasis/nerd-fonts)
* [langserver.org](https://langserver.org/)
* [overview](https://microsoft.github.io/language-server-protocol/overviews/lsp/overview/)
* [spell-and-grammar-checking-on-vim](https://ncona.com/2018/12/spell-and-grammar-checking-on-vim/)
* [setting up lsp in vim](https://ncona.com/2021/12/setting-up-lsp-in-vim)
* [which_lsp_plugin_should_i_use](https://www.reddit.com/r/vim/comments/7lnhrt/which_lsp_plugin_should_i_use/)
* [a_guide_to_lsp_auto_completion_in_vim](https://www.reddit.com/r/vim/comments/b33lc1/a_guide_to_lsp_auto_completion_in_vim/)