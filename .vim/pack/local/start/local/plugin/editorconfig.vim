" work with fugitive, dont load with files opened by scp
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

au FileType gitcommit let b:EditorConfig_disable = 1

" Experimenting with these settings

" lines exceeding maxwidth will be highlighted
let g:EditorConfig_max_line_indicator = 'exceeding'

" I like my format options, does this need to be 0?
let g:EditorConfig_preserve_formatoptions = 1
