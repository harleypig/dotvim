#!/usr/bin/env python

import subprocess

raw = subprocess.check_output(['vim', '-c', 'verbose map', '-c', 'qa!'], stderr=subprocess.STDOUT)
lines = raw.decode('utf-8').split('\n')

for line in lines:
  print(line)

