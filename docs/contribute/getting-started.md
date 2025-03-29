---
html_theme.sidebar_secondary.remove: true
---

# 🚀 Getting Started

This guide will walk you through setting up a local development environment to build, test, and contribute to our modules.

---

## ⚙️ Prerequisites

Before getting started, ensure your system is prepared by following these steps:

1. Install [**PDM**](https://pdm-project.org/en/latest/), the Python Dependency Manager
2. Open a terminal at the root of the project and run the following command to install all required dependencies:
  ```sh
  pdm install
  ```

Running this command prepares your environment for building and testing the project.

---

## 🔨 Building Modules

The `modules` directory contains the source files for all modules. Use the following commands to manage and build them efficiently:

:::{list-table}
*   - `pdm run modules build`
    - Build all modules
*   - `pdm run modules watch`
    - Monitor changes and rebuild modules automatically
*   - `pdm run modules <build|watch> <module1> ...`
    - Build or watch only the specified modules
*   - `pdm run modules link [world]`
    - Link the generated resource and data packs to a Minecraft world
:::

```{admonition} Watching Modules
:class: tip

Building modules can take some time. For a smoother experience, it's recommended to only watch the module you're currently working on: `pdm run modules watch <module>`.
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
pdm run modules link <world> --minecraft </path/to/.minecraft>

# Monitor changes and rebuild a module for the linked world
pdm run modules watch <module>
```

---

## 🧪 Testing Modules

Testing is a fundamental aspect of software development. It helps ensure the correctness of your code and can save you from potential bugs in the future.

To learn how to write and run tests for your modules, refer to the [Debug Section](project:debug-tools.md#-unit-tests).
