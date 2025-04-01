" HCL (HashiCorp Configuration Language) settings
" Used by Packer, Terraform, and other HashiCorp tools

" Set comment string for HCL files
setlocal commentstring=#\ %s

" Enable folding by syntax
setlocal foldmethod=syntax

" Enable ALE linters and fixers for HCL
let b:ale_linters = ['tflint']
let b:ale_fixers = ['terraform']
