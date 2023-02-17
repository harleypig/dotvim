from setuptools import setup, find_packages

setup(
    name='git-plugin',
    version=0.0.1,
    packages=find_packages(),
    include_package_data=True,
    install_requires[
        'click',
        'click-params'
    ]
    entry_points={
        'console_scripts': [
            'git-plugin-add=git_plugin.cli:add',
            'git-plugin-move=git_plugin.cli:move',
            'git-plugin-remove=git_plugin.cli:remove',
            'git-plugin-readme=git_plugin.cli:readme',
            'git-plugin-learner=git_plugin.cli:learner',
        ]
    }
)
