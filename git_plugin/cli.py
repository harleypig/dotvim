import click
from . import readme, learning, git, util
import pudb

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
@cli.command()
@click.argument('url',
    type=git.validate_plugin_url,
    metavar='<url>'
)
def add(url):
    """Adds the vim plugin found at 'url' as a submodule."""
    pudb.set_trace()
    git.add_plugin(url)

# ----------------------------------------------------------------------------
@cli.command()
@click.argument('name',
    callback=git.validate_plugin_name,
    metavar='<name>'
)
@click.argument('pack',
    callback=git.validate_pack_directory,
    metavar='<pack>'
)
def move(name, pack):
    """Moves the named submodule to the specified pack location."""
    git.move_plugin(name)

# ----------------------------------------------------------------------------
@cli.command()
@click.argument('name',
    callback=git.validate_plugin_name,
    metavar='<name>'
)
def remove(name):
    """Removes the named submodule."""
    git.remove_plugin(name)

# ----------------------------------------------------------------------------
@cli.command()
def learning():
    """Generates a vim help formatted learning.txt."""
    learning.learning()

# ----------------------------------------------------------------------------
@cli.command()
def readme():
    """Generates a readme.md."""
    readme.readme()
