Language or Configuration Format Documentation Template

* For new documentation documents, start with a level 2 heading (##) using hash (#) Markdown style.
* Document only non-default settings; default behaviors should not be included.
* If sections are unaltered and handled by defaults, state this collectively at the end.


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
* Plugins and Extensions Used
* Configuration Files Used
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
