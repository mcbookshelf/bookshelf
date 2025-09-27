---
html_theme.sidebar_secondary.remove: true
---

# 📜 CLI Reference

This page provides a quick reference to the available commands. Use this reference to quickly look up commands and their usage without diving into detailed documentation.

| **Command&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;** | **Description** | **Arguments/Options**     |
|--------------------------|---------------------------------------------------------------|----------------------------------------------------------------|
| **🔍 `check`**           | Check project requirements and metadata.                      | No arguments.                                                  |
| **📑 `update`**          | Update project metadata changes.                              | No arguments.                                                  |
| **🔗 `link`**            | Link the generated packs to Minecraft. More information [here](project:getting-started.md#linking-modules-to-minecraft). | `[world]`, `--minecraft`, `--data-pack`, `--resource-pack` - Paths to their respective directories. |
| **📝 `docs build`**      | Build static HTML documentation.                              | `[output]` - Build directory (optional, defaults to `_build`). |
| **📝 `docs watch`**      | Build and serve live documentation.                           | `[output]` - Build directory (optional, defaults to `_build`). |
| **📖 `examples build`**  | Build the specified examples.                                 | `[examples...]` - List of examples to build (optional).        |
| **📖 `examples watch`**  | Watch and rebuild the specified examples when changes occur.  | `[examples...]` - List of examples to watch (optional).        |
| **🧩 `modules build`**   | Build the specified modules.                                  | `[modules...]` - List of modules to build (optional).          |
| **🧩 `modules release`** | Build zipped modules for release.                           | No arguments.                                                    |
| **🧩 `modules test`**    | Build and test the specified modules.                       | `[modules...]` - List of modules to test (optional).             |
| **🧩 `modules watch`**   | Watch and rebuild the specified modules when changes occur. | `[modules...]` - List of modules to watch (optional).            |



To run any command, type `uv run` before the command itself. Alternatively, you can activate the virtual environment (venv) manually and run the command directly. Some commands also have aliases:

| **Alias**      | **Command**            |
|----------------|------------------------|
| `uv run build` | `uv run modules build` |
| `uv run watch` | `uv run modules watch` |
