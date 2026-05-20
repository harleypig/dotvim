" Java-specific settings.
" https://github.com/neoclide/coc-java

" coc-java handles diagnostics via jdtls; disable ALE Java linters
" to avoid conflicting diagnostics.
let b:ale_linters = []

" Format with google-java-format if available.
" https://github.com/google/google-java-format
if executable('google-java-format')
  let b:ale_fixers = ['google_java_format']
  let b:ale_fix_on_save = 1
endif
