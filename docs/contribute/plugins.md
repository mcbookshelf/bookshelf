# 🧩 Module plugins

A module can generate some of its files when you build it. You write these generators as Python plugins for [Beet](https://github.com/mcbeet/beet). Bookshelf provides a few helpers.

---

## When to write a plugin

Write a plugin when the files come from the game data, or when they repeat too much to write yourself. For example:

- A tag that lists every block with a given property.
- A number provider with one branch per block or entity.
- A table of values to load in a storage.

If the data doesn't come from the game and fits in one file, write the file yourself.

---

## Write a generator

A plugin is a Python file at the root of the module that defines a `beet_default` function. Add the `@generator` decorator. Then yield each file that you create, with its ID:

```{code-block} python
:caption: modules/bs.bitwise/plugin.py
from beet import Context, ContextIntProvider

from mcbookshelf.meta import Module
from mcbookshelf.minecraft.math import int_storage
from mcbookshelf.pipeline.plugins import Generated, generator


@generator
def beet_default(ctx: Context) -> Generated:
    module: Module = ctx.meta["module"]
    n = int_storage(f"{module.id}:not", "in.n")
    yield f"{module.id}:not", ContextIntProvider((-1 - n).json())
```

To read the content of `module.bs`, use `ctx.meta["module"]`.

---

## Helpers

The `mcbookshelf.minecraft` package holds the code that plugins share. Put any logic that isn't specific to one module there.

:::{list-table}
*   - `block`
    - Gets the blocks of the Minecraft version and their states. Builds lookup tables by block state
*   - `entity`
    - Gets the entities of the Minecraft version and their dimensions
*   - `data`
    - Downloads any other data file of the Minecraft version
*   - `math`
    - Builds number providers from Python expressions
*   - `condition`
    - Builds predicates that you combine with `&`, `|`, and `~`
*   - `snbt`
    - Writes a value as compact SNBT for commands
:::
