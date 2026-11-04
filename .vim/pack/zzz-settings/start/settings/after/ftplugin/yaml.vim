" Add yamllint support; once, since this runs each time the filetype is set.
if !exists('b:ale_linters')
  let b:ale_linters = ['yamllint']
elseif index(b:ale_linters, 'yamllint') < 0
  call add(b:ale_linters, 'yamllint')
endif
