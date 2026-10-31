# About These Docs

> **Working draft.** This page defines how the documentation in this
> repository is organized. It is provisional on purpose: the repository is
> being cleaned up one area at a time (`bin/`, `tools/`, `early-settings/`,
> `late-settings/`), and this page will be revised as each area teaches us
> something. Nothing here is settled until it stops saying "draft".

## Audiences

* **The owner, returning after months away.** Needs to find out quickly what
  is installed, why a choice was made, and how to get a new machine working.
  This is the primary reader.
* **A visitor browsing the public repository or site.** Wants to borrow a
  piece of configuration, so needs to know what a file does and what it
  depends on, without reading the whole setup.
* **A contributor or maintainer.** Needs the conventions, the backlog, and
  how to check that a change did not break anything.

## Kinds of doc and where each lives

| Kind | Home | Notes |
| ---- | ---- | ----- |
| Overview and requirements | `README.md` | Entry point on GitHub. Short; links out. |
| Docs front page | `docs/index.md` (proposed) | Front page of the published site; see *GitHub Pages*. |
| Per-language / per-tool setup | `docs/<name>.md` | One file per language or tool, built from the template. |
| Shared plugin setup (CoC, ALE, polyglot) | `docs/` | One home for facts every language page relies on. |
| Script and tool usage | each script's own `--help`, plus `docs/scripts.md` ([#10]) | Usage text lives with the code; the page lists the scripts and what each is for. |
| Design and rationale | a short "why" note in the relevant page | A separate decision-record directory only if a decision outgrows a paragraph. |
| Backlog | GitHub issues ([#7]) | No TODO file. Both former TODO files were emptied into issues and removed. |
| Research ("to try" lists) | `docs/extensions-to-try.md`, `docs/plugins-to-try.md`, `docs/tools-to-try.md` | Kept as research pages for now; see *Still open*. |
| Documentation conventions | `CONVENTIONS.md` | How docs are written. |
| Instructions for AI assistants | `.claude/CLAUDE.md` ([#11]) | Not part of the published docs. |
| In-editor reference | `late-settings/doc/*.txt` | Vim `:help` files; tags are built at startup and not committed. |

### `:help` versus the web pages

* **`:help`** holds what is needed *while editing*: mappings, commands,
  toggles, and short reminders. `late-settings/doc/learning.txt` (mappings
  and keystrokes) is the model.
* **The web pages** hold what is needed *before or around editing*: what to
  install, why a tool was chosen, and how the pieces fit together.

Neither is generated from the other. Mappings are the one area where both
carry the same content, so the mappings reference is written by hand during
the cleanup and kept in step by hand. Generating it (from `:help`, or from
the live mappings `bin/dump-maps` can show) is deferred to the improvements
phase ([#12]).

## Format conventions

* GitHub-flavored Markdown.
* Wrap prose at 78 columns. The markdownlint configuration at the
  repository root, `.markdownlint.yaml`, checks it ([#40]).
* Reference-style links, so the prose reads cleanly in a terminal.
* **Every doc starts with a level-1 (`#`) heading**, which the published
  site uses as the page title. `CONVENTIONS.md` says the same, and every
  page in `docs/` follows it ([#8]).
* `CONVENTIONS.md` is the authority for document structure: asterisks for
  bullets, document only non-default settings.
* **Every language or tool page follows one template**,
  `docs/LANGUAGE_SETUP_TEMPLATE.md`. Where it and `CONVENTIONS.md` disagreed
  on section names, `CONVENTIONS.md` won: one "Plugins and Extensions Used"
  section, then one section per configured feature, named from its list. The
  template and the language pages now follow that ([#9]).

## GitHub Pages

* **What is published:** the `docs/` directory, using GitHub Pages' default
  build (publish from a branch, `/docs` folder). No site generator has been
  chosen, so pages stay plain Markdown that the default build renders without
  any configuration file. Nothing is configured yet.
* **Front page:** the default build is expected to need an `index.md` (or
  `README.md`) in `docs/` to serve as the front page; there is none today.
  When one is added, it opens with the same "working draft" notice as this
  page, plus a short list of what the site covers.
* **Links outside `docs/`** (to files under `.vim/`, for example) point at
  the file on GitHub, because only `docs/` is published and a relative link
  would not resolve on the site. `CONVENTIONS.md` gives the URL form
  ([#13]).
* **Headings and generators.** Starting each page at level 1 suits the
  default build. If a site generator (MkDocs or another) is chosen later,
  re-check how it treats a page's first heading; [#8] stays open for that.
* **Room for a hub.** These pages may later be grouped with other public
  utility repositories under the owner's user site. Nothing here should
  assume it is the top of a site; keep links relative within `docs/`.

The two "expected" points above are assumptions about the default build,
to be verified when Pages is turned on; see *Still open*.

## Disposition of existing docs

Recorded when this draft was written; a row notes where an issue has since
been done. Smaller overlaps are left to the area-by-area pass. Lines over 78
columns were re-wrapped across `README.md` and `docs/` ([#40]); the few left
hold a link too long to break.

| File | Kind | Disposition |
| ---- | ---- | ----------- |
| `README.md` | Overview | Fine in shape. The Node.js minimum is written here and in two `docs/` pages; keep one home ([#14]). |
| `CONVENTIONS.md` | Conventions | Keep; the authority. Starting heading changed to level 1 ([#8]). Its reference to `GLOBAL.md` now points at `.claude/CLAUDE.md` ([#11]). |
| `TODO.md` | Backlog | Removed; its open items are GitHub issues ([#7]). |
| `docs/todo.md` | Backlog | Removed; its tasks are GitHub issues and its writing-tool research notes moved to `docs/tools-to-try.md` ([#7]). |
| `docs/GLOBAL.md` | AI-assistant instructions | Moved to `.claude/CLAUDE.md`, out of the published docs ([#11]); its human-facing part went to `coc-ale-setup.md`. Its broken links were fixed first ([#13]). |
| `docs/LANGUAGE_SETUP_TEMPLATE.md` | Template | Keep as the template; rewritten to match `CONVENTIONS.md` ([#9]). Broken path fixed ([#13]). |
| `docs/coc-ale-setup.md` | Shared plugin setup | Overlaps `README.md`. Now opens with how CoC and ALE divide the work, the human-facing part of `GLOBAL.md` ([#11]). |
| `docs/coc-extensions.md` | Tool setup | Fine; overlaps the installed list in `extensions-to-try.md`. Headings aligned with the template ([#9]). |
| `docs/extensions-to-try.md` | Research | Kept as a research page for now. Its "currently installed" list duplicates `coc-extensions.md`. |
| `docs/plugins-to-try.md` | Research | Kept as a research page for now. |
| `docs/tools-to-try.md` | Research | Added from the research notes in `docs/todo.md` ([#7]); kept as a research page like the other two. |
| `docs/utility.md` | Tool setup | Mostly a TODO; needs writing. |
| `docs/statusline.md` | Tool setup | Fine; check against the current statusline config. |
| `docs/vim-files.md` | Language setup | Fine in shape; broken paths fixed ([#13]). |
| `docs/ansible.md` | Language setup | Reworked to template ([#9]). |
| `docs/docker.md` | Language setup | Reworked to template ([#9]). |
| `docs/hashicorp.md` | Language setup | Reworked to template ([#9]). |
| `docs/html.md` | Language setup | Reworked to template ([#9]). |
| `docs/java.md` | Language setup | Closest to the bar; good model. Headings aligned with the template ([#9]). |
| `docs/json.md` | Language setup | Reworked to template ([#9]). |
| `docs/proselint.md` | Tool setup | Reworked to template ([#9]). |
| `docs/python.md` | Language setup | Reworked to template ([#9]); broken paths fixed ([#13]). |
| `docs/shell.md` | Language setup | Reworked to template ([#9]); broken paths fixed ([#13]). |
| `docs/toml.md` | Language setup | Reworked to template ([#9]). |
| `docs/yaml.md` | Language setup | Reworked to template ([#9]). |
| `docs/scripts.md` | Script usage | Added: lists the `bin/` scripts and what each is for; usage stays in each `--help` ([#10]). |
| `late-settings/doc/learning.txt` | `:help` | Keep; the model for in-editor docs. |

"Broken paths" means links to `.vim/pack/settings/start/settings/...`,
which does not exist. The real directories are `.vim/pack/000-settings/`
and `.vim/pack/zzz-settings/` (reachable as `early-settings/` and
`late-settings/`). Every such link, including three in pages not listed
above as broken (`coc-ale-setup.md`, `hashicorp.md`, `json.md`), now points
at the real file on GitHub ([#13]).

## Decisions

The questions an earlier version of this draft raised are answered on
[#6], and each answer that needs work has its own issue:

* Backlog: GitHub issues; both TODO files were emptied into them and
  removed ([#7]).
* Headings: docs start at level 1, rechecked once a site generator is
  chosen ([#8]).
* Template versus `CONVENTIONS.md`: `CONVENTIONS.md` wins; the template and
  the pages are rewritten to match ([#9]).
* Scripts in `bin/`: a `--help` in each, plus one summary page ([#10]).
* `docs/GLOBAL.md`: moved to `.claude/CLAUDE.md` ([#11]).
* Mappings reference: hand-written for now; generating it waits for the
  improvements phase ([#12]).
* Publishing the backlog: no longer a question, since there is no backlog
  file to publish.

Problems found while drafting are filed separately: the broken
`.vim/pack/settings/` links ([#13], fixed), the Node.js minimum written in
three places ([#14]), and bugs in `bin/check-setup` ([#15]).

### Still open

1. **The "to try" pages** (`docs/extensions-to-try.md`,
   `docs/plugins-to-try.md`, `docs/tools-to-try.md`): whether they stay as
   research pages, become issues, or go. They stay as research pages until
   that is decided.
2. **GitHub Pages defaults**: the index page and how pages without front
   matter are handled. Verified when Pages is turned on.

[#6]: https://github.com/harleypig/dotvim/issues/6
[#7]: https://github.com/harleypig/dotvim/issues/7
[#8]: https://github.com/harleypig/dotvim/issues/8
[#9]: https://github.com/harleypig/dotvim/issues/9
[#10]: https://github.com/harleypig/dotvim/issues/10
[#11]: https://github.com/harleypig/dotvim/issues/11
[#12]: https://github.com/harleypig/dotvim/issues/12
[#13]: https://github.com/harleypig/dotvim/issues/13
[#14]: https://github.com/harleypig/dotvim/issues/14
[#15]: https://github.com/harleypig/dotvim/issues/15
[#40]: https://github.com/harleypig/dotvim/issues/40
