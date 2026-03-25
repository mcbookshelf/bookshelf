# 🚀 Quickstart

This page shows how to start using Bookshelf. Like it? Star on [GitHub](https://github.com/mcbookshelf/bookshelf) or follow on [Modrinth](https://modrinth.com/organization/mcbookshelf).

---

## 📥 Installation

:::::{tab-set}
::::{tab-item} 🔌 from manager

Use the manager to make a custom bundle.

1. Go to [mcbookshelf.dev](https://mcbookshelf.dev)
2. Pick your modules
3. Review dependencies
4. Download the bundle

After downloading, move the ZIP file to your world's `datapacks` folder.

::::
::::{tab-item} 🏷️ from release

Get releases from [GitHub](https://github.com/mcbookshelf/bookshelf/releases) or [Modrinth](https://modrinth.com/organization/mcbookshelf).
You can download either:

- 📚 **Bundles:** groups of related modules with their dependencies
- 🧩 **Modules:** a single module with its dependencies

After downloading, move the ZIP file to your world's `datapacks` folder.

::::
::::{tab-item} 🐍 from PyPI, with Beet

If you use the [beet](https://github.com/mcbeet/beet) pipeline, install `mcbookshelf` from PyPI:

```shell
pip install mcbookshelf
```
Then, reference Bookshelf bundles or modules in your beet config:

:::{code-block} yaml
:caption: beet.yml
require:
  - bookshelf.bundle.<name_of_bundle>
  - bookshelf.bundle.dev
  - bookshelf.module.<name_of_module>
  - bookshelf.module.raycast
:::

::::
::::{tab-item} 🗃️ from source

To work with the source code, you must first build Bookshelf.

### 🛠️ Requirements

- Datapack basics
- [Git](https://git-scm.com/install/) installed
- [uv](https://docs.astral.sh/uv/getting-started/installation/) installed

### 📥 Installation steps

1. Clone the repository:
   ```shell
   git clone https://github.com/mcbookshelf/bookshelf.git
   cd bookshelf
   ```

2. Build the modules:
   ```shell
   uv run modules build
   ```

Built modules appear in the `build` folder.

::::
:::::

```{tip}
Release datapacks are stable but may not be the newest. For the latest features or fixes, build from source or use a pre-release.
```

---

## 👶 First steps

Run this command to check the installation:

```mcfunction
function #bs.load:status
```

This lists loaded modules and checks for compatibility issues. If you need help installing a datapack, see [this guide](https://datapack.wiki/guide/installing-a-datapack).

From there, you can explore the documentation for individual modules, try out examples, and start integrating their functionality into your own projects!

:::{important}
- Bookshelf uses persistent entities. Avoid `kill @e`, use `kill @e[tag=!bs.persistent]` instead. [Learn more](contribute/shared-resources.md#entities)
- Side effects are rare, but conflicts can occur if multiple datapacks use the same functions. Always set inputs before running a function.
:::

Next, check out the [modules](modules/index.md) documentation to see each module in detail and learn how to use them.

:::{note}
This section is in progress. If you have ideas to improve it, share them on the [Discord](https://discord.gg/MkXytNjmBt) server.
:::

---

```{include} _templates/comments.md
```
