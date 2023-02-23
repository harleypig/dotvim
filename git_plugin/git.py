import pathlib
import git
import giturlparse
import pudb

##############################################################################
# ----------------------------------------------------------------------------
def repo():
    """Check for a Git repository and return a git.Repo instance."""

    pudb.set_trace()
    try:
        r = git.Repo()

    except:
        print('git-plugin can only run in a git repository')
        exit(1)

    if r.bare():
        print('git-plugin cannot work in a bare repository')
        exit(1)

    return r

# ----------------------------------------------------------------------------
def validate_plugin_name(ctx, param, value):
    """Validate a string is a submodule in the .gitmodules file."""

    sm = get_repo().submodule(name)

    if sm is not None:
        return sm

    return False

# ----------------------------------------------------------------------------
#def validate_plugin_url(ctx, param, url):
def validate_plugin_url(param, url):
    """Validate a string is a valid git URL."""

    pudb.set_trace()
    parsed_url = giturlparse.parse(url)

    if not parsed_url.valid:
        return False

    return parsed_url

# ----------------------------------------------------------------------------
def validate_pack_directory(packdir):
    """Validate a string is a directory in the .vim/pack directory."""

    pack_dir = pathlib.Path('.vim').joinpath('pack', packdir, 'start')

    if pack_dir.is_dir() and pack_dir.exists():
        return pack_dir

    return False

# ----------------------------------------------------------------------------
def get_submodule(sm):
    if isinstance(sm, str):
        name = sm
        sm = validate_plugin_name(sm)
        if not sm:
            print(f"{name} is not a known submodule")
            exit(1)

    elif not isinstance(sm, git.Submodule):
        print('move_plugin accepts either a valid submodule name or a git.Submodule object')
        exit(1)

    return sm


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

    packdir = valid_pack_directory('testing')
    if not packdir:
        print('why are you seeing this? bad .vim/pack/testing/start directory')
        exit(1)

    name = url.name.rstrip('.vim').rstrip('.nvim')

    r = get_repo()

    try:
        r.create_submodule(
            name = name,
            path = packdir,
            url  = url.url2https,
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
