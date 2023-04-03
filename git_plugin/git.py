#import pudb
import os
import pathlib

import click
import giturlparse

import git

from typing import Optional, Union
from .util import eprint

##############################################################################
# ----------------------------------------------------------------------------
class GitPluginManager:
    def __init__(self):
        self.repo = self.repo()

    # ------------------------------------------------------------------------
    def repo(self) -> git.Repo:
        """
        Get the git repo, change the working directory to the repo root, and
        return the repo.

        Returns:
          git.Repo: The git repository object.
        """

        try:
            r = git.Repo(search_parent_directories = True)
            if r.bare:
                raise ValueError("git-plugin can only run in a valid non-bare git repository")

            os.chdir(r.working_dir)
            return r

        except git.InvalidGitRepositoryError:
            raise ValueError("git-plugin can only run in a valid non-bare git repository")

        except git.NoSuchPathError:
            raise ValueError("No git repository found in the current directory or a parent directories")

    # ------------------------------------------------------------------------
    def submodule(self,
                      sm: Union[str, git.Submodule]) -> Optional[git.Submodule]:
        """
        Get the submodule by its name or the submodule object itself.

        Args:
            sm (Union[str, git.Submodule]): The submodule's name or submodule object.

        Returns:
            Optional[git.Submodule]: The submodule object if found, otherwise None.
        """

        if isinstance(sm, git.Submodule):
            return sm

        elif not isinstance(sm, str):
            return None

        try:
            sm = self.repo.submodule(sm)
            return sm

        except:
            return None

    # ------------------------------------------------------------------------
    def packdir(self,
                packdir: Union[str, pathlib.Path],
                name: Optional[str] = None,
                subdir = "start") -> Optional[pathlib.Path]:
        """
        Get the pack directory based on the given packdir and name.

        Args:
            packdir (Union[str, pathlib.Path]): The pack directory string or pathlib.Path object.
            name (Optional[str], optional): The name of the submodule. Defaults to None.

        Returns:
            Optional[pathlib.Path]: The pack directory path object if valid, otherwise None.
        """

        if not isinstance(packdir, (str, pathlib.Path)):
            return None

        elif isinstance(packdir, str):
            packdir = pathlib.Path(".vim").joinpath("pack", packdir, subdir)

        if name is not None:
            if not packdir.exists():
                return None

            packdir = packdir.joinpath(name)

        return packdir

    # ------------------------------------------------------------------------
    def parse_url(self,
                  url: Union[str, giturlparse.result.GitUrlParsed]) -> Optional[giturlparse.result.GitUrlParsed]:
        """
        Get the parsed URL object for the given URL.

        Args:
            url (Union[str, giturlparse.result.GitUrlParsed]): The URL string or GitUrlParsed object.

        Returns:
            Optional[giturlparse.result.GitUrlParsed]: The parsed URL object if valid, otherwise None.
        """

        if isinstance(url, giturlparse.result.GitUrlParsed):
            return url

        elif not isinstance(url, str):
            return None

        parsed_url = giturlparse.parse(url)

        return parsed_url

    # ------------------------------------------------------------------------
    def validate_plugin_name(self,
                             ctx: click.Context,
                             param: click.Parameter,
                             name: str) -> git.Submodule:
        """
        Validate if the given name is a submodule in the .gitmodules file.
        Usually used by the command line module.

        Args:
            ctx (click.Context): The click context object.
            param (click.Parameter): The click parameter object.
            name (str): The submodule name.

        Returns:
            git.Submodule: The submodule object if the name is valid.

        Raises:
            click.BadParameter: If the name is not a known submodule.
        """

        sm = submodule(name)

        if sm is not None:
            return sm

        raise click.BadParameter("not a known submodule")

    # ------------------------------------------------------------------------
    def validate_plugin_url(self,
                            ctx: click.Context,
                            param: click.Parameter,
                            url: str) -> giturlparse.result.GitUrlParsed:
        """
        Validate if the given URL is a valid git URL.
        Usually used by the command line module.

        Args:
            ctx (click.Context): The click context object.
            param (click.Parameter): The click parameter object.
            url (str): The URL string.

        Returns:
            giturlparse.result.GitUrlParsed: The parsed URL object if valid.

        Raises:
            click.BadParameter: If the URL is not valid.
        """

        parsed_url = self.parse_url(url)

        if parsed_url is None or not parsed_url.valid:
            raise click.BadParameter("not a valid url")

        return parsed_url

    # ------------------------------------------------------------------------
    def validate_pack_directory(self,
                                ctx: click.Context,
                                param: click.Parameter,
                                packdir: str) -> str:
        """
        Validate if the given packdir is a directory in the .vim/pack directory.
        Usually used by the command line module.

        Args:
            ctx (click.Context): The click context object.
            param (click.Parameter): The click parameter object.
            packdir (str): The pack directory string.

        Returns:
            str: The pack directory if it is valid.

        Raises:
            click.BadParameter: If the pack directory is not valid.
        """

        pd = packdir(packdir)

        if pd is None or not pd.exists():
            raise click.BadParameter(f"{packdir} is not a valid pack directory")

        name = ctx.params["name"].name if ctx.params["name"] else None

        pd = pd.joinpath(name)

        if pd.exists() and any(pd.iterdir()):
            raise click.BadParameter(f"{packdir} exists and is not empty")

        return packdir

    ##########################################################################
    # ------------------------------------------------------------------------
    def add_plugin(self,
                   url: Union[str,giturlparse.result.GitUrlParsed]) -> None:
        """
        Add a git submodule to the .vim/pack/testing directory.

        Args:
            url (Union[str, giturlparse.result.GitUrlParsed]): The URL string or GitUrlParsed object.
        """

        url = self.parse_url(url)

        if url is None or not url.valid:
            raise ValueError(f"{url} is not a valid url")

        name = url.name.rstrip(".vim").rstrip(".nvim")

        if self.submodule(name) is not None:
            raise ValueError(f"a submodule with the name '{name}' already exists")

        packdir = self.packdir("testing")

        if packdir is None or not packdir.exists():
            raise ValueError(f"{packdir.as_posix()} does not exist")

        packdir = packdir.joinpath(name)

        if packdir.exists() and any(packdir.iterdir()):
            raise ValueError(f"{packdir.as_posix} exists and is not empty")

        try:
            sm = self.repo.create_submodule(
                name = name,
                path = packdir.as_posix(),
                url  = url.url2https,
            )

            sm.update(
                recursive = True,
                init = True
            )

            self.repo.index.commit(f"auto add {name} submodule by git-plugin")
            eprint(f"{name} added")

        except git.CommandError as e:
            raise ValueError(f"Error adding submodule, repo may not be in a clean state: {e}")

    # ------------------------------------------------------------------------
    def move_plugin(self,
                    sm: Union[str, git.Submodule],
                    packdir: Union[str, pathlib.Path]) -> None:
        """
        Move the named plugin from its current location to the specified pack directory.

        Args:
            sm (Union[str, git.Submodule]): The submodule's name or submodule object.
            packdir (Union[str, pathlib.Path]): The destination pack directory string or pathlib.Path object.
        """

        sm = self.ubmodule(sm)
        if sm is None:
            raise ValueError(f"{sm} is not a known submodule")

        packdir = self.packdir(packdir, sm.name)
        if packdir is None:
            raise ValueError(f"{packdir} is not a valid pack directory")

        elif packdir.exists() and any(packdir).iterdir():
            raise ValueError(f"{packdir} already exists and is not empty")

        try:
            sm.move(packdir.as_posix())
            self.repo.index.commit(f"moved {name} submodule to {packdir.as_posix()} by git-plugin")
            eprint(f"{sm.name} moved to {packdir.as_posix()}")

        except ValueError as e:
            raise ValueError(f"error moving {sm.name} to {newdir}, repo may not in a clean state")

    # ------------------------------------------------------------------------
    def remove_plugin(self,
                      sm: Union[str, git.Submodule]) -> None:
        """
        Remove the named plugin.

        Args:
            sm (Union[str, git.Submodule]): The submodule's name or submodule object.
        """

        sm = self.submodule(sm)
        if sm is None:
            raise ValueError(f"{sm} is not a known submodule")

        try:
            sm.remove(dry_run = True)

        except git.GitCommandError as e:
            raise ValueError(f"Error: Could not remove {sm.name}: {e}")

        try:
            sm.remove()
            sel.repo.index.commit(f"removed {name} submodule by git-plugin")

        except Exception as e:
            raise ValueError(f"Error removing {sm.name}, repo may not be in a clean state: {e}")

    # ------------------------------------------------------------------------
    def list_plugins(self) -> None:
        """
        List all plugins, grouped by their pack directory.
        """

        #submodules = sorted(r.submodules, key = lambda sm: sm.name)
        groups = {}

        for sm in self.repo.submodules:
            path = pathlib.PurePath(sm.path)
            group_name = path.parts[2]
            dir_name = path.parts[4]
            name = sm.name

            if name != dir_name:
                name = f"{name} ({dir_name})"

            if group_name not in groups:
                groups[group_name] = []

            groups[group_name].append(name)

        sorted_groups = sorted(groups)

        for group in sorted_groups:
            groups[group].sort()

            eprint(f"\n{group}:")

            for name in groups[group]:
                eprint(f"    {name}")
