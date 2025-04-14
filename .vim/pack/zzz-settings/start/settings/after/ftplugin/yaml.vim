" Add yamllint support
if !exists('b:ale_linters')
  let b:ale_linters = ['yamllint']
else
  call add(b:ale_linters, 'yamllint')
endif

" Keep the Ansible detection
if search('^\s*-\s*hosts:\s', 'nw')
  setfiletype yaml.ansible
endif
