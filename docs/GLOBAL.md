# Global Defaults

This file serves a dual purpose: it documents global defaults across languages
and configurations for human reference, and it also provides instructions for
AI systems to understand and apply these settings. It does **not** document
plugin defaults. For plugin-specific settings, refer to the respective plugin
documentation.

## CoC and ALE

* CoC (Conquer of Completion) is a plugin for Vim that provides an
    intellisense engine for Vim. It manages linting, auto-completion, and
    more.  For more information, see the [CoC GitHub
    page](https://github.com/neoclide/coc.nvim).
* ALE (Asynchronous Lint Engine) is a plugin for Vim that provides linting and
    formatting in an asynchronous manner. It is not the default lint manager
    in Vim and should not be enabled by default unless specified. For more
    information, see the [ALE GitHub
    page](https://github.com/dense-analysis/ale).

As a general rule, CoC handles linting and other 'as you type' configuration,
while ALE handles autofixing (e.g., 'format on save') configuration. As you
make changes, make sure this is not altered unless absolutely necessary.

### TODO

* Define and document the configuration and mappings that apply globally,
    ensuring they are clear and actionable for both human and AI
    implementation.

## Special Windows

For purposes of this document, we're only concerned with quickfix and
location list windows.

Errors (syntax, linting, compiling, etc.) should go in location list windows.
CoC and ALE are configured to follow this convention; double check when making
changes this is not altered.

### TODO

* Define and document the configuration and mappings that apply globally,
    ensuring they are clear and actionable for both human and AI
    implementation.
