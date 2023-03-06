let invalid_hosts = [ 'camilla.zbc.internal' ]
let current_host = hostname()

if index(invalid_hosts, current_host) != -1
  silent Copilot disable
endif
