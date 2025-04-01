" Terraform-specific settings

" Enable ALE linters and fixers for Terraform
let b:ale_linters = ['tflint']
let b:ale_fixers = ['terraform']

" Set comment string for Terraform files
setlocal commentstring=#\ %s

" Enable folding by syntax
setlocal foldmethod=syntax
