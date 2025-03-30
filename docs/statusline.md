## Statusline Configuration

This document outlines the custom statusline configuration used in this Vim setup.

### Overview

The statusline provides a comprehensive view of the current editing state, including:

* Buffer information
* File status
* Linting/diagnostic information
* Cursor position
* Syntax highlighting information
* File permissions and path

### Features

#### Buffer and File Information
* Buffer number
* Current filetype
* Modification status (`+` for modified, `-` for unmodified, `X` for non-modifiable)
* File size (with automatic unit conversion)
* File format (only shown if not unix)
* File encoding (only shown if not utf-8)

#### Warning Indicators
* Mixed indentation warning
* Trailing space warning
* Paste mode indicator

#### Diagnostic Information
* ALE linter status (warning and error counts)
* CoC diagnostic information

#### Position Information
* Column and line position
* Percentage through file
* ASCII value under cursor (decimal and hexadecimal)
* Syntax highlighting group under cursor

#### Additional Information
* File permissions
* Full file path (truncated to 20 characters)

### Customization

The statusline appearance can be customized through several global variables:

```vim
" Filetype display when none is detected
let g:YASL_NoneFiletype = 'none'

" Modification indicators
let g:YASL_Modified = '+'
let g:YASL_NotModifiable = 'X'
let g:YASL_NotModified = '-'

" Warning text
let g:YASL_MixedIndentText = '[mixed indenting]'
let g:YASL_ExpandTabText = '[&et]'
let g:YASL_TrailingSpaceText = '[trailing space]'
let g:YASL_PasteMode = '[PASTE]'
let g:YASL_NoPasteMode = ''
```

### Color Scheme Integration

The statusline changes color based on the current mode:
* Normal mode: White background, Black text
* Insert mode: Yellow background, Blue text
* Command window: Gray background, Red text

### Functions

The statusline uses several custom functions to generate its components:

* `LinterStatus()` - Shows ALE linter warnings and errors
* `StatusDiagnostic()` - Shows CoC diagnostic information
* `YASL_FileSize()` - Formats file size with appropriate units
* `YASL_MixedIndentWarning()` - Detects and warns about mixed indentation
* `YASL_TrailingSpaceWarning()` - Detects and warns about trailing whitespace
* `YASL_IsModified()` - Shows file modification status
* `YASL_FileFormat()` - Shows file format if not unix
* `YASL_FileEncoding()` - Shows file encoding if not utf-8
* `YASL_PasteMode()` - Shows paste mode status
* `YASL_Filetype()` - Shows current filetype

### Integration with Plugins

The statusline integrates with:
* ALE - Shows linting errors and warnings
* CoC - Shows diagnostic information and current function
