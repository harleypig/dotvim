# Global Defaults

This file serves a dual purpose: it documents global defaults across languages
and configurations for human reference, and it also provides instructions for
AI systems to understand and apply these settings. It does **not** document
plugin defaults. For plugin-specific settings, refer to the respective plugin
documentation.

## Plugins

As a general rule, if a setting is already set via a Vim setting (see [Vim
Help](https://vimhelp.org)), or can be set that way, that method should be
preferred. If a plugin is installed for other reasons (see vim-polyglot below)
and manages that setting that is acceptable.

As a general rule, CoC handles 'as you type' configuration (such as linting,
syntax errors, etc.), while ALE handles autofixing (e.g., 'format on save')
configuration. As you make changes, make sure this is not altered unless
absolutely necessary.

### CoC

CoC (Conquer of Completion) is a plugin for Vim that provides an intellisense
engine for Vim, which includes features like linting, auto-completion, and
more. It uses language servers to provide these features, and it can work
alongside the syntax highlighting and indentation provided by vim-polyglot.
CoC can be configured to respect the settings provided by vim-polyglot for
specific languages. However, it's important to ensure that there are no
conflicts between the settings and features provided by vim-polyglot and those
provided by CoC. For example, if vim-polyglot provides its own linting or
auto-completion for a language, you may need to disable those features in CoC
for that specific language to avoid duplication or conflicts.  intellisense
engine for Vim. It manages linting, auto-completion, and more.  For more
information, see the [CoC](https://github.com/neoclide/coc.nvim) Github page.

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
