Language or Configuration Format Documentation Template

* For new documentation documents, start with a level 2 heading (##) using hash (#) Markdown style.
* Document only non-default settings; default behaviors should not be included.
* If sections are unaltered and handled by defaults, or are not applicable, state this collectively at the end.


XXX: need to add key combos

  * A brief description of the feature or setting.
  * Whether this is a built-in Vim setting, or configured via ALE, CoC, or a plugin.
  * The location of configuration files (if any) that hold this information.
  * Any additional notes or considerations relevant to the setup or usage of the feature.

* For the plugins and extensions used section, include the name of the plugin,
    the type (ale, coc, vim plugin or builtin), a link to documentation and
    repository if available. Use the following format:

[plugin name](link to documentation) (plugin type) (additional links, if any)

Core Requirements:

* External Packages Used
  * Include each package name as a markdown link to the home page, and a brief description.
* Plugins and Extensions Used
  * Include each plugin or extension name as a markdown link to the home page, its type (plugin or extension), and a brief description.
  * Note if a plugin or extension supports multiple languages or tasks (e.g., language server, autoformatting, linting).
* Configuration Files Used
  * List only relevant configuration files, including the name of the package, plugin, or extension being configured.
* Language Server
* Syntax Highlighting
* Linting and Static Analysis
* Auto Completion
* Formatting and Beautification
* Error Highlighting
* Code Folding
* Snippets
* Schema or Contract Validation
* Version Control Integration
* Comment Support
* Filetype Detection
