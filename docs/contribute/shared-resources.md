---
hide-sidebar-secondary: true
---

# 🌐 Shared Resources

To minimize redundancy and enhance efficiency, the library provides shared objectives, storages, blocks, and entities that modules can leverage.

---

## Objectives

| Objectives  | Description |
|-------------|-------------|
| `bs.in`     | Stores input values. Format: `$<module>.<feature>.<input_key>` |
| `bs.out`    | Stores output values. Format: `$<module>.<feature>` or `$<module>.<feature>.<output_key>` |
| `bs.ctx`    | Temporary contextual objective for fast computations. Format: `#<single_letter>` |
| `bs.data`   | Global score storage. Format: `#<module>.<my_key>` |
| `bs.const`  | Stores constant values. Format: `<value>` |
| `bs.lambda` | Stores values used in callbacks. Format: `$<module>.<my_key>` |

---

## Storages

| Namespaces  | Description |
|-------------|-------------|
| `bs:in`     | Stores input data. Path: `<module>.<feature>.<input_key>` |
| `bs:out`    | Stores output data. Path: `<module>.<feature>` or `<module>.<feature>.<output_key>` |
| `bs:ctx`    | Fast contextual storage. Uses `x`, `y`, `z` for numeric values (i.e., execute store) and `_` for other data |
| `bs:data`   | General-purpose global storage. Path: `<module>.<my_key>` |
| `bs:const`  | Stores constant data. Path: `<module>.<my_key>` |
| `bs:lambda` | Stores data used in callbacks. Path: `<module>.<my_key>` |

---

## Blocks

These commands can be used at load time to create blocks that can be used anywhere. These blocks must be kept in loaded chunks (`-30000000 1600`).

```mcfunction
# Block for manipulating loots
setblock -30000000 0 1606 minecraft:decorated_pot

# Command block for system time (command block output)
setblock -30000000 0 1605 minecraft:repeating_command_block[facing=up]{auto:1b,Command:"help me",TrackOutput:1}
```

---

## Entities

Global entities are summoned with specific UUIDs, ensuring they remain accessible and avoid selector conflicts. They must persist in always-loaded chunks (`-30000000 1600`) at the end of each tick.

```{code-block} mcfunction
:force:
# Marker for position, arithmetic, and various utilities
execute unless entity B5-0-0-0-1 run summon minecraft:marker -30000000 0 1600 {UUID:[I;181,0,0,1],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"]}

# Text display entity for interpreting text or computing transformations
execute unless entity B5-0-0-0-2 run summon minecraft:text_display -30000000 0 1600 {UUID:[I;181,0,0,2],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],view_range:0f,alignment:"center"}

# Item display entity for manipulating loots or computing transformations
execute unless entity B5-0-0-0-3 run summon minecraft:item_display -30000000 0 1600 {UUID:[I;181,0,0,3],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],view_range:0f}
```

Temporary entities are summoned where a feature needs them and killed before it returns, so they never persist beyond the current tick. Each module that needs one gets its own UUID, `B5-0-0-0-C<n>`, so that a feature can call another one without both using the same entity:

| UUID | Int array | Module |
|---|---|---|
| `B5-0-0-0-C0` | `[I;181,0,0,192]` | `bs.hitbox` |
| `B5-0-0-0-C1` | `[I;181,0,0,193]` | `bs.raycast` |

A temporary entity summoned in a chunk whose entities are not loaded yet cannot be selected, but it still takes its UUID. Summon it in a loaded chunk (`execute if loaded`), and kill any leftover from a call cut short by the command limit before summoning it again.

```{code-block} mcfunction
:force:
execute unless loaded ~ ~ ~ run return fail
kill B5-0-0-0-C1
summon minecraft:marker ~ ~ ~ {UUID:[I;181,0,0,193]}
execute as B5-0-0-0-C1 run function bs.raycast:...
```
