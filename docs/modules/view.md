# 👀 View

**`#bs.view:help`**

Run commands based on what an entity is looking at.

```{image} /_imgs/modules/view.png
:align: center
:class: dark_light p-2
```

```{pull-quote}
"Vision is the act of seeing things as they could be, not as they are."

-- Gretchen Rubin
```

---

## Functions

The following functions are available in this module.

```{tip}
The aimed functions and the block placement cast a [ray](raycast.md) from the eyes of the entity, in the direction it looks at. The ray never hits that entity. They give a command `as` or `at` what the entity aims at: the prefix of their name says which.
```

---

### Aimed block

```{feature} bs.view:at_aimed_block
```

*Example: turn the block you aim at into a sponge*

```mcfunction
# Once
function #bs.view:at_aimed_block.in {run:"setblock ~ ~ ~ minecraft:sponge",with:{}}
```

```{admonition} Avoid advancements
:class: important

This function *can* run from the `placed_block` advancement to detect the block a player places, but it may not find the same block as the game: a fast mouse movement within a tick can aim at another one.
```

---

### Aimed entity

:::::{tab-set}
::::{tab-item} As

```{feature} bs.view:as_aimed_entity
```

*Example: make the entity you aim at speak*

```mcfunction
# Once
function #bs.view:as_aimed_entity.in {run:"say I am sorry, are you hitting on me?",with:{}}
```

::::
::::{tab-item} At

```{feature} bs.view:at_aimed_entity
```

*Example: teleport to the entity you aim at, within 32 blocks*

```mcfunction
# Once
function #bs.view:at_aimed_entity.in {run:"tp @s ~ ~ ~",with:{max_distance:32}}
```

::::
:::::

```{admonition} Performance tip
:class: tip

A player-specific predicate can check what entity a player looks at. If only players look, the [looked entity](#looked-entity) functions are faster.
```

---

### Aimed point

```{feature} bs.view:at_aimed_point
```

*Example: show a flame where you aim*

```mcfunction
# Once
function #bs.view:at_aimed_point.in {run:"particle minecraft:flame ~ ~ ~ 0 0 0 0 1 force",with:{}}
```

---

### Block placement

```{feature} bs.view:at_block_placement
```

*Example: place a sponge as if you placed it yourself*

```mcfunction
# Once
function #bs.view:at_block_placement.in {run:"setblock ~ ~ ~ minecraft:sponge",with:{}}
```

---

### Can see

```{feature} bs.view:can_see
```

*Example: check if the nearest other entity can see you*

```mcfunction
# Once
execute at @s as @n[distance=0.1..] if function #bs.view:can_see.in {with:{}} run say You're not hiding very well...
```

*Example: see through glass too, with a provider that gives glass no box*

```mcfunction
# In the function my_pack:opaque
execute if block ~ ~ ~ #minecraft:impermeable run return fail
return run function #bs.hitbox:get_block/collision
```

```mcfunction
# Once
execute at @s as @n[distance=0.1..] if function #bs.view:can_see.in {with:{blocks:"my_pack:opaque"}} run say I see you through the window
```

---

### In view

```{feature} bs.view:in_view
```

*Example: check if the position 0 5 0 is in your field of view*

```mcfunction
# Once
execute positioned 0 5 0 if function #bs.view:in_view.in {angle:90} run say I see it
```

---

### Looked entity

:::::{tab-set}
::::{tab-item} As

```{feature} bs.view:as_looked_entity
```

*Example: make the armor stand you look at glow*

```mcfunction
# Once
tag @e[type=minecraft:armor_stand] add bs.view.is_lookable
function #bs.view:as_looked_entity.in {run:"effect give @s minecraft:glowing 1 0 true"}
```

::::
::::{tab-item} At

```{feature} bs.view:at_looked_entity
```

*Example: show particles on the armor stand you look at*

```mcfunction
# Once
tag @e[type=minecraft:armor_stand] add bs.view.is_lookable
function #bs.view:at_looked_entity.in {run:"particle minecraft:crit ~ ~2 ~ 0 0 0 0 1"}
```

::::
:::::

```{admonition} Technical limitations
:class: important

These functions rely on a player-specific predicate, so only players can look. At most 255 entities can have the `bs.view.is_lookable` tag at the same time.
```

---

```{include} ../_templates/comments.md
```
