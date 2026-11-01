# Repository Workflow

**Version:** v0.1.0

How work on this repository is tracked. Testing is in [TESTS.md][tests];
how the documentation is written is in [CONVENTIONS.md][conventions].

## Issue areas: the `area:*` register

Every issue that changes a file in this repository takes one `area:*`
label, saying where in the configuration the change lands. This register
is the definition of each label; `gh label list` is the inventory. The two
are kept in step, and a label is created only by the owner.

The set was read off this repository's own issues and tree, and the owner
picked it on 2026-10-31 (#57 - record the area label set).

### The labels

* `area:intellisense`: CoC and ALE. Completion, linting, fixing,
  diagnostics and how they reach the quickfix list: `.vim/coc-settings.json`,
  both `ale.vim` files (early and late settings), and `coc.vim` and
  `diagnostic-colors.vim` in the late settings. Also the CoC, ALE and
  no-Node lines in `.vimrc`, and `tests/vim/coc.bats`.
* `area:filetypes`: per-language setup. The late settings'
  `after/ftplugin/*.vim`, `checkfiletype.vim`, the per-language pages in
  `docs/` and `docs/LANGUAGE_SETUP_TEMPLATE.md`, and the Perl linter helpers
  in `tools/`. One language's linter settings land here; CoC and ALE
  settings shared by every language land in intellisense.
* `area:editor`: core editor behaviour. The rest of `.vimrc` and of the late
  settings: `set.vim`, `maps.vim`, the quickfix toggle, the statusline,
  gutter, colours, diff, XDG paths and in-editor help. Also `OLD_FILES/`,
  which is waiting to be merged.
* `area:plugin-submodules`: which third-party plugins are installed and from
  where. The submodules under `.vim/pack/` (every directory there except
  `000-settings` and `zzz-settings`, which are ours), `.gitmodules`, the
  to-try pages (`docs/*-to-try.md`), and the choice of plugin manager.
* `area:setup-scripts`: the `bin/` install and maintenance scripts, their
  tests in `tests/shell/`, and `docs/scripts.md`. Named after a kind of
  file, but kept because the scripts are a subsystem of their own.
* `area:repo-process`: how the repository itself is run. `CONVENTIONS.md`,
  `.claude/`, the docs plan (`docs/about-docs.md`), the lint and editor
  configs, CI (`.github/`), tags, branch protection and issue tracking.

The early settings are `.vim/pack/000-settings/start/settings/`, and the
late settings are `.vim/pack/zzz-settings/start/settings/`; the top-level
`early-settings` and `late-settings` links point at them.

### Placing an issue

* **One area per issue.** An issue that could take two takes the area where
  the fix lands, not the area it is about.
* **Documentation takes the area of what it describes.** A page changed
  because its subject changed rides with that subject; only work on the
  documentation as a whole (its plan, its structure) is `area:repo-process`.
* **A test takes the area of the code it guards.** `tests/vim/load.bats`
  covers the whole configuration, so a change to it takes the area of the
  settings file the change was made for.
* **There is no catch-all.** An issue that fits no area is split; if it
  cannot be split, it goes to the owner, who closes it, creates a new
  area, or places it in an existing one knowingly.
* **An issue that changes no file**, such as a question, need not carry an
  area. Nothing depends on an issue having one.

[tests]: TESTS.md
[conventions]: ../CONVENTIONS.md
