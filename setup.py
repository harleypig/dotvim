# -*- coding: utf-8 -*-
from setuptools import setup

packages = ['git_plugin']

package_data = {'': ['*']}

install_requires = [
 'GitPython>=3.1.31,<4.0.0',
 'click>=8.1.3,<9.0.0',
 'giturlparse>=0.10.0,<0.11.0']

entry_points = {
    'console_scripts': [
        'git-plugin = git_plugin.cli:cli'
    ]
}

setup_kwargs = {
    'name': 'git-submodule-manager',
    'version': '0.1.1',
    'description': 'An intuitive Python CLI tool for streamlined Git submodule management, enabling users to add, move, and rename submodules with ease.',
    'author': 'Alan Young',
    'author_email': 'harleypig@harleypig.com',
    'maintainer': 'None',
    'maintainer_email': 'None',
    'url': 'None',
    'packages': packages,
    'package_data': package_data,
    'install_requires': install_requires,
    'entry_points': entry_points,
    'python_requires': '>=3.10,<4.0',
}


setup(**setup_kwargs)
