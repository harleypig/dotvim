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

### Language servers

npm install:
* vim-language-server - Required for Vim script language support in CoC
* docker-langserver - Required for Dockerfile language support
* terraform-ls - Required for Terraform language support
* eslint - Required for JavaScript/JSON linting

pipx install:
* ansible-lint - Required for Ansible linting
* yamllint - Required for YAML linting
* ansible-language-server - Required for Ansible language support
* proselint - Required for prose/text linting
* vint - Required for Vim script linting

other packages:
* shellcheck - Required for shell script linting
* jq - Required for JSON formatting

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
