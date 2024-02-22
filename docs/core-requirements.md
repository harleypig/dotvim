Language or Configuration Format Documentation Template

These instructions are for the AI:

* When creating new documentation files, use the hash (#) style of Markdown
    for headings. Each new file should start with a level 2 heading (##) to
    maintain consistency and structure within the documentation.

* Include only the bullet points that need to be documented for the specific
    language or configuration format.

* If a feature or setting is not specifically configured or altered in ALE,
    CoC, or within the settings directory, it does not require documentation.
    Only document settings that have been explicitly set or modified.

* Use this template as a guide when documenting support for a language or
    configuration format in the development environment. For each core
    requirement or setup section, provide the following information:

  * A brief description of the feature or setting.
  * Whether this is a built-in Vim setting, or configured via ALE, CoC, or a plugin.
  * The location of configuration files (if any) that hold this information.
  * Any additional notes or considerations relevant to the setup or usage of the feature.

* For the plugins used section, include the name of the plugin, the type (ale,
    coc, vim plugin or builtin), a link to documentation and repository if
    available. Use the following format:

[plugin name](link to documentation) (plugin type) (additional links, if any)

Core Requirements:

* Required External Packages
* Plugins Used
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
