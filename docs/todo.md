# Stuff to do

## Setup

* ansible
* azure pipelines
* bash
* bats
* docker
* json
* packer
* python
* terraform
* yaml

## Setup script

* run update stuff first
* coc branch needs to be manually checked out to the release branch
  + submodule tracking checks out the hash as a detached head which doesn't
      seem to work

## Update

* git submodule update --init --recursive --remote
    + need to fix coc branch?

## Toggles

* What is available to be in the gutter?

### pastetoggle

This seems like it has issues.

### COPY mode toggle

Steal
[this](https://github.com/timakro/vim-copytoggle/blob/master/plugin/copytoggle.vim).

Add a statusline notifier.

## Configuration Consistency

* Standardize ALE fix key mappings:
  + Currently have both `<leader>f` in maps.vim and `<leader>fb` in ale.vim
  + Choose one approach: either keep both for flexibility or standardize on one mapping
