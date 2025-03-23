---
html_theme.sidebar_secondary.remove: true
---

# 📜 CLI Reference

This page provides a quick reference to the available commands. Use this reference to quickly look up commands and their usage without diving into detailed documentation.

| **Command&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;** | **Description** | **Arguments/Options**     |
|---------------------------|--------------------------------------------------------------|----------------------------------------------------------------------------|
| **📝 `docs build`**       | Build static HTML documentation.                             | `[output]` - Build directory (optional, defaults to `_build`).             |
| **📝 `docs watch`**       | Build and serve live documentation.                          | `[output]` - Build directory (optional, defaults to `_build`).             |
| **📖 `examples build`**   | Build the specified examples.                                | `[examples...]` - List of examples to build (optional).                    |
| **📖 `examples watch`**   | Watch and rebuild the specified examples when changes occur. | `[examples...]` - List of examples to watch (optional).                    |
| **🧩 `modules build`**    | Build the specified modules.                                 | `[modules...]` - List of modules to build (optional).                      |
| **🧩 `modules check`**    | Check modules requirements and metadata.                     | No arguments.                                                              |
| **🧩 `modules link`**     | Link the generated packs to Minecraft. More information [here](project:getting-started.md#linking-modules-to-minecraft). | `[world]`, `--minecraft`, `--data-pack`, `--resource-pack` - Paths to their respective directories. |
| **🧩 `modules release`**  | Build zipped modules for release.                            | No arguments.                                                              |
| **🧩 `modules test`**     | Build and test the specified modules.                        | `[modules...]` - List of modules to test (optional).                       |
| **🧩 `modules update`**   | Update metadata changes.                                     | No arguments.                                                              |
| **🧩 `modules watch`**    | Watch and rebuild the specified modules when changes occur.  | `[modules...]` - List of modules to watch (optional).                      |

To run any command, type `pdm run` before the command itself. Alternatively, you can activate the virtual environment (venv) manually and run the command directly. Some commands also have aliases:

| **Alias**       | **Command**             |
|-----------------|-------------------------|
| `pdm run build` | `pdm run modules build` |
| `pdm run watch` | `pdm run modules watch` |
