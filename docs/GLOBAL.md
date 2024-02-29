# Global Defaults

This file serves a dual purpose: it documents global defaults across languages
and configurations for human reference, and it also provides instructions for
AI systems to understand and apply these settings. It does **not** document
plugin defaults. For plugin-specific settings, refer to the respective plugin
documentation.

## Plugins

Plugins enhance Vim's functionality. They should be considered for their
additional features beyond native Vim capabilities. If a plugin also manages
Vim settings for convenience, that is acceptable but not the primary reason
for its use.

CoC provides real-time, or 'as you type', features like linting and
auto-completion, while ALE focuses on asynchronous linting and auto-fixing
tasks such as 'format on save'. In cases where other plugins may conflict or
override CoC or ALE functionalities, it should be documented in the
language-specific sections. Indicate whether CoC and/or ALE was used and if
the overlapping plugin features were disabled, or vice versa, to maintain
clear and intended behavior.

### CoC

[CoC](https://github.com/neoclide/coc.nvim) (Conquer of Completion) is a Vim
plugin that offers an `intellisense engine` with real-time, or 'as you type',
features like linting and auto-completion. It leverages language servers for
these capabilities.

Settings for this plugin should be in
[coc.vim](../.vim/pack/settings/start/settings/plugin/coc.vim) and settings
for extensions should be in `coc-settings` (use `:CocConfig` to edit this
file).

### ALE

[ALE](https://github.com/dense-analysis/ale) (Asynchronous Lint Engine) is
a Vim plugin for asynchronous linting and formatting. It supports a wide range
of linters and formatters, which can be configured to operate on file save or
in the background.

Settings for this plugin should be in
[ale.vim](../.vim/pack/settings/start/settings/plugin/ale.vim). Settings for
a specific file type should be in
`.vim/pack/settings/start/settings/ftplugin/filetype.vim` (where
`filetype.vim` is `json.vim` for json, etc.).

### vim-polyglot

`vim-polyglot` aggregates language-specific Vim plugins into a single package
for enhanced syntax highlighting, indentation, and more. It's optimized for
performance, loading only needed plugins. Care should be taken to avoid
feature overlap with plugins like CoC and ALE. For details, visit the
[vim-polyglot](https://github.com/sheerun/vim-polyglot) Github page.

## Special Windows

For purposes of this document, we're only concerned with quickfix and
location list windows.

Errors (syntax, linting, compiling, etc.) should go in location list windows.
CoC and ALE are configured to follow this convention; double check when making
changes this is not altered.

## TODO

* Define and document the configuration and mappings that apply globally,
    ensuring they are clear and actionable for both human and AI
    implementation.
