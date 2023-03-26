import os
import pathlib

import jinja2

import git


##############################################################################
# ----------------------------------------------------------------------------
def settings_dir():
    """Return the path to the settings directory"""

    settings = pathlib.Path('.vim').joinpath('pack', 'settings', 'start',
                                             'settings')
    if not settings.exists():
        settings.mkdir(parents=True, exist_ok=True)

    return settings

# ----------------------------------------------------------------------------
def find_files(name=None):
    """Find all files in the settings directory, or find all files named
    name.vim in the settings directory."""

    settings = settings_dir()
    files = [f for f in settings.iterdir() if f.is_file()]

    return files

##############################################################################
# ----------------------------------------------------------------------------
def mk_submodule_doc(name):
    """Create a doc file for a submodule"""

    submodule = git.get_submodule(name)
    if submodule is None:
        print(f"Submodule {name} not found")
        exit(1)
