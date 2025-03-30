" Detect bash files based on shebang or shellcheck directive
autocmd BufNewFile,BufRead *
      \ if getline(1) =~# '^#!.*/bin/bash\>' ||
      \    getline(1) =~# '^#!.*/usr/bin/env\s\+bash\>' ||
      \    getline(1) =~# '^#\s*shellcheck\s\+shell=bash\>' ||
      \    getline(1) =~# '^#\s*shellcheck\s\+shell=sh\>' |
      \   set filetype=bash |
      \ endif
