# 📖 Code style

Bookshelf follows a few conventions. They make the code easier to read and understand.

---

## Naming

:::{list-table}
*   - **Files**
    - Use snake_case. Names with double underscores are [reserved](#contribute-reserved-names). A `_` prefix marks a [private file](#contribute-public-and-private-files)

      *Example: `function/<feature>/<my_function>.mcfunction`*
*   - **Data storage**
    - Use snake_case. Inputs and outputs go in the storage of their feature, or of their [group](#contribute-groups). Other data goes in the storage of the module

      *Example: `bs.<module>:<feature> in`, `bs.<module>:<group> in`, or `bs.<module>: <my_key>`*
*   - **Objectives**
    - Use snake_case and the `bs.` prefix. Create an objective only if no [shared objective](#contribute-shared-resources) fits

      *Example: `bs.my_objective`*
*   - **Scoreholders**
    - Start with `#`. Use a single letter for a temporary score. Add the module name for a global score

      *Example: `#x bs.ctx` or `#<module>.<my_key> bs.data`*
*   - **Functions**
    - Use snake_case. Add the `_ata` suffix ("as to at") to a function that needs two positions. It uses the position of the executor and the position of the execution

      *Example: `get_distance_ata`*
*   - **Entity tags**
    - Use snake_case. Start with `bs.` and the module name

      *Example: `bs.<module>.my_tag`*
:::

---

(contribute-license-header)=
## License header

Start every function with the license header. This includes tests.

```
# ------------------------------------------------------------------------------------------------------------
# Copyright (c) <YEAR> Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------
```

Replace `<YEAR>` with the current year. The `uv run check` command checks the header. See the [validation page](project:validation.md).

---

(contribute-shared-resources)=
## Shared resources

Modules share a few objectives, blocks, and entities. A module creates the ones it uses in its `__load__` function.

### Objectives

| Objectives  | Description |
|-------------|-------------|
| `bs.ctx`    | Temporary scores for fast computations. Don't rely on them after the function ends. Format: `#<single_letter>` |
| `bs.data`   | Global scores. Format: `#<module>.<my_key>` |

### Blocks

These blocks stay in a chunk that is always loaded, at `-30000000 1600`. You can use them from anywhere.

```mcfunction
# Block for manipulating loots
setblock -30000000 0 1606 minecraft:decorated_pot

# Command block for system time (command block output)
setblock -30000000 0 1605 minecraft:repeating_command_block[facing=up]{auto:1b,Command:"help me",TrackOutput:1}
```

### Entities

Global entities have fixed UUIDs. You can always select them, and no selector matches them by mistake. Move them back to the always-loaded chunk at `-30000000 1600` before the tick ends.

```{code-block} mcfunction
:force:
# Marker for position, arithmetic, and various utilities
execute unless entity B5-0-0-0-1 run summon minecraft:marker -30000000 0 1600 {UUID:[I;181,0,0,1],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"]}

# Text display entity for interpreting text or computing transformations
execute unless entity B5-0-0-0-2 run summon minecraft:text_display -30000000 0 1600 {UUID:[I;181,0,0,2],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],view_range:0f,alignment:"center"}

# Item display entity for manipulating loots or computing transformations
execute unless entity B5-0-0-0-3 run summon minecraft:item_display -30000000 0 1600 {UUID:[I;181,0,0,3],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],view_range:0f}
```

Add these tags to the entities that Bookshelf creates. They follow the [Smithed conventions](https://docs.smithed.dev/conventions/):

:::{list-table}
*   - **smithed.entity**
    - A datapack created this entity. Datapacks that target vanilla entities must not change it

*   - **smithed.strict**
    - A datapack created this entity. Other datapacks must not change it

*   - **bs.persistent**
    - This Bookshelf entity must stay in the world. Don't kill it or let it despawn

*   - **bs.entity**
    - Bookshelf created this entity
:::

---

## Temporary entities

When a function needs an entity for a short time, summon a marker and run as it:

```mcfunction
execute summon minecraft:marker run function bs.hitbox:utils/get_fract_pos
```

Before you kill a temporary entity, move it out of the world. Otherwise, sculk sensors can detect its death. Do this on every path that ends the function:

```mcfunction
tp @s ~ -1000000 ~
kill @s
```

If you must select a temporary entity from another place, give it a fixed UUID. Each module that needs one has its own UUID. A feature can then call a feature of another module, and the two don't use the same entity.

The UUID is `B5-0-0-0-` and a last group of your choice:

- Pick up to 7 hex digits at random, for example `B5-0-0-0-3FA91C2`. You don't need to check which ones other modules use.
- In the data of the entity, the UUID is `[I;181,0,0,<n>]`, where `<n>` is the last group as a decimal number: `3FA91C2` is `66752962`. With 7 digits or fewer, this number is never negative.

An entity that you summon in a chunk whose entities aren't loaded can't be selected, but it still takes its UUID. Summon the entity only in a loaded chunk. Kill the entity of a previous call first: the command limit can stop a call before it kills its entity.

```{code-block} mcfunction
:force:
execute unless loaded ~ ~ ~ run return fail
kill B5-0-0-0-3FA91C2
summon minecraft:marker ~ ~ ~ {UUID:[I;181,0,0,66752962]}
execute as B5-0-0-0-3FA91C2 run function bs.<module>:...
```
