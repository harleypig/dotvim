import os
import sys
import subprocess

# Change this to the directory you're installing your virtual environment in.
VENV='venv'

##############################################################################
# ----------------------------------------------------------------------------
def eprint(*msgs) -> None:
    """Print to STDERR """
    print(*msgs, sep="\n", end=None, file=sys.stderr)

# ----------------------------------------------------------------------------
def eexit(*msgs, exit_code=1) -> None:
    """Print to STDERR if a message exists, then exit with exit_code."""
    if msgs:
        eprint(msgs)

    sys.exit(exit_code)

# ----------------------------------------------------------------------------
#def activate_virtualenv():
#    # If we're already in a virtual environment, do nothing
#    if hasattr(sys, 'real_prefix') \
#       or (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix):
#        return
#
#    venv = os.path.join(os.path.abspath(os.path.dirname(__file__)), '..', VENV)
#
#    if not os.path.isdir(venv):
#        raise Exception("Can't find {venv}, did you create you're virtual environment?")
#
#    activate_venv = os.path.join(venv, 'bin', 'activate')
#    subprocess.run(f'/bin/bash -c "source {activate_venv}"',
#                   shell=True, check=True)
#
#activate_virtualenv()
