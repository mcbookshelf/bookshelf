---
hide-sidebar-secondary: true
---

# 📜 Commands

This page lists the commands of the project. Type `uv run` before each command.

---

## Modules

| **Command** | **Description** | **Arguments and options** |
|-------------|-----------------|---------------------------|
| **🔨 `build`** | Build modules, bundles, or examples. | `[names...]`: what to build. The default is all modules. |
| **👀 `watch`** | Build, then build again when a file changes. Reload the linked world. | `[names...]`: what to build. The default is all modules. |
| **🔗 `link`** | [Link the packs to Minecraft](#contribute-linking-to-minecraft). | `[world]`, `--minecraft`, `--data-pack`, `--resource-pack` |
| **🔍 `check`** | [Check modules](project:validation.md) and list every issue. | `[modules...]`: the modules to check. The default is all modules. |
| **🧪 `test`** | Build modules and [run their tests](#contribute-running-tests). | `[modules...]`: the modules to test. The default is all modules.<br>`--coverage`, `--coverage-report`, `--verbose`, `--reporter`, `--junit-xml` |

---

## Documentation

| **Command** | **Description** | **Arguments and options** |
|-------------|-----------------|---------------------------|
| **📝 `docs build`** | Build the documentation as static HTML. | `[output]`: the build directory. The default is `_build`.<br>`--builder`: the Sphinx builder. The default is `html`.<br>`--lang`: the language. The default is `en`. |
| **📝 `docs watch`** | Build the documentation and serve it with hot reload. | Same as `docs build`. |
| **🌍 `docs locales update`** | Update the translation files of every language. | No arguments. |
| **🌍 `docs locales add`** | Create the translation files of a new language. | `<lang>`: the language to add. |

---

## Releases

These commands are for maintainers. See the [maintainer guide](project:maintainers.md).

| **Command** | **Description** | **Arguments and options** |
|-------------|-----------------|---------------------------|
| **🔢 `bump`** | Set the versions that a release requires. | `--check`: list the wrong versions and change nothing. |
| **📋 `notes`** | Write the release notes from the module changelogs. | `--unreleased`: use the `Unreleased` sections.<br>`--output`: write to a file. |
| **📦 `release`** | Build the released modules and bundles as zipped packs. | `--all`: include experimental features and modules under `1.0.0`. |
| **🚀 `publish`** | Publish the release folder to the platforms. | `--platform`: `modrinth` or `smithed`. The default is both.<br>`--dry-run`: list the packs and stop. |
| **ℹ️ `info`** | Print the version, the tag, and the Minecraft version of the release. | No arguments. |
