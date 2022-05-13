# VIm as IDE

* abbreviations
* autoformatting (pretty code)
* code review
* colorscheme
* debugging
* diff
* file browser
* gutter
* lint
* make
* marks
* snippets
* tab (also, project management)

## Syntax

### Syntax Highlighting

```vim
syntax on|off
```

### Syntax Checking

* Syntastic

## Indentation

```vim
set autoindent
set breakindent
set cindent
set smartindent
```

## Bounce Between Start/End Points

TBD

See matchit plugin

## Shell

TBD

## Tags

ctags/cscope for language other than c?

```vim
set tags=tagfile
```

* `Ctl+]` goes to function defintion
* `Ctl+t` returns to previous location

## Autocomplete/Autosuggest

* `Ctl+x Ctl+N` word completion
* `Ctl+x Ctl+L` line completion
* `Ctl+x Ctl+F` filename completion

??? Is `Ctl+[NLF]` above really `Ctl+Shift+[NLF]`?

## Resources

Ideas and code ripped off from:

* [jez.io Blog](https://blog.jez.io/)
* [SpaceVim](https://spacevim.org/)
* [TutorialsPoint - Learn VIm](https://www.tutorialspoint.com/vim/)
* [Vim as IDE (1)](https://vim.fandom.com/wiki/Using_vim_as_an_IDE_all_in_one)
* [Vim as IDE (2)](https://vim.fandom.com/wiki/Use_Vim_like_an_IDE)

### Whole Enchilada

* [Vista](https://github.com/liuchengxu/vista.vim/)
* [Janus](https://github.com/carlhuda/janus.git/)
* [spf133](https://github.com/spf13/spf13-vim.git/)

### Try

* [Navigate long wrapped lines like normal
    lines](https://github.com/jez/dotfiles/blob/eba0202443de6bcc171dbe6bc133fa9fe02357f7/vimrc#L100-L106)
* cabbrev help tab help
* [Tiny keymap that can replace a lot](https://www.reddit.com/r/vim/comments/umo2kt/tiny_keymap_that_can_replace_a_lot/)
