import click
import git
import giturlparse
import pathlib
import pudb

##############################################################################
# ----------------------------------------------------------------------------
def get_repo():
    """Check for a Git repository and return a git.Repo instance."""

    try:
        r = git.Repo()

    except:
        print('git-plugin can only run in a git repository')
        exit(1)

    if r.bare:
        print('git-plugin cannot work in a bare repository')
        exit(1)

    return r

# ----------------------------------------------------------------------------
def get_submodule(sm):
    """Get the submodule"""

    if isinstance(sm, git.Submodule):
        return sm

    elif not isinstance(sm, str):
        return None

    name = sm

    r = get_repo()

    try:
        sm = r.submodules(name)
        return sm

    except:
        return None

# ----------------------------------------------------------------------------
def validate_plugin_name(ctx, param, name):
    """Validate a string is a submodule in the .gitmodules file."""

    sm = get_submodule(name)

    if sm is not None:
        return sm

    if ctx is None:
        return False
    else:
        raise click.BadParameter('not a known submodule')


# ----------------------------------------------------------------------------
def validate_plugin_url(ctx, param, url):
    """Validate a string is a valid git URL."""

    parsed_url = giturlparse.parse(url)

    if not parsed_url.valid:
        raise click.BadParameter('not a valid url')

    return parsed_url

# ----------------------------------------------------------------------------
def validate_pack_directory(packdir):
    """Validate a string is a directory in the .vim/pack directory."""

    pack_dir = pathlib.Path('.vim').joinpath('pack', packdir, 'start')

    if pack_dir.is_dir() and pack_dir.exists():
        return pack_dir

    return False


##############################################################################
# ----------------------------------------------------------------------------
def add_plugin(url):
    """Add a git submodule to the .vim/pack/testing directory."""

    if isinstance(url, str):
        url = validate_plugin_url(url)
        if not url:
            print('invalud url')
            exit(1)

    elif not isinstance(url, giturlparse.result.GitUrlParsed):
        print('add_plugin accepts either a valid url string or a giturlparse object')
        exit(1)

    packdir = validate_pack_directory('testing')
    if not packdir:
        print('why are you seeing this? bad .vim/pack/testing/start directory')
        exit(1)

    name = url.name.rstrip('.vim').rstrip('.nvim')
    pudb.set_trace()
    if get_submodule(name) is not None:
        print(f"a submodule with the name '{name}' already exists")
        exit(1)

    r = get_repo()

    try:
        sm = r.create_submodule(
            name = name,
            path = packdir,
            url  = url.url2https,
        )

        sm.update(
            recursive = True,
            init = True
        )

    except:
        print('error adding submodule, repo may not be in a clean state')
        exit(1)

# ----------------------------------------------------------------------------
def move_plugin(sm, packdir):
    """Move named plugin from its current location to the specified pack directory."""

    sm = get_submodule(sm)

    if isinstance(packdir, str):
        dirname = packdir
        packdir = validate_plugin_directory(packdir)
        if not packdir:
            print(f"{dirname} does not exist in the vim pack directory")
            exit(1)

    elif not isinstance(packdir, pathlib):
        print('move_plugin accepts either a valid vim pack name or a pathlib object')
        exit(1)

    newdir = packdir.joinpath(sm.name)

    # newdir should not exist, or at least be empty
    if newdir.exists() and any(newdir).iterdir():
        print(f"{newdir} already exists and is not empty")
        exit(1)

    try:
        sm.move(newdir)

    except ValueError:
        print(f"error moving {sm.name} to {newdir}, repo may not in a clean state")

# ----------------------------------------------------------------------------
def remove_plugin(sm):
    """Remove named plugin."""

    sm = get_submodule(sm)

    try:
        sm.remove(dry_run = True)

    except:
        print(f"could not remove {sm.name}")
        exit(1)

    try:
        sm.remove()

    except:
        print(f"error removing {sm.name}, repo may not be in a clean state")
