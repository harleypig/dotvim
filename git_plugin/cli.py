import click
from click_params import URL
from . import readme, learning, git, util

@click.group()
def cli():
    pass

@cli.command()
@click.argument('url', callback=git.validate_plugin_url)
def add(url):
    """Adds the vim plugin found at 'url' as a submodule."""
    git.add_plugin(url)

@cli.command()
@click.argument('name', callback=git.validate_name)
@click.argument('pack', callback=git.validate_dir)
def move(name):
    """Moves the named submodule to the specified location."""
    git.move_plugin(name)

@cli.command()
@click.argument('name', callback=git.validate_name)
@click.argument('pack', callback=git.validate_dir)
def remove(name):
    """Removes the named submodule."""
    git.remove_plugin(name)

@cli.command()
def learning():
    """Generates a vim help formatted learning.txt."""
    learning.learning()

@cli.command()
def readme():
    """Generates a readme.md."""
    readme.readme()
