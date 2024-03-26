setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal autoindent
setlocal smartindent

if search('^\s*-\s*hosts:\s', 'nw')
  setfiletype yaml.ansible
endif
