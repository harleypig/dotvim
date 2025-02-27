# Language/Environment [NAME]

This template provides a checklist for setting up development tools for
a specific programming language or environment.

Create a short description this language or environment.

Wherever possible, use vim builtin settings/configuration options. If it's
possible to use a setting but a third-party solution is selected, document the
possible setting or configuration and explain why the third-part solution was
chosen.

If multiple third-party solutions were evaluated, or a solution was changed,
document why the change was made.

## Core Development Tools

### Language Server

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]
  - [ ] Project-specific: [path relative to project root]

- [ ] Integration Method:
  - [ ] CoC Extension:
  - [ ] Direct LSP:
  - [ ] Other:

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]
  - [ ] Common operations:

### Syntax Checker

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]
  - [ ] Project-specific: [path relative to project root]

- [ ] Integration Method:
  - [ ] ALE: [configuration details if using ALE]
  - [ ] CoC: [configuration details if using CoC]
  - [ ] Other: [specify other integration method]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]
  - [ ] Common operations: [frequently used operations and workflows]

### Linter

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]
  - [ ] Project-specific: [path relative to project root]

- [ ] Integration Method:
  - [ ] ALE: [configuration details if using ALE]
  - [ ] CoC: [configuration details if using CoC]
  - [ ] Other: [specify other integration method]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]
  - [ ] Common operations: [frequently used operations and workflows]

- [ ] Rules/Standards:
  - [ ] Default ruleset: [link to or description of default rules]
  - [ ] Custom rules: [location and description of custom rule configurations]

### Formatter

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]
  - [ ] Project-specific: [path relative to project root]

- [ ] Integration Method:
  - [ ] ALE: [configuration details if using ALE]
  - [ ] CoC: [configuration details if using CoC]
  - [ ] Other: [specify other integration method]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]
  - [ ] Format on save: [configuration for automatic formatting]

- [ ] Style Guide:
  - [ ] Link to guide: [link to style guide documentation]
  - [ ] Custom rules: [location and description of custom formatting rules]

## Code Understanding & Navigation

### Code Navigation

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]

- [ ] Features:
  - [ ] Tags generation: [ctags/gtags configuration and usage]
  - [ ] Symbol search: [configuration for symbol search functionality]
  - [ ] Jump-to-definition: [setup for code navigation features]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]

### Documentation Tools

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]
  - [ ] Project-specific: [path relative to project root]

- [ ] Features:
  - [ ] Documentation generation: [configuration for doc generation tools]
  - [ ] Preview: [setup for documentation preview features]
  - [ ] Integration with completion/hover: [configuration for inline documentation]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]

### Snippets

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] Custom snippets: [path to custom snippet definitions]

- [ ] Integration Method:
  - [ ] CoC: [configuration details if using CoC]
  - [ ] UltiSnips: [configuration details if using UltiSnips]
  - [ ] Other: [specify other snippet engine]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]

## Testing & Debugging

### Debugger

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]
  - [ ] Project-specific: [path relative to project root]

- [ ] Features:
  - [ ] Breakpoints: [configuration for breakpoint functionality]
  - [ ] Variable inspection: [setup for variable inspection features]
  - [ ] Step debugging: [configuration for step-through debugging]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]

### Test Runner

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]
  - [ ] Project-specific: [path relative to project root]

- [ ] Features:
  - [ ] Test discovery: [configuration for test discovery functionality]
  - [ ] Run single test: [setup for running individual tests]
  - [ ] Run test suite: [configuration for running test suites]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]

## Environment & Security

### Version/Environment Management

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]
  - [ ] Project-specific: [path relative to project root]

- [ ] Features:
  - [ ] Version management: [configuration for version management tools]
  - [ ] Environment isolation: [setup for environment isolation]
  - [ ] Dependencies: [dependency management configuration]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Integration with tools: [integration with other development tools]

### Configuration Files

- [ ] Required Files:
  - [ ] Internal (vim):
  - [ ] External:
  - [ ] Project-specific:

- [ ] Template Files:
  - [ ] Location:
  - [ ] Usage:

- [ ] Documentation:
  - [ ] File purpose:
  - [ ] Configuration options:

### Security Scanning

- [ ] Tool/Package:
  - [ ] Name and Link: [name and link to official documentation/repository]
  - [ ] Installation method: [package manager, manual build, etc.]
  - [ ] Version tested: [specific version number tested with this configuration]

- [ ] Configuration Location(s):
  - [ ] Internal (vim): [path to relevant .vim files]
  - [ ] External: [path to config files]
  - [ ] Project-specific: [path relative to project root]

- [ ] Features:
  - [ ] Severity levels: [configuration for security severity levels]
  - [ ] Ignore patterns: [setup for security scan exclusions]
  - [ ] CI integration: [configuration for continuous integration]

- [ ] Usage:
  - [ ] Basic commands: [list of essential commands]
  - [ ] Key mappings: [list of configured key mappings]

## Additional Information

### Notes

- [ ] Special considerations:
- [ ] Known issues:
- [ ] Limitations:
- [ ] Future improvements:
