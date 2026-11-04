# Bats

This document outlines the support for [Bats][bats] test files within the
Vim environment.

Bats files have no setup of their own. Vim gives a file ending in `.bats`
the `sh` filetype, as a Bash script, and everything in
[Shell Scripting](shell.md) then applies to it: bash-language-server and
shellcheck through CoC, and shfmt through ALE on save.

## Formatting and Beautification

ALE passes shfmt the file's name, and shfmt reads a `.bats` name as the
Bats dialect: `@test` blocks are formatted instead of being rejected as a
syntax error.

## Filetype Detection

Vim recognises Bats files by the `.bats` extension only. A file without it
gets no filetype, even with a `#!/usr/bin/env bats` line.

## Default or Inapplicable Sections

Every other section is as in [Shell Scripting](shell.md), and nothing in
this configuration is set for Bats alone.

[bats]: https://github.com/bats-core/bats-core
