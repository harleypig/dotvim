# Testing

**Version:** v0.1.0

What this repository tests, how, and where testing stops. The general bar
(success and failure paths, a regression test with every bug fix, never
silencing a failing test) applies unchanged; this file records only what is
specific to this repository.

## What counts as ours

Our code is what this repository writes:

* `bin/`, the install and maintenance scripts.
* `tools/`, the helper scripts and their configs.
* `.vimrc`.
* The early and late settings, which git tracks under
  `.vim/pack/000-settings/start/settings/` and
  `.vim/pack/zzz-settings/start/settings/`. The top-level `early-settings`
  and `late-settings` are links to them, so `git ls-files` lists the links
  and nothing beneath them; name or search the `.vim/pack/` paths.

## What is not tested

Vim itself, and the plugins. The plugins are third-party submodules under
`.vim/pack/`; their behaviour is their maintainers' to test, and a fault in
one is reported upstream or worked around in our settings.

## The grey area: where our code meets Vim or a plugin

We test what our code sets or calls, not what Vim or the plugin then does
with it. A test checks that a setting holds the value we gave it, that a
file loads without raising an error, or that a plugin is told what we meant
to tell it (for example, that CoC is told not to start without Node.js). It
does not check that Vim or the plugin then behaves correctly.

## Layout and runners

Both suites use [bats-core] with the bats-support and bats-assert libraries,
loaded with `bats_load_library`, so `BATS_LIB_PATH` must point at them.

* `tests/shell/`: the `bin/` scripts. Run with `bats tests/shell`. Each
  script runs with `PATH` holding stubs, so nothing installs packages,
  changes submodules or reaches the network.
* `tests/vim/`: the Vim configuration, in headless Vim started on this
  checkout's `.vimrc`, with `HOME` and the XDG directories inside the test's
  temporary directory. Run with `bats tests/vim`. It needs the plugin
  submodules checked out (`git submodule update --init`); Node.js is not
  needed, because the suite stubs it per test.

### Known departure: `tests/vim` rewrites help tags

A test run should leave the tree as it found it, and the Vim suite does
not quite. Every headless Vim it starts loads the late settings'
`after/plugin/helptags.vim`, which runs `helptags ALL` and rewrites the
`doc/tags` file of every package on the runtime path: our late settings
and the plugin submodules. Those files are ignored by git, so `git status`
stays clean, but they are rewritten all the same. This is recorded, not
yet fixed.

The same files make a test of help tags easy to write vacuously: a
`doc/tags` left by an earlier run satisfies a check that only asks whether
the file exists. Delete it first, or compare its modification time against
the start of the test.

## CI

The CI workflow runs three jobs on every pull request and every push to
`master`:

* **bats tests/shell**: runs the shell suite.
* **bats tests/vim**: checks out the submodules and runs the Vim suite. It
  prints the Vim version first, since CI's Vim differs from the local one
  (below).
* **markdownlint**: lints the repository's own tracked Markdown, not the
  plugins' docs, against `.markdownlint.yaml`.

Run the same commands locally before opening a pull request.

## Coverage

Coverage is measured to be read, never used as a pass threshold. A
percentage counts the lines a suite ran, not the faults it would catch, so
a threshold rewards running lines over checking behaviour. Nothing measures
coverage today; if a tool is added, its number is read alongside the
behaviours each test is meant to cover, and no job fails on it.

## Order

A test is written before the code it guards changes. For a bug fix, that
test fails against the code as it is, and passes once the fix is in.

## Local and CI environments differ

Three differences have each made a test behave one way locally and another
on CI. When a test behaves differently on CI, reproduce it in an
`ubuntu:24.04` container, the same release the CI runners use.

* **coreutils.** The main development host runs uutils coreutils; CI's
  runners run GNU coreutils. A fault in how a pipeline ends can reproduce
  only with the GNU tools first on `PATH`. On the development host they are
  installed as `gnutr`, `gnufold`, `gnuhead` and so on; a directory of links
  named `tr`, `fold`, `head` and so on, placed first on `PATH`, puts them in
  front.
* **Vim.** The local Vim is 9.1.2141; CI's is 9.1.0016. CI's Vim sets
  `v:errmsg` from its own `syntax/sh.vim`, even with `-u NONE`, so a test
  that reads `v:errmsg` can see an error on CI that our code did not raise.
* **SIGPIPE.** GitHub Actions starts each step with SIGPIPE ignored, which a
  terminal never does. Under GNU coreutils, a pipeline that reads an
  endless source and relies on SIGPIPE to stop it, such as one ending in
  `| head`, then never ends; that is how CI hung in #60 (#74 - build
  envsubstitute's delimiter without an endless read). CI runs the suites
  without a workaround for this, so the code must not depend on SIGPIPE.
  To reproduce, run a suite the way CI does, with the GNU tools first on
  `PATH`:

  ```sh
  bash -c "trap '' PIPE; exec bats tests/shell"
  ```

  Bound the run with `timeout`, so a hang ends as a failure.

[bats-core]: https://github.com/bats-core/bats-core
