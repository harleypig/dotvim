" # JSON for VIM
"
" ## coc-json
"
" The [source](https://github.com/neoclide/coc-json) uses
" (vscode-json-languageserver)[https://github.com/microsoft/vscode-json-languageservice
" as the language server.
"
" XXX: can this be made to work with azure pipelines?
"
"* https://vi.stackexchange.com/a/35197
"  + looks like it:
"      https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json
"  + also, see https://www.schemastore.org
"
" ## jsonc
"
" [jsonc](https://github.com/neoclide/jsonc.vim) sets the filetype to jsonc
" for files with the extension .jsonc and some other specific extensions and
" filenames (including coc-settings.json).

" ## ALE
" ALE
"
" Tell ALE what to do with JSON files Order matters, so put the most specific
" checkers first.
"
" See:
"
" * [supported](https://github.com/dense-analysis/ale/blob/master/supported-tools.md)
" tools for an up-to-date list.
" * `:help ale-json` or [ale-json](https://github.com/dense-analysis/ale/blob/master/doc/ale-json.txt)
"
" ### JSON
"
" #### VSCode JSON language server
"
"   [source](https://github.com/hrsh7th/vscode-langservers-extracted)
"
"   Not ready for casual use yet.
"
" #### clang-format
"
" * [documentation](https://clang.llvm.org/docs/ClangFormat.html)
"
" ### cspell
"
" * [source](https://github.com/streetsidesoftware/cspell)
" * [documentation](https://cspell.org)
" * disabled by default
" *  Example:
"     docker run -v -i -t $PWD:/workdir ghcr.io/streetsidesoftware/cspell:latest
"
" #### dprint
"
" * [home](https://dprint.dev/)
"
" #### eslint
"
" * [home](https://eslint.org/)
"
" #### fixjson
"
" * [source](https://github.com/rhysd/fixjson)
"
let g:ale_fixers.json = ['jq']
" #### jq - JSON formatter
"
" * [home](https://stedolan.github.io/jq/)
" * enabled as a fixer for autoformatting JSON files.
" #### jsonlint
"
" * [home](https://github.com/zaach/jsonlint)
"
" #### prettier
"
" * [home](https://prettier.io/)
" * [source](https://github.com/prettier/prettier)
"
" #### spectral
"
" * [home](https://stoplight.io/open-source/spectral/)
" * [source](https://github.com/stoplightio/spectral)
"
" ### JSONC and JSON5
"
" * eslint
" * disabled by default
let g:ale_fixers.json = ['jq']
let g:ale_fixers.jsonc = ['jq']


set foldmethod=syntax
