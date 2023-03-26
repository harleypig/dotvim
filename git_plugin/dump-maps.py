#!/usr/bin/env python

import re
import subprocess

# See ':h map-table'
# See ':h map-listing'

#-----------------------------------------------------------------------------
def capture():
    cmd = ['vim', '-c', 'set nomore', '-c', 'verbose map', '-c', 'qa!']
    options = {
        'env': {'TERM': 'dumb'},
        'stdout': subprocess.PIPE,
        'stderr': subprocess.PIPE,
        'text': True
    }

    result = subprocess.run(cmd, **options)

    first_rx = re.compile(r'\x0c')
    ansi_escape_rx = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')

    first = first_rx.sub('', result.stdout)
    clean = ansi_escape_rx.sub('', first)

    return clean.split('\n\n')

#-----------------------------------------------------------------------------
def parse_last_set(value, lastline):
    parts = lastline.split(None)
    value.extend([parts[3], parts[5]])

    return value

#-----------------------------------------------------------------------------
def parse_definitions():
    lines = capture()
    values = []

    for i, line in enumerate(lines):
        l = line.lstrip()

        if l.startswith('Last'):
            values[-1] = parse_last_set(values[-1], l)

        else:
            values.append(l.split(None, 3))

    return values

#-----------------------------------------------------------------------------
def parse():
    definitions = parse_definitions()

    mappings = {}

    for definition in definitions:
        if not definition:
            continue

        line_no = definition.pop()
        filename = definition.pop()

        if filename not in mappings:
            mappings[filename] = {}

        if line_no not in mappings[filename]:
            mappings[filename][line_no] = []

        mappings[filename][line_no].append(definition)

    return mappings

#-----------------------------------------------------------------------------
definitions = parse()

for definition in definitions:
    print(definition)

    sorted_line_nos = sorted(definitions[definition].keys())

    for line_no in sorted_line_nos:
        for mapping in definitions[definition][line_no]:
            print('    ', ' '.join(mapping), f' (line {line_no})')

    print()
