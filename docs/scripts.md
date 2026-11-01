# Scripts

The helper scripts in [`bin/`][bin]. Each one prints its usage with `-h` or
`--help` and exits without doing anything else, so `bin/<script> --help` is
the place to look for arguments and details. This page only says what each
script is for. Most of them expect to be run from the top of the
repository.

## Setting up a machine

* [`check-setup`][check-setup] - Reports the tools this setup expects that
  are missing (Node.js and npm, and linters for Ansible and Docker when
  those are installed), with install hints. Installs nothing.
* [`post-clone`][post-clone] - Sets up a fresh clone: fetches the plugin
  submodules, then installs Node.js, the npm and pipx tools, and the system
  packages this setup uses. Uses `sudo`.

## Managing plugin submodules

Plugins are git submodules. These scripts add, move and remove them, and
commit the change.

* [`addsubmodule`][addsubmodule] - Adds plugin repositories as submodules
  in a package under `.vim/pack/` (such as `100-core`), one commit each. The
  package must already exist; a plugin already in `.gitmodules` is skipped.
* [`mvsubmodule`][mvsubmodule] - Moves a submodule into a package under
  `.vim/pack/`, or back to `.vim/2btested/`.
* [`rmsubmodule`][rmsubmodule] - Removes a submodule completely, including
  its copy under `.git/modules`.
* [`set-submodule-branch`][set-submodule-branch] - Records the remote's
  default branch for every submodule that has none set.

## Other

* [`update-coc-extensions`][update-coc-extensions] - Rewrites
  `g:coc_global_extensions` in `.vimrc` from the CoC extensions installed on
  this machine, sorted by name. It reads them from `~/.config/coc/extensions`
  unless `COC_EXTENSIONS_DIR` names another directory, and writes nothing
  when none are installed.
* [`envsubstitute`][envsubstitute] - Replaces `%WORD%` in a string with the
  value of the environment variable `WORD` and prints the result.

## Testing

`bats tests/shell` runs the scripts' tests, including a check that each
`--help` exits before doing any work. See the [README][readme] for what the
tests need.

[bin]: https://github.com/harleypig/dotvim/tree/master/bin
[check-setup]: https://github.com/harleypig/dotvim/blob/master/bin/check-setup
[post-clone]: https://github.com/harleypig/dotvim/blob/master/bin/post-clone
[addsubmodule]: https://github.com/harleypig/dotvim/blob/master/bin/addsubmodule
[mvsubmodule]: https://github.com/harleypig/dotvim/blob/master/bin/mvsubmodule
[rmsubmodule]: https://github.com/harleypig/dotvim/blob/master/bin/rmsubmodule
[set-submodule-branch]: https://github.com/harleypig/dotvim/blob/master/bin/set-submodule-branch
[update-coc-extensions]: https://github.com/harleypig/dotvim/blob/master/bin/update-coc-extensions
[envsubstitute]: https://github.com/harleypig/dotvim/blob/master/bin/envsubstitute
[readme]: https://github.com/harleypig/dotvim/blob/master/README.md
