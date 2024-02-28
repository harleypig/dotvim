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
  * Only include this section if there is information to document.
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
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Describe the configured language server, its setup via ALE, CoC, or config files, and any pertinent details.
* Syntax Highlighting
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Detail the syntax highlighting configuration, including the tool (ALE, CoC, vim file) and any notable aspects.
* Linting and Static Analysis
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Specify linters and static analysis tools used, their configuration method, and any additional relevant information.
* Auto Completion
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Document the auto-completion setup, the tool configured (ALE, CoC), and any special considerations.
* Formatting and Beautification
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Outline the formatter(s) used, configuration via ALE, CoC, vim file, or config file, and any exceptions or extras.
* Error Highlighting
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Describe error highlighting configuration, the tool used (ALE, CoC), and any unique settings.
* Code Folding
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Explain code folding settings, including the method of configuration and any non-standard behavior.
* Snippets
  * Include relevant key combinations with a short description of their purpose if applicable.
  * List snippet tools and sources, how they're configured, and any custom snippet collections.
* Schema or Contract Validation
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Detail schema or contract validation tools, their configuration, and any specific schemas or contracts set up.
* Version Control Integration
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Describe version control integrations, configuration via plugins or settings, and any additional features enabled.
* Comment Support
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Document comment handling, including tools and configurations for generating or formatting comments.
* Filetype Detection
  * Include relevant key combinations with a short description of their purpose if applicable.
  * Explain any custom filetype detection settings, including the method of configuration and filetypes involved.
