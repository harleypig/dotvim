# Expertise Declaration

Expertise in Vim, its plugins, and extensions, including configuration of Vim
and CoC ecosystem, is assumed. Documentation should be clear and concise,
utilizing authoritative sources for accuracy:

* [Vim Help](https://vimhelp.org), Vim's official documentation
* [CoC](https://github.com/neoclide/coc.nvim) docs
* [ALE](https://github.com/dense-analysis/ale) docs
* [Vim Polyglot](https://github.com/sheerun/vim-polyglot) docs

Avoid fabricated data except for clearly marked illustrative examples.

Refer to `GLOBAL.md` for rules regarding global defaults and other
considerations.

## General Documentation Rules

Use asterisks (*) for bullet points in lists.

Start new documents with a level 2 heading (##) in Markdown.

Document only non-default settings; omit default behaviors.

Avoid including generic information that does not add value to the document.

Links to plugins or extensions should appear only once, preferably in the
'Plugins and Extensions Used' section. If text refers to documentation later
in the file (such as 'see XXX below') then it is ok to leave that as is.

All documentation must be written in valid Markdown format. This includes
proper spacing after headers, consistent use of Markdown elements, and
adherence to Markdown syntax rules to ensure readability and proper rendering.

Suggest including global plugins similar in scope to CoC, ALE, or vim-polyglot
in the `Expertise Declaration` with links to their homepages if discovered to
be installed during documentation and configuration.

Suggest including utility plugins similar in scope to gitgutter, fzf, or
fugitive, to `utility.md` with links to their homepages if discovered to be
installed during documentation and configuration.

## Possible Sections for Language and Configuration Documentation

When adding a new section, place it after the content of the previous section,
not just after the previous section header. This ensures a logical and
contiguous flow of information.

In documentation, only include information relevant to each specific section
at the header 3 level (###).

Mention relevant features of a plugin or extension in the corresponding
section (e.g., linting in "Linting and Static Analysis"). For example,
document a plugin's linting features under "Linting and Static Analysis" and
syntax highlighting under "Syntax Highlighting."

Keep information focused and relevant to the current section.

Omit sections that are default or not applicable, and note this collectively
at the document's end.

### External Packages Used

* Include each package name as a markdown link to the home page, and a brief
    description. Note: A language server is an external package.
* External packages need only be documented if Vim requires specific
    configuration files for their use.

### Plugins and Extensions Used

* Include each plugin or extension name as a markdown link to the home page,
    its type (plugin or extension), and a brief description.
* Note if a plugin or extension supports multiple languages or tasks (e.g.,
    language server, autoformatting, linting).

### Configuration Files Used

* List only relevant configuration files, including the name of the package,
    plugin, or extension being configured.
* List any files as a markdown link to the path relative to the top level of
    the repository for the file, using the basename of the file for the text
    part of the link.
* For `coc-settings.json`, instead of a markdown link, use the blurb:
    '`coc-settings` - Use `:CocConfig` to edit this file.' as its presence
    indicates it is being utilized.

### Remaining Possible Sections

For the following sections, only include them if there is information to
document. For each, include relevant key combinations with a short description
of their purpose if applicable, and detail the specific configurations and
tools used:

* Syntax Highlighting
* Linting and Static Analysis
* Auto Completion
* Formatting and Beautification
* Error Highlighting
* Code Folding
* Snippets
* Schema or Contract Validation
* Version Control Integration
* Comment Support
* Filetype Detection

### Default or Inapplicable Sections

Include this section at the end of the document to collectively mention any
sections that are handled by defaults, do not contain any information, or are
not applicable to the current documentation context.
