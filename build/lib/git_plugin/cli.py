import click
import learning
import readme

from click_params import URL
from git import add_plugin, move_plugin, remove_plugin, validate_plugin_url

def validate_name(ctx, param, value):
    pass

@click.group()
def cli():
    pass

@cli.command()
@click.argument('url', callback=validate_plugin_url)
def add(url):
    add_plugin(url)

@cli.command()
@click.argument('name', callback=validate_name)
def move(name):
    move_plugin(name)

@cli.command()
@click.argument('name', callback=validate_name)
def remove(name):
    remove_plugin(name)

@cli.command()
def learning():
    learning.learning()

@cli.command()
def readme():
    readme.readme()

@cli.command()
@click.pass_context
def default(ctx):
    click.echo(ctx.get_help())
