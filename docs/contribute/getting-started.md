---
html_theme.sidebar_secondary.remove: true
---

# 🚀 Getting Started

This guide will walk you through setting up a local development environment to build, test, and contribute to our modules.

---

## ⚙️ Prerequisites

Before you start, make sure your system is ready by completing the following steps:

1. **Install [UV](https://docs.astral.sh/uv/getting-started/installation/)**, a Python package and project manager.
2. **Clone the repository**, if you haven’t done this before, follow this step-by-step tutorial: [First Contributions Guide](https://github.com/firstcontributions/first-contributions/blob/main/README.md). Once cloned, open the project folder in your preferred code editor.

---

## 🔨 Building Modules

The `modules` directory contains the source files for all modules. Use the following commands to manage and build them efficiently:

:::{list-table}
*   - `uv run modules build`
    - Build all modules
*   - `uv run modules watch`
    - Monitor changes and rebuild modules automatically
*   - `uv run modules <build|watch> <module1> ...`
    - Build or watch only the specified modules
*   - `uv run link [world]`
    - Link the generated resource and data packs to a Minecraft world
:::

```{admonition} Watching Modules
:class: tip

Building modules can take some time. For a smoother experience, it's recommended to only watch the module you're currently working on: `uv run modules watch <module>`.
```

### Linking Modules to Minecraft

The `link` command allows you to integrate generated packs directly into a Minecraft world. Below are the options available for this command:

:::{list-table}
*   - `world (optional)`
    - The name of the Minecraft world to link
*   - `--minecraft <DIRECTORY>`
    - Path to the `.minecraft` directory (location of Minecraft files)
*   - `--data-pack <DIRECTORY>`
    - Path to the directory where data packs are stored
*   - `--resource-pack <DIRECTORY>`
    - Path to the directory where resource packs are stored
:::

This workflow demonstrates how to link and continuously test your modules directly in Minecraft:
```sh
# Link modules to a specific world
uv run link <world> --minecraft </path/to/.minecraft>

# Monitor changes and rebuild a module for the linked world
uv run modules watch <module>
```

---

## 🧪 Testing Modules

Testing is a fundamental aspect of software development. It helps ensure the correctness of your code and can save you from potential bugs in the future.

To learn how to write and run tests for your modules, refer to the [Debug Section](project:debug-tools.md#-unit-tests).
