" markdownlint-cli reads its config file only from the directory it runs in,
" and ALE runs it from Vim's, so name the project's file outright. The names
" are the ones markdownlint-cli looks for, in its order.
for s:name in ['.markdownlint.jsonc', '.markdownlint.json',
      \ '.markdownlint.yaml', '.markdownlint.yml']
  let s:config = ale#path#FindNearestFile(bufnr(''), s:name)

  if !empty(s:config)
    let b:ale_markdown_markdownlint_options =
          \ '--config ' . ale#Escape(fnamemodify(s:config, ':p'))
    break
  endif
endfor

unlet! s:name s:config
