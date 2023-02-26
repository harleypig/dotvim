import click
import git
import giturlparse
import pathlib
import pudb

##############################################################################
# ----------------------------------------------------------------------------
def get_repo():
    """Get the git repo, change the working directory to the repo root, and
    return the repo."""

    if isinstance(repo, git.Repo):
        return repo

    try:
        r = git.Repo(search_parent_directories = True)
        if r.bare:
            raise Exception('bare repo')

        pathlib.Path.chdir(r.working_dir)

        return r

    except:
        print('git-plugin can only run in a non-bare git repository')
        exit(1)

repo = get_repo()

# ----------------------------------------------------------------------------
def get_submodule(sm):
    """Get the submodule"""

    if isinstance(sm, git.Submodule):
        return sm

    elif not isinstance(sm, str):
        return None

    r = get_repo()

    try:
        sm = r.submodule(sm)
        return sm

    except:
        return None

# ----------------------------------------------------------------------------
def get_packdir(packdir, name=None):
    """Get the pack directory."""

    pudb.set_trace()

    if not isinstance(packdir, (str, pathlib.Path)):
        return None

    elif isinstance(packdir, str):
        packdir = pathlib.Path('.vim').joinpath('pack', packdir, 'start')

    if name is not None:
        if not packdir.exists():
            return None

        packdir = packdir.joinpath(name)

    return packdir

# ----------------------------------------------------------------------------
def get_url(url):
    """Get the url."""

    if isinstance(url, giturlparse.result.GitUrlParsed):
        return url

    elif not isinstance(url, str):
        return None

    url = giturlparse.parse(url)

    return url

# ----------------------------------------------------------------------------
def validate_plugin_name(ctx, param, name):
    """Validate a string is a submodule in the .gitmodules file."""

    sm = get_submodule(name)

    if sm is not None:
        return sm

    raise click.BadParameter('not a known submodule')

# ----------------------------------------------------------------------------
def validate_plugin_url(ctx, param, url):
    """Validate a string is a valid git URL."""

    parsed_url = get_url(url)

    if parsed_url is None or not parsed_url.valid:
        raise click.BadParameter('not a valid url')

    return parsed_url

# ----------------------------------------------------------------------------
def validate_pack_directory(ctx, param, packdir):
    """Validate a string is a directory in the .vim/pack directory."""

    pudb.set_trace()

    pd = get_packdir(packdir)

    if pd is None or not pd.exists():
        raise click.BadParameter(f'{packdir} is not a valid pack directory')

    name = ctx.params['name'].name if ctx.params['name'] else None

    pd = pd.joinpath(name)

    if pd.exists() and any(pd.iterdir()):
        raise click.BadParameter(f'{packdir} exists and is not empty')

    return packdir

##############################################################################
# ----------------------------------------------------------------------------
def add_plugin(url):
    """Add a git submodule to the .vim/pack/testing directory."""

    url = get_url(url)

    if url is None or not url.valid:
        print(f'{url} is not a valid url')
        exit(1)

    name = url.name.rstrip('.vim').rstrip('.nvim')

    if get_submodule(name) is not None:
        print(f"a submodule with the name '{name}' already exists")
        exit(1)

    packdir = get_packdir('testing')

    if packdir is None or not packdir.exists():
        print(f'{packdir.as_posix()} does not exist')
        exit(1)

    packdir = packdir.joinpath(name)

    if packdir.exists() and any(packdir.iterdir()):
        print(f'{packdir.as_posix} exists and is not empty')
        exit(1)

    r = get_repo()

    try:
        sm = r.create_submodule(
            name = name,
            path = packdir.as_posix(),
            url  = url.url2https,
        )

        sm.update(
            recursive = True,
            init = True
        )

        r.index.commit(f'auto add {name} submodule by git-plugin')

    except Exception as e:
        print('error adding submodule, repo may not be in a clean state')
        exit(1)

    print(f'{name} added')
    exit(0)

# ----------------------------------------------------------------------------
def move_plugin(sm, packdir):
    """Move named plugin from its current location to the specified pack directory."""

    pudb.set_trace()

    sm = get_submodule(sm)
    if sm is None:
        print(f"{sm} is not a known submodule")
        exit(1)

    packdir = get_packdir(packdir, sm.name)
    if packdir is None:
        print(f"{packdir} is not a valid pack directory")
        exit(1)

    elif packdir.exists() and any(packdir).iterdir():
        print(f"{packdir} already exists and is not empty")
        exit(1)

    try:
        sm.move(packdir.as_posix())

    except ValueError:
        print(f"error moving {sm.name} to {newdir}, repo may not in a clean state")

    print(f"{sm.name} moved to {packdir.as_posix()}")

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
