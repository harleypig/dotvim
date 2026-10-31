# Tools to Try

This document lists external writing-check and formatting tools that could
be added to the Vim environment. None of them is set up yet.

## Formatting

* [dprint][dprint] - Formatter for many languages from one tool.

## Grammar and Style Checking

* [LanguageTool][languagetool] - Grammar and style checking for
  documentation and comments. Would need configuring for technical
  terminology. The vim-LanguageTool plugin is listed in
  [Plugins to Try][plugins-to-try].
* [write-good][write-good] - Suggests plain-language improvements.
* [textlint][textlint] - Pluggable text linting.
* [Vale][vale] - Customizable style checking.
* [GNU diction and style][diction] - Flags wordy or misused phrases
  (`diction`) and reports readability measures (`style`). Could be wired
  into CoC through [coc-diagnostic][coc-diagnostic], which is already
  installed (see [CoC Extensions][coc-extensions]), or into ALE or
  vim-polyglot.

Proselint, from the same research, is already set up; see
[Proselint][proselint].

[dprint]: https://dprint.dev/
[languagetool]: https://languagetool.org/
[write-good]: https://github.com/btford/write-good
[textlint]: https://textlint.github.io/
[vale]: https://vale.sh/
[diction]: https://www.gnu.org/software/diction/
[coc-diagnostic]: https://github.com/iamcco/coc-diagnostic
[plugins-to-try]: plugins-to-try.md
[coc-extensions]: coc-extensions.md
[proselint]: proselint.md
