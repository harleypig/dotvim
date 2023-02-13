---
title: Filesystem Setup
---

## .vimrc

[Search order for .vimrc](https://github.com/vim/vim/issues/2034#issuecomment-484668414) is

```vim
~/.vimrc
~/.vim/vimrc
```

Put `.vimrc` in `.vim` and remove the link from the home directory.

XXX: Modify checklinks to look for files/links that should NOT exist.
