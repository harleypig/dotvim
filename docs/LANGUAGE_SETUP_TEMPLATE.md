# [NAME]

This document outlines the support for [NAME] development within the Vim
environment.

Note: Prefer Vim's built-in functionality when available. Document why external
tools were chosen over built-in options when applicable. Include rationale for
tool selection or changes if multiple solutions were evaluated.

<!--
Section names and their order come from CONVENTIONS.md. Keep only the
sections that have something to document; list the rest under "Default or
Inapplicable Sections".
-->

## External Packages Used

Install via `pipx`:

* [package-name](link) - Brief description of the package and its purpose.
    Include installation method (prefer pipx over pip where applicable).

Install via `npm`:

* [package-name](link) - Brief description of the package and its purpose.
    Include installation method (prefer pipx over pip where applicable).

Install via package manager:

* [package-name](link) - Brief description of the package and its purpose.
    Include installation method (prefer pipx over pip where applicable).

Install manually:

### package-name

Instructions on how to install manually (wget, curl, install, etc.)

## Plugins and Extensions Used

* [plugin-name](link) (Vim Plugin) - Brief description including supported
    features (e.g., linting, completion, syntax).
* [extension-name](link) (CoC Extension) - Brief description including
    supported features. Install with `:CocInstall extension-name`.

## Configuration Files Used

For CoC-based configuration:

* `coc-settings` - Use `:CocConfig` to edit this file.

For ALE-based configuration:

* [`ale.vim`][ale.vim] - Global ALE configuration
* [`filetype.vim`][ftplugin] - Language-specific ALE settings, in
    `after/ftplugin/`

Additional configuration files:

* [filename](https://github.com/harleypig/dotvim/blob/master/path/to/file) -
    Purpose and scope of the configuration

## Syntax Highlighting

One section per feature that needs specific configuration, named and
ordered as in the *Remaining Possible Sections* list in `CONVENTIONS.md`
(this one is the first). Each feature section covers:

* Tools/plugins used
* Configuration details
* Relevant key combinations and usage (if not obvious)

## Default or Inapplicable Sections

List features that:

* Use default settings without modification
* Are not applicable to this language/environment
* Are handled by listed plugins/extensions without additional configuration

[ale.vim]: https://github.com/harleypig/dotvim/blob/master/.vim/pack/zzz-settings/start/settings/plugin/ale.vim
[ftplugin]: https://github.com/harleypig/dotvim/tree/master/.vim/pack/zzz-settings/start/settings/after/ftplugin
