## Java

This document outlines the support for Java development within the Vim
environment.

Note: coc-java is preferred over ALE's Java linters because it uses the
Eclipse JDT language server (jdtls), which provides accurate project-aware
diagnostics using the full classpath. ALE's `javac` linter cannot resolve
dependencies without significant manual classpath configuration. coc-java
manages jdtls automatically with no manual classpath setup required.

### External Packages Used

Install manually:

#### google-java-format

Optional. Provides formatting via ALE when installed. coc-java does not
include a formatter.

```bash
mkdir -p ~/.local/lib ~/.local/bin

wget -q https://github.com/google/google-java-format/releases/download/v1.22.0/google-java-format-1.22.0-all-deps.jar \
    -O ~/.local/lib/google-java-format.jar

cat > ~/.local/bin/google-java-format <<'EOF'
#!/usr/bin/env bash
exec java -jar ~/.local/lib/google-java-format.jar "$@"
EOF

chmod +x ~/.local/bin/google-java-format
```

Verify ALE can find it by opening a `.java` file and running `:ALEInfo`.

### CoC Extensions Used

* [`coc-java`](https://github.com/neoclide/coc-java) (CoC Extension) -
    Provides Java language server support via Eclipse JDT (jdtls). Features
    include auto-completion, go-to-definition, find references, rename,
    inline diagnostics, and code actions. jdtls is downloaded and managed
    automatically on first use (~200 MB).

Install with `:CocInstall coc-java`, or add `coc-java` to `g:coc_global_extensions`
in `plugin/coc.vim` to make it persistent.

On first open of a `.java` file, jdtls indexes the project. Build system
projects (Gradle, Maven) are detected automatically from their root files.

Useful commands when jdtls misbehaves:

* `:CocCommand java.clean.workspace` — rebuild the project index
* `:CocCommand java.open.output` — show the jdtls log

### Configuration Files Used

* `coc-settings` — Use `:CocConfig` to edit this file. The
    `workspace.rootPatterns` list must include Gradle and Maven root files so
    jdtls can locate the project root.
* [`java.vim`](../.vim/pack/zzz-settings/start/settings/after/ftplugin/java.vim)
    — Java-specific indentation, ALE linter suppression, and optional
    google-java-format fixer.

### Configured Features

#### Syntax Highlighting

Provided by vim-polyglot with no additional configuration required.

#### Auto Completion

* **Tool**: jdtls via `coc-java`
* **Features**: Method and field completion, import completion, constructor
    completion, and snippet expansion for common patterns

#### Linting and Static Analysis

* **Tool**: jdtls via `coc-java`
* **Configuration**: ALE Java linters are disabled in `java.vim` to prevent
    duplicate and conflicting diagnostics
* **Usage**: Errors and warnings appear in the location list and gutter

#### Formatting

* **Tool**: `google-java-format` via ALE (only active when the binary is on
    `$PATH`)
* **Configuration**: Set as a conditional fixer in `java.vim`
* **Usage**: Runs on save via `b:ale_fix_on_save`, or manually with `:ALEFix`

#### Indentation

* **Configuration**: None — global 2-space default is kept intentionally
* **Reason**: `google-java-format` enforces 2-space block indentation per the
    Google Java Style Guide, so overriding to 4 spaces would conflict with
    the formatter on save

### Default or Inapplicable Sections

The following features use default settings without additional configuration:

* Error Highlighting (handled by coc-java and ALE)
* Code Folding (uses Vim's default folding mechanisms)
* Snippets (not configured; coc-java includes basic snippets via jdtls)
* Schema Validation (not applicable)
* Version Control Integration (uses global Git integration)
* Filetype Detection (handled by vim-polyglot)
