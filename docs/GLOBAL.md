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

CoC (Conquer of Completion) is a Vim plugin that offers an intellisense engine with features like linting and auto-completion. It leverages language servers for these capabilities and should be configured to avoid overlapping with vim-polyglot's features. Careful setup is required to prevent conflicts, especially if vim-polyglot provides similar functionalities for a language. For detailed information, visit the [CoC GitHub page](https://github.com/neoclide/coc.nvim).

### ALE

ALE (Asynchronous Lint Engine) is a plugin for Vim that provides asynchronous
linting and formatting. It can use a variety of linters and formatters, some
of which may be included in the language packs provided by vim-polyglot. ALE
can be configured to fix issues on save or to lint files in the background. It
can work well with vim-polyglot, but careful configuration may be required to
ensure they work together smoothly. For instance, ALE should be configured to
avoid conflicts with any linting or formatting features that vim-polyglot
might provide for a particular language.  formatting in an asynchronous
manner. It is not the default lint manager in Vim and should not be enabled by
default unless specified. For more information, see the
[ALE](https://github.com/dense-analysis/ale) Github page.

### vim-polyglot

vim-polyglot is a collection of language packs for Vim, providing
a comprehensive suite of language-specific features such as syntax
highlighting, indentation, and other editor enhancements. It aggregates
various language-specific Vim plugins into a single package, making it easier
to manage and install support for multiple languages. vim-polyglot is designed
to be lightweight and loads only the necessary plugins for the files you are
working on, which helps to keep Vim's performance optimized. When using
vim-polyglot with other plugins like CoC and ALE, ensure that there is no
overlap in functionality that could lead to conflicts. For more information,
see the [vim-polyglot](https://github.com/sheerun/vim-polyglot) Github page.

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
