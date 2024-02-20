#!/bin/bash

# This script moves language-specific plugins to their own .vim/pack/lang directory.

# Move vim-polyglot to the new location
mkdir -p .vim/pack/lang/syntax/start
if [ -d ".vim/pack/syntax/start/vim-polyglot" ]; then
    mv .vim/pack/syntax/start/vim-polyglot .vim/pack/lang/syntax/start/
fi

# Move jsonc.vim to the new location
mkdir -p .vim/pack/lang/plugins/start
if [ -d ".vim/pack/plugins/start/jsonc" ]; then
    mv .vim/pack/plugins/start/jsonc .vim/pack/lang/plugins/start/
fi

# Move vim-toml to the new location
mkdir -p .vim/pack/lang/testing/start
if [ -d ".vim/pack/testing/start/vim-toml" ]; then
    mv .vim/pack/testing/start/vim-toml .vim/pack/lang/testing/start/
fi

# Ensure the script is executable
chmod +x move-lang-plugins.sh
