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
Then, require the modules you need in your beet config. Each one is merged into your data pack with its dependencies:

:::{code-block} yaml
:caption: beet.yml
require:
  - mcbookshelf.module.<name_of_module>
  - mcbookshelf.module.raycast
:::

To import only what your project uses, require `mcbookshelf.auto` instead. It reads the files of your data pack and merges the Bookshelf features they reference:

:::{code-block} yaml
:caption: beet.yml
require:
  - mcbookshelf.auto
:::

Both read these options, all of them optional:

:::{code-block} yaml
:caption: beet.yml
meta:
  bookshelf:
    version: 5.0.0        # the Bookshelf release to use, the latest by default
    minecraft: "26.3"     # only a release made for this Minecraft version
    modules:
      bs.raycast: 5.0.1   # one module at another version
    include:              # for `mcbookshelf.auto`: what to import even when nothing references it
      - bs.raycast        # a whole module
      - bs.raycast:cast   # or one feature
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
   uv run build
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
- Bookshelf uses persistent entities. Avoid `kill @e`, use `kill @e[tag=!bs.persistent]` instead. [Learn more](#contribute-shared-resources)
- Side effects are rare, but conflicts can occur if multiple datapacks use the same functions. Always set inputs before running a function.
:::

Next, check out the [modules](modules/index.md) documentation to see each module in detail and learn how to use them.

:::{note}
This section is in progress. If you have ideas to improve it, share them on the [Discord](https://discord.gg/aV5SF3JsAZ) server.
:::

---

```{include} _templates/comments.md
```
