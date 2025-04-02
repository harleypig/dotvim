# Stuff to do

## GLOBAL documentation

* Define and document the configuration and mappings that apply globally,
    ensuring they are clear and actionable for both human and AI
    implementation.

## Document setup and configuration

* azure pipelines
* bats
* packer (in hashicorp.md)

## Toggles

* What is available to be in the gutter?

### pastetoggle

This seems like it has issues.

### COPY mode toggle

Steal
[this](https://github.com/timakro/vim-copytoggle/blob/master/plugin/copytoggle.vim).

Add a statusline notifier.

## Universal keybinds

### error/warning (and other) navigation

* Move to first error/warning in file
  - ALEFirst: no keybind by default
* Move to last error/warning in file
  - ALELast: <Plug>(ale_last)
* Move to next error/warning
  - ALENext: <Plug>(ale_next)
* Move to last error/warning
  - ALELast: <Plug>(ale_last)

### Show more details

* ale: ALEDetail to show full linter message

## CoC and ALE Enhancements

### CoC Extensions Management
* Add a way to dump cocinfo to README
* Create a tool to export/import CoC extensions between machines

### CoC UI Improvements
* Implement tab trigger completion like enter, with ctrl-n/p to scroll through list
  - Reference: https://vi.stackexchange.com/a/37720
* Make CoC show linting popup regardless of cursor position on the line
  - Reference: https://stackoverflow.com/questions/61694504/how-to-make-coc-show-linting-popup-no-matter-where-the-cursor-is-on-the-line

### Text Checking Tools Evaluation
* Evaluate dprint for multi-language formatting
  - https://dprint.dev/
* Evaluate LanguageTool for grammar and style checking in documentation and comments
  - Consider configuration for technical terminology
* Evaluate write-good for plain language improvements
* Research other text quality tools:
  - textlint for pluggable text linting
  - proselint for prose-specific linting
  - vale for customizable style checking

### Additional Tools Integration
* Evaluate GNU diction and style for CoC, ALE, or polyglot
  - https://www.gnu.org/software/diction/
  - Consider using coc-diagnostic: https://github.com/iamcco/coc-diagnostic

### Command Line Tools
* Consider implementing a Git Plugin Manager CLI tool using Click modules
  - Click: https://click.palletsprojects.com/
  - Useful Click plugins:
    - click-aliases: https://github.com/click-contrib/click-aliases
    - click-option-group: https://click-option-group.readthedocs.io/en/stable/index.html
    - click-completion: https://github.com/click-contrib/click-completion
    - click-configfile: https://github.com/click-contrib/click-configfile
    - click-help-colors: https://github.com/click-contrib/click-help-colors
