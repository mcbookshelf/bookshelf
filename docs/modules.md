---
html_theme.sidebar_secondary.remove: true
---

# 🧩 Modules

Bookshelf is designed with modularity in mind. Features that serve a common purpose are organized into distinct, standalone, namespaced modules.

---

## 🌟 Featured Modules

```{include} _templates/featured-modules.md
```

## 📚 Glossary

Here are some of the key terms used throughout the documentation.

:::{list-table}
*   - **Bundle**
    - A collection of modules that are shipped together.
*   - **Feature**
    - Something designed for the final user in order to allow them to perform a task. Most of the time, a feature is a function tag to call instead of the function. A feature can also be a loot table, a structure, a predicate or whatever.
*   - **Module**
    - A group of features that share a common purpose and that are contained in a namespace (i.e. datapack structures).
*   - **`ata` functions**
    - `ata` is for "as to at". These functions takes two different positions as arguments: the one is given through the positional argument (`positioned`, `at`, _etc._), and the other one is given is the executor's position.
*   - **`on_<event>` function macro argument**
    - Used to specify a command that should be executed by the feature when a specific event occurs.
*   - **`run` function macro argument**
    - Used to specify a command that should be executed by the feature, often immediately.
*   - **`with` function macro argument**
    - Used to specify optional arguments.
:::


```{toctree}
:hidden:
:caption: Runtime

modules/bitwise
modules/block
modules/color
modules/environment
modules/generation
modules/health
modules/hitbox
modules/id
modules/interaction
modules/link
modules/math
modules/move
modules/position
modules/random
modules/raycast
modules/schedule
modules/sidebar
modules/time
modules/vector
modules/view
modules/xp
```

```{toctree}
:hidden:
:caption: Development

modules/dump
modules/log
```

```{toctree}
:hidden:
:caption: Prefabs

modules/tree
```
