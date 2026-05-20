# dotvim TODO

## High Priority

- [ ] **Create `docs/vim.md`** — Document the Vim language support setup:
  `coc-vimlsp` extension, why the manual `languageserver.vimls` block in
  `coc-settings.json` was removed (redundant with the extension), and the
  `vim-language-server` npm binary requirement.

- [ ] **Migrate to Claude global setup** — Add `.claude/` directory with
  `WORKFLOW.md` and `CONVENTIONS.md` so Claude Code sessions have project
  context. Evaluate what currently lives in `docs/GLOBAL.md` and
  `docs/CONVENTIONS.md` and decide what moves to `.claude/` vs stays as
  human-facing documentation. Follow the three-tier model in the global
  `CLAUDE.md` for scope decisions.

## General Improvements

- [ ] **Audit undocumented language setups** — Cross-check installed
  plugins/extensions against files in `docs/`. Any language with an
  ftplugin or coc extension but no corresponding doc file needs one.
  Known gap: `vim.md` (tracked above).

- [ ] **Audit `coc-settings.json` for redundancy** — Review all entries
  in `languageserver` against installed `coc-*` extensions. Remove manual
  language server blocks where a CoC extension already manages the same
  server. The `vimls` block was the first found; others may exist.

- [ ] **Review `docs/` path references** — Existing docs (e.g., `python.md`)
  reference `../.vim/pack/settings/start/settings/...` but the actual
  directory is `zzz-settings`. Correct all broken relative links.

- [ ] **Add `.editorconfig`** — Codify indentation and line-ending
  conventions so contributors without the full vim setup get consistent
  defaults automatically.

## Future

- [ ] Create tests before migrating.

- [ ] **Migrate to Neovim** — Evaluate replacing vim + coc.nvim + ALE with
  Neovim's native LSP (`nvim-lspconfig`) and a modern plugin ecosystem
  (lazy.nvim, nvim-cmp, conform.nvim, nvim-lint). Key questions to answer
  before starting:
  * Which coc extensions have direct Neovim LSP equivalents?
  * Can the existing `after/ftplugin/` files be reused as-is?
  * What is the migration path for `coc-settings.json` settings?
  * Should migration be a clean break or an incremental dual-config period?
