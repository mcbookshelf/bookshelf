---
html_theme.sidebar_secondary.remove: true
---

# 🚀 Getting Started

This guide will walk you through setting up a local development environment to build, test, and contribute to our modules.

---

## ⚙️ Prerequisites

Before getting started, ensure your system is prepared by following these steps:

1. Install [**PDM**](https://pdm-project.org/en/latest/), the Python Dependency Manager.
2. Open a terminal and run the following command to install all required dependencies:
  ```sh
  pdm install
  ```

Running this command prepares your environment for building and testing the project.

---

## 🔨 Building Modules

The `modules` directory contains the source files for all modules. Use the following commands to manage and build them efficiently:

:::{list-table}
*   - `pdm run modules build`
    - Build all modules.
*   - `pdm run modules watch`
    - Monitor changes and rebuild modules automatically.
*   - `pdm run modules <build|watch> <module1> ...`
    - Build or watch only the specified modules.
*   - `pdm run modules link [world]`
    - Link the generated resource and data packs to a Minecraft world.
:::

```{admonition} Watching Modules
:class: tip

Building modules can take some time. For a smoother experience, it's recommended to only watch the module you're currently working on: `pdm run modules watch <module>`.
```

### Linking Modules to Minecraft

The `link` command allows you to integrate generated packs directly into a Minecraft world. Below are the options available for this command:

:::{list-table}
*   - `world (optional)`
    - The name of the Minecraft world to link.
*   - `--minecraft <DIRECTORY>`
    - Path to the `.minecraft` directory (location of Minecraft files).
*   - `--data-pack <DIRECTORY>`
    - Path to the directory where data packs are stored.
*   - `--resource-pack <DIRECTORY>`
    - Path to the directory where resource packs are stored.
:::


This workflow demonstrates how to link and continuously test your modules directly in Minecraft:
```sh
# Link modules to a specific world
pdm run modules link <world> --minecraft </path/to/.minecraft>

# Monitor changes and rebuild a module for the linked world
pdm run modules watch <module>
```

## 🧪 Testing Modules

Testing modules ensures their functionality and reliability within the Minecraft environment. This section outlines how to execute and create tests for your modules.

### Running Tests
You can run all tests for the modules using [PackTest](https://github.com/misode/packtest), a tool designed for Minecraft datapack testing. Make sure you have Java installed on your system, as it's required for PackTest to function.

To execute the tests, run:
```sh
pdm run modules test
```

### Writing Tests

To learn how to write effective tests for your modules, refer to the [Debug Section](project:debug.md#-unit-tests).
