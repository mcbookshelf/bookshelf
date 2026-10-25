# 🚀 Getting started

This page shows you how to build the modules on your computer and try them in Minecraft.

---

## Prerequisites

1. Install [uv](https://docs.astral.sh/uv/getting-started/installation/). It's a Python package and project manager. It installs Python and the project tools the first time you run a command.
2. Clone the repository. If you're new to GitHub, follow the [First Contributions guide](https://github.com/firstcontributions/first-contributions/blob/main/README.md).
3. Open the project folder in your code editor.

```{admonition} Editor support
:class: tip

If you use VS Code, install the recommended `mcbookshelf.vscode-bsdoc` extension. It helps you edit [module.bs files](project:metadata.md).
```

---

## Build the modules

The `modules` folder contains the source files of every module. These commands build them into the `build` folder:

:::{list-table}
*   - `uv run build`
    - Build all modules
*   - `uv run watch`
    - Build all modules, then build them again each time a file changes
*   - `uv run <build|watch> <name1> ...`
    - Build or watch only the modules, bundles, or examples you name
:::

```{admonition} Watch one module
:class: tip

A full build takes time. Watch only the module you work on: `uv run watch <module>`.
```

---

(contribute-linking-to-minecraft)=
## Link to Minecraft

The `link` command connects the `build` folder to a Minecraft world. Each build then copies the packs to that world.

:::{list-table}
*   - `world`
    - The name of the Minecraft world to link
*   - `--minecraft <DIRECTORY>`
    - Path to the `.minecraft` directory
*   - `--data-pack <DIRECTORY>`
    - Path to the data packs directory
*   - `--resource-pack <DIRECTORY>`
    - Path to the resource packs directory
:::

To test a module while you work on it:

```sh
# Link the build folder to a world
uv run link <world> --minecraft </path/to/.minecraft>

# Build the module again each time a file changes
uv run watch <module>
```

The `watch` command also reloads the world after each build.
