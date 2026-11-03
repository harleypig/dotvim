" HCL (HashiCorp Configuration Language) settings
" Used by Packer, Terraform, and other HashiCorp tools

" Set comment string for HCL files
setlocal commentstring=#\ %s

" Enable folding by syntax
setlocal foldmethod=syntax

" ALE has no HCL linter (tflint is Terraform's), so only the fixer is set.
let b:ale_fixers = ['terraform']
