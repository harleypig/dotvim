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
tasks such as 'format on save'. Ensure changes maintain this distinction.

### CoC

`CoC` (Conquer of Completion) is a Vim plugin that offers an intellisense
engine with features like linting and auto-completion. It leverages language
servers for these capabilities and should be configured to avoid overlapping
with vim-polyglot's features. Careful setup is required to prevent conflicts,
especially if vim-polyglot provides similar functionalities for a language.
For detailed information, visit the
[CoC](https://github.com/neoclide/coc.nvim) Github page.

### ALE

`ALE` (Asynchronous Lint Engine) is a Vim plugin for asynchronous linting and
formatting. It supports a wide range of linters and formatters, which can be
configured to operate on file save or in the background. When integrating ALE
with vim-polyglot, ensure configurations do not overlap to prevent feature
conflicts. ALE is not Vim's default lint manager and should be enabled only
when specified. For additional details, refer to the
[ALE](https://github.com/dense-analysis/ale) Github page.

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
