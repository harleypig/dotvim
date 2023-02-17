import click

from click_params import URL

# git-plugin <action> <parms> ...

@click.command()
@click.option('--config', envvar='GITPLUGIN_CONFIG')
def config():
    pass

# add
@click.group()

#@click.option(type=URL)

# move
# remove
# readme
# learning
