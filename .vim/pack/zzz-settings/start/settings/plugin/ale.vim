" ----------------------------------------------------------------------------
" ALE Configuration
"
" Note: Early settings that must be set before ALE loads are in:
" .vim/pack/000-settings/start/settings/plugin/ale.vim

" ----------------------------------------------------------------------------
" Display Settings
"
" Control how errors and warnings appear in your editor

" Change the sign column color when there are errors
" This changes the entire column color. Ick.
" Leave this here so I don't try it again.
"let g:ale_change_sign_column_color = v:true

" ----------------------------------------------------------------------------
" Global Fixers
"
" Automatic fixes that apply to all file types

" For all files: remove extra blank lines at end of file and trailing whitespace
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }

" ----------------------------------------------------------------------------
" Language-specific linters and fixers
" TODO: Consider moving these to their own ftplugin files

" Initialize linters dictionary if it doesn't exist
if !exists('g:ale_linters')
  let g:ale_linters = {}
endif

" awk
" TODO: Move to ftplugin/awk.vim
let g:ale_linters.awk = ['gawk']

" dockerfile
" TODO: Move to ftplugin/dockerfile.vim
let g:ale_linters.dockerfile = ['hadolint']
let g:ale_fixers.dockerfile = ['remove_trailing_lines', 'trim_whitespace']

" jsonc
" TODO: Move to ftplugin/jsonc.vim
let g:ale_linters.jsonc = ['jsonlint']
let g:ale_fixers.jsonc = ['jq']

" markdown
" TODO: Move to ftplugin/markdown.vim
let g:ale_linters.markdown = ['markdownlint', 'proselint']
let g:ale_fixers.markdown = ['prettier']

" powershell
" TODO: Move to ftplugin/ps1.vim
let g:ale_linters.ps1 = ['powershell']
let g:ale_fixers.ps1 = ['remove_trailing_lines', 'trim_whitespace']

" sql
" TODO: Move to ftplugin/sql.vim
let g:ale_linters.sql = ['sqlint']
let g:ale_fixers.sql = ['sqlformat']

" systemd
" TODO: Move to ftplugin/systemd.vim
let g:ale_linters.systemd = ['systemd-analyze']

" toml
" TODO: Move to ftplugin/toml.vim
let g:ale_linters.toml = ['tomllint']

" vim-help
" TODO: Move to ftplugin/help.vim
let g:ale_linters.help = ['vimhelplint']

" ----------------------------------------------------------------------------
" Language-specific linters and fixers
" TODO: Consider moving these to their own ftplugin files

" awk
" TODO: Move to ftplugin/awk.vim
let g:ale_linters.awk = ['gawk']

" dockerfile
" TODO: Move to ftplugin/dockerfile.vim
let g:ale_linters.dockerfile = ['hadolint']
let g:ale_fixers.dockerfile = ['remove_trailing_lines', 'trim_whitespace']

" jsonc
" TODO: Move to ftplugin/jsonc.vim
let g:ale_linters.jsonc = ['jsonlint']
let g:ale_fixers.jsonc = ['jq']

" markdown
" TODO: Move to ftplugin/markdown.vim
let g:ale_linters.markdown = ['markdownlint', 'proselint']
let g:ale_fixers.markdown = ['prettier']

" powershell
" TODO: Move to ftplugin/ps1.vim
let g:ale_linters.ps1 = ['powershell']
let g:ale_fixers.ps1 = ['remove_trailing_lines', 'trim_whitespace']

" sql
" TODO: Move to ftplugin/sql.vim
let g:ale_linters.sql = ['sqlint']
let g:ale_fixers.sql = ['sqlformat']

" systemd
" TODO: Move to ftplugin/systemd.vim
let g:ale_linters.systemd = ['systemd-analyze']

" toml
" TODO: Move to ftplugin/toml.vim
let g:ale_linters.toml = ['tomllint']

" vim-help
" TODO: Move to ftplugin/help.vim
let g:ale_linters.help = ['vimhelplint']
