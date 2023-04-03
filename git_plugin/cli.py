from .git import GitPluginManager
import click
from . import __version__

# import pudb

manager = GitPluginManager()

# ----------------------------------------------------------------------------
CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])

# ----------------------------------------------------------------------------
@click.group(context_settings=CONTEXT_SETTINGS)
def cli():
    """git-plugin is a command-line tool for managing your VIm plugins using
    Git submodules.

    You can use this tool to add, move, and remove plugins, as well as
    generate documentation with the `readme` command and generatea VIm help
    doc file with you current learning objectives."""

    pass

# ----------------------------------------------------------------------------
@click.command()
def version():
    """Prints the version number."""
    click.echo(f"git-plugin version {__version__}")

cli.add_command(version)

# ----------------------------------------------------------------------------
@cli.command()
@click.argument('url', callback=manager.validate_plugin_url, metavar='<url>')
def add(url):
    """Adds the vim plugin found at 'url' as a submodule."""
    manager.add_plugin(url)

# ----------------------------------------------------------------------------
@cli.command()
@click.argument('name',
                callback=manager.validate_plugin_name,
                metavar='<name>'
                )
@click.argument('pack',
                callback=manager.validate_pack_directory,
                metavar='<pack>'
                )
def move(name, pack):
    """Moves the named submodule to the specified pack location."""
    manager.move_plugin(name, pack)

# ----------------------------------------------------------------------------
@cli.command()
@click.argument('name',
                callback=manager.validate_plugin_name,
                metavar='<name>'
                )
def remove(name):
    """Removes the named submodule."""
    manager.remove_plugin(name)

# ----------------------------------------------------------------------------
@cli.command()
def list():
    """Lists the current plugins."""
    manager.list_plugins()

# ----------------------------------------------------------------------------
# @cli.command()
# def learning():
#    """Generates a vim help formatted learning.txt."""
#    learning.learning()

# ----------------------------------------------------------------------------
# @cli.command()
# def readme():
#    """Generates a readme.md."""
#    readme.readme()
