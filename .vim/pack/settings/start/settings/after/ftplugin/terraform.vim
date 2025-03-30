" Terraform-specific settings

" Set indentation to 2 spaces
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

" Enable ALE linters and fixers for Terraform
let b:ale_linters = ['tflint']
let b:ale_fixers = ['terraform']

" Set comment string for Terraform files
setlocal commentstring=#\ %s

" Enable folding by syntax
setlocal foldmethod=syntax
