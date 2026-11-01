# Instructions for AI Assistants

These are the owner's standing instructions for AI tools working in this
repository. How the documentation is written is set out in
[CONVENTIONS.md](../CONVENTIONS.md).

Issue area labels are in [WORKFLOW.md](WORKFLOW.md); testing is in
[TESTS.md](TESTS.md).

## Global Defaults

These instructions cover global defaults across languages and
configurations. They do **not** cover plugin defaults; for plugin-specific
settings, refer to the respective plugin documentation.

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

[`CoC`](https://github.com/neoclide/coc.nvim) (Conquer of Completion) is a Vim
plugin that offers an `intellisense engine` with real-time, or 'as you type',
features like linting and auto-completion. It leverages language servers for
these capabilities.

Settings for this plugin should be in [coc.vim][coc.vim] and settings for
extensions should be in `coc-settings` (use `:CocConfig` to edit this file).

### ALE

[`ALE`](https://github.com/dense-analysis/ale) (Asynchronous Lint Engine) is
a Vim plugin for asynchronous linting and formatting. It supports a wide range
of linters and formatters, which can be configured to operate on file save or
in the background.

Settings for this plugin should be in [ale.vim][ale.vim]; settings that must
be in place before ALE loads go in the [early ale.vim][early-ale.vim].
Settings for a specific file type should be in
`.vim/pack/zzz-settings/start/settings/after/ftplugin/filetype.vim` (where
`filetype.vim` is `json.vim` for json, etc.).

### vim-polyglot

[`vim-polyglot`](https://github.com/sheerun/vim-polyglot) is a Vim plugin that
aggregates various language packs for enhanced syntax highlighting,
indentation, and more. It is optimized for performance by loading only the
necessary plugins for a given file type.

Settings for this plugin should be managed in a way that avoids conflicts with
other plugins providing similar features, such as CoC and ALE. Ensure that
`vim-polyglot` is configured to complement these plugins rather than compete
with them.

## Special Windows

For these instructions, only quickfix and location list windows matter.

Errors (syntax, linting, compiling, etc.) go in the quickfix list. ALE sends
its results there (`g:ale_set_quickfix` in the early `ale.vim`), CoC's
diagnostics reach it through ALE (`diagnostic.displayByAle` in
`coc-settings`), and the `c[` / `c]` mappings in `coc.vim` move through it.

[coc.vim]: ../.vim/pack/zzz-settings/start/settings/plugin/coc.vim
[ale.vim]: ../.vim/pack/zzz-settings/start/settings/plugin/ale.vim
[early-ale.vim]: ../.vim/pack/000-settings/start/settings/plugin/ale.vim
