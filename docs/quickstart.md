# 🚀&nbsp;Quickstart

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

```{admonition} Note
:class: note
Please note that while the datapacks from releases are stable, they might not include the very latest features or fixes that are available in the source code. If you want the most up-to-date version of Bookshelf, consider installing from source.
```

::::
::::{tab-item} 🏷️ from release

Bookshelf releases are available on both [Github](https://github.com/mcbookshelf/bookshelf/releases) and [Modrinth](https://modrinth.com/datapack/bookshelf-library).
In each release, you will find zipped datapacks.

### 📥 Installation Options

📚 **Bundles:** You can download entire bundles which includes all modules and dependencies of a certain type in a single datapack. This is a good option if you want to explore everything Bookshelf has to offer.

🧩 **Module by Module:** Alternatively, you can download individual modules as datapacks. Each module zip file contains all the dependencies needed for that module to work. This is a great option if you only need specific functionalities and want to keep your installation lightweight.

After downloading, move the zip file to the datapacks directory of your Minecraft world.

```{admonition} Note
:class: note
Please note that while the datapacks from releases are stable, they might not include the very latest features or fixes that are available in the source code. If you want the most up-to-date version of Bookshelf, consider installing from source.
```

If you like the project, don't hesitate to star it on Github and/or follow it on Modrinth 😉.

::::
::::{tab-item} 🐍 from PyPI

If you're using the [beet](https://github.com/mcbeet/beet) build pipeline, you can install the Bookshelf package (`mcbookshelf`) from PyPI to include Bookshelf modules in your build.

### 📥 Installation Steps

```shell
pip install mcbookshelf
```

Once installed, you can reference Bookshelf modules directly in your beet pipeline configuration.

To include a specific module:
```yaml
pipeline:
  - bookshelf.module.raycast
  - bookshelf.module.<name_of_other_module>
```

To include a full bundle:
```yaml
pipeline:
  - bookshelf.bundle.dev
  - bookshelf.bundle.<name_of_other_bundle>
```

```{admonition} Note
:class: note
Please note that while the datapacks from releases are stable, they might not include the very latest features or fixes that are available in the source code. If you want the most up-to-date version of Bookshelf, consider installing from source.
```

::::
::::{tab-item} 🗃️ from source

If you're a developer who wants to work directly with the source code, you'll need to build Bookshelf before using it. This build process is necessary because some features require computed data that can't be directly included in the source code. Here's how to get started:

### 🛠️ Prerequisites

- Basic understanding of datapacks
- [Python](https://www.python.org/downloads/) and [PDM](https://pdm.fming.dev/latest/) (Python Dependency Manager) installed
- Git (for cloning the repository)

### 📥 Installation Steps

1. Clone the repository:
```shell
git clone https://github.com/mcbookshelf/bookshelf.git
cd bookshelf
```

2. Install dependencies:
```shell
pdm install
```

3. Build the library:
```shell
pdm run modules build
```

After building, you'll find all modules as datapacks in the `build` folder. Each module includes its own dependencies as well as some utility namespaces, allowing you to install only what you need.

```{admonition} Note
:class: note
The main datapack contains files in the `minecraft` namespace for autoloading and ticking. While these files aren't strictly required, they handle module autoloading and tick functions.
```

::::
:::::

---

## 👶 First Steps

:::{important}

Bookshelf relies on persistent entities to enhance performances. Therefore, it's important not to kill all entities. Instead, you can use the command `kill @e[tag=!bs.persistent]`. [Learn more here](contribute/shared-resources.md#entities)
:::

### 📖 Good Practices

Bookshelf is designed to minimize unintended side effects. However, complications can arise when multiple datapacks utilize the same one. To prevent potential issues, it's always recommended to set inputs prior to executing a function. This holds true even though Bookshelf adheres to a strict policy of preserving inputs. By following this practice, you can ensure smoother operation and prevent unexpected behaviors.

:::{note}
This section is in progress. If you have some ideas about how to improve the first steps with Bookshelf, please share it on our [Discord server](https://discord.gg/MkXytNjmBt).
:::

---


<!--

Now that Bookshelf is installed on your map (or once you are on the sandbox map), let's start to make some basic stuff to understand how it work!

First, let's test if Bookshelf is correctly installed. To do so, enter the following command in your chat:

```
/function bs:hello
```

If the Gunivers-Lib is well installed, you should see "Hello World!" in the chat. If it's not the case, verify that the cheat are enabled in your world (or command-blocks are enabled in the `server.properties` file if you are on a server).

Great! Now, let's play with funny things. Place a command-block in repreat mode and powered.

<div align="center">

![](https://gunivers.net/wp-content/uploads/2022/06/Command-block-repeat-1.png)

</div>

In this command block, you can enter the command of one of the following example system:

- **LGdir** : this system allow you to shoot lasers. To shoot, take a `carrot_on_a_stick` and right-click on it!
    ```
    function bs.example:lgdir
    ```
- **Drop to place** : this system allow you to place minecraft blocks by dropping the items instead of right clicking on it. Useless so essential!
    ```
    function bs.example:drop_to_place
    ```
- **Walk Trail** : this system create a trail where the players are walking. This trail is made of items corresponding to the block they are walking on.
    ```
    function bs.example:walk_trail
    ```


:::{note}
This section is in progress. If you have some ideas about how to improves the first steps with the Glibs, please share it on our [Discord server](https://discord.gg/MkXytNjmBt).
:::

---
-->

```{include} _templates/comments.md
```
