# 🚀 Quickstart

This page gives a quick overview of how to get started with the Bookshelf library, and how to use it.

---

## 📥 Installation

:::::{tab-set}
::::{tab-item} 🔌 from manager

The [Bookshelf Manager](https://mcbookshelf.dev) is the official tool for creating your own custom Bookshelf bundle.

### ✨ Key Benefits

- 🎯 **Precise Selection**: Choose exactly the modules you need
- 📊 **Dependency Visualization**: Intuitive interface showing relationships between modules
- 🏷️ **Tag System**: Easily identify modules with tags, grouping them by purpose

### 📥 Installation Steps

1. Visit [mcbookshelf.dev](https://mcbookshelf.dev)
2. Select your desired modules
3. Review automatically added dependencies
4. Download your custom bundle

::::
::::{tab-item} 🏷️ from release

Bookshelf releases are available on both [GitHub](https://github.com/mcbookshelf/bookshelf/releases) and [Modrinth](https://modrinth.com/organization/mcbookshelf).
In each release, you will find zipped datapacks.

### 📥 Installation Options

📚 **Bundles:** You can download entire bundles which includes all modules and dependencies of a certain type in a single datapack. This is a good option if you want to explore everything Bookshelf has to offer.

🧩 **Module by Module:** Alternatively, you can download individual modules as datapacks. Each module zip file contains all the dependencies needed for that module to work. This is a great option if you only need specific functionalities and want to keep your installation lightweight.

After downloading, move the zip file to the datapacks directory of your Minecraft world.
::::
::::{tab-item} 🐍 from PyPI

If you're using the [beet](https://github.com/mcbeet/beet) build pipeline, you can install the Bookshelf package (`mcbookshelf`) from PyPI to include Bookshelf modules in your build.

### 📥 Installation Steps

```shell
pip install mcbookshelf
```

Once installed, you can reference Bookshelf modules directly in your beet configuration.

To include a complete bundle or a specific module:
```yaml
require:
  - bookshelf.bundle.dev
  - bookshelf.bundle.<name_of_bundle>
  - bookshelf.module.raycast
  - bookshelf.module.<name_of_module>
```
::::
::::{tab-item} 🗃️ from source

If you're a developer who wants to work directly with the source code, you'll need to build Bookshelf before using it. This build process is necessary because some features require computed data that can't be directly included in the source code. Here's how to get started:

### 🛠️ Prerequisites

- Basic understanding of datapacks
- [UV](https://docs.astral.sh/uv/getting-started/installation/) installed
- Git (for cloning the repository)

### 📥 Installation Steps

1. Clone the repository:
```shell
git clone https://github.com/mcbookshelf/bookshelf.git
cd bookshelf
```

2. Build the library:
```shell
uv run modules build
```

After building, you'll find all modules as datapacks in the `build` folder. Each module includes its own dependencies as well as some utility namespaces.

::::
:::::

```{admonition} Note
:class: note
Please note that while the datapacks from releases are stable, they might not include the very latest features or fixes that are available in the source code. If you want the most up-to-date version of Bookshelf, consider installing from source or downloading a pre-release from GitHub.
```

If you like the project, don't hesitate to star it on [GitHub](https://github.com/mcbookshelf/bookshelf) and/or follow it on [Modrinth](https://modrinth.com/organization/mcbookshelf) 😉.

---

## 👶 First Steps

Once you’ve downloaded your Bookshelf datapack bundle (or multiple modules), install them in your Minecraft world.
If you’re not familiar with installing datapacks, follow [this](https://datapack.wiki/guide/installing-a-datapack) tutorial.

Now that Bookshelf is installed, you can verify that everything is working by running:

```mcfunction
function #bs.load:status
```

This command lists all loaded modules with their respective versions and checks for compatibility issues.

From there, you can explore the documentation for individual modules, try out examples, and start integrating their functionality into your own projects!

:::{important}

Bookshelf relies on persistent entities to enhance performances. Therefore, it's important not to kill all entities. Instead, you can use the command `kill @e[tag=!bs.persistent]`. [Learn more here](contribute/shared-resources.md#entities)
:::

### 📖 Good Practices

Bookshelf is designed to minimize unintended side effects. However, complications can arise when multiple datapacks utilize the same one. To prevent potential issues, it's always recommended to set inputs prior to executing a function. This holds true even though Bookshelf adheres to a strict policy of preserving inputs. By following this practice, you can prevent unexpected behaviors.

:::{note}
This section is in progress. If you have some ideas about how to improve the first steps with Bookshelf, please share it on our [Discord server](https://discord.gg/MkXytNjmBt).
:::

---

```{include} _templates/comments.md
```
