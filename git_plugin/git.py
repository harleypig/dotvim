import os
import git
import giturlparse

# ----------------------------------------------------------------------------
def repo():
    """Check for a Git repository and return a git.Repo instance."""

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
def validate_name(ctx, param, value):
    """Validate a string is a submodule in the .gitmodules file."""

    sm = repo().submodule(name)

    if sm is not None:
        return sm

    return False

# ----------------------------------------------------------------------------
def validate_url(ctx, param, url):
    """Validate a string is a valid git URL."""

    if repo() and giturlparse.validate(url):
        return True

    return False

# ----------------------------------------------------------------------------
def add_plugin(url):
    print(f"Adding plugin: {url}")

# ----------------------------------------------------------------------------
def move_plugin(sm, pack):
    """Move named plugin from its current location to the specified pack directory."""

    if isinstance(sm, str):
        sm = validate_name(sm)

    elif not isinstance(sm, git.Submodule):
        print('move_plugin accepts either a valid submodule name or a git.Submodule object')
        exit(1)

# ----------------------------------------------------------------------------
def remove_plugin(sm):
    """Remove named plugin."""

    if isinstance(sm, str):
        sm = validate_name(sm)

    elif not isinstance(sm, git.Submodule):
        print('move_plugin accepts either a valid submodule name or a git.Submodule object')
        exit(1)




# Validate a string is a directory in the .vim/pack directory
def validate_pack_directory(name):
    pack_dir = os.path.join('.vim', 'pack', 'testing')
    path = os.path.join(pack_dir, name)
    if os.path.exists(path) and os.path.isdir(path):
        return True
    else:
        return False


# Add a git submodule to the .vim/pack/testing directory
def add_git_submodule(repo, url):
    name = re.sub(r'\.git|\.vim|\.nvim', '', os.path.basename(url))
    pack_dir = os.path.join('.vim', 'pack', 'testing')
    path = os.path.join(pack_dir, name)
    if os.path.exists(path) and os.path.isdir(path):
        print(f'Error: Directory {name} already exists in pack directory')
        exit(1)
    else:
        submodule = repo.create_submodule(name, url, path)
        submodule.update(init=True, recursive=True)


# Remove a git submodule
def remove_git_submodule(repo, name):
    submodule = repo.submodule(name)
    if submodule is None:
        print(f'Error: Submodule {name} not found')
        exit(1)
    else:
        submodule.remove(recursive=True)
        repo.index.commit(f'Removed submodule {name}')
        repo.git.rm(submodule.path)

