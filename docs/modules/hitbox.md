# 🎯 Hitbox

**`#bs.hitbox:help`**

Work with the hitboxes of blocks and entities.

```{pull-quote}
"Talent hits a target no one else can hit; Genius hits a target no one else can see."

-- Arthur Schopenhauer
```

---

## Functions

The following functions are available in this module.

---

### Get block

:::::{tab-set}
::::{tab-item} Outline

```{feature} bs.hitbox:get_block/outline
```

*Example: get the outline of an open fence gate, which has no collision but can still be targeted*

```mcfunction
# Once
setblock ~ ~ ~ minecraft:oak_fence_gate[open=true]
function #bs.hitbox:get_block/outline

# See the result
data get storage bs.hitbox:get_block out
```

::::
::::{tab-item} Outline with fluid

```{feature} bs.hitbox:get_block/outline_with_fluid
```

*Example: get the outline of a waterlogged fence and the box of its water*

```mcfunction
# Once
setblock ~ ~ ~ minecraft:oak_fence[waterlogged=true]
function #bs.hitbox:get_block/outline_with_fluid

# See the result
data get storage bs.hitbox:get_block out
```

::::
::::{tab-item} Collision

```{feature} bs.hitbox:get_block/collision
```

*Example: get the collision of a set of stairs*

```mcfunction
# Once
setblock ~ ~ ~ minecraft:oak_stairs
function #bs.hitbox:get_block/collision

# See the result
data get storage bs.hitbox:get_block out
```

::::
::::{tab-item} Collision with fluid

```{feature} bs.hitbox:get_block/collision_with_fluid
```

*Example: get the collision of a waterlogged slab and the box of its water*

```mcfunction
# Once
setblock ~ ~ ~ minecraft:oak_slab[waterlogged=true]
function #bs.hitbox:get_block/collision_with_fluid

# See the result
data get storage bs.hitbox:get_block out
```

::::
::::{tab-item} Interaction

```{feature} bs.hitbox:get_block/interaction
```

*Example: get the outline of a cauldron and the box of its inside*

```mcfunction
# Once
setblock ~ ~ ~ minecraft:cauldron
function #bs.hitbox:get_block/interaction

# See the result
data get storage bs.hitbox:get_block out
```

::::
::::{tab-item} Interaction with fluid

```{feature} bs.hitbox:get_block/interaction_with_fluid
```

*Example: get the outline of a waterlogged hopper, the box of its inside and the box of its water*

```mcfunction
# Once
setblock ~ ~ ~ minecraft:hopper[waterlogged=true]
function #bs.hitbox:get_block/interaction_with_fluid

# See the result
data get storage bs.hitbox:get_block out
```

::::
:::::

### Get entity

:::::{tab-set}
::::{tab-item} Living

```{feature} function bs.hitbox:get_entity/living
```

*Example: get the box of the nearest armor stand*

```mcfunction
# Once
execute as @n[type=minecraft:armor_stand] run function #bs.hitbox:get_entity/living

# See the result
data get storage bs.hitbox:get_entity out
```

::::
::::{tab-item} Pushable

```{feature} function bs.hitbox:get_entity/pushable
```

*Example: get the box of the nearest cow*

```mcfunction
# Once
execute as @n[type=minecraft:cow] run function #bs.hitbox:get_entity/pushable

# See the result
data get storage bs.hitbox:get_entity out
```

::::
::::{tab-item} Sized

```{feature} function bs.hitbox:get_entity/sized
```

*Example: get the box of the nearest item*

```mcfunction
# Once
execute as @n[type=minecraft:item] run function #bs.hitbox:get_entity/sized

# See the result
data get storage bs.hitbox:get_entity out
```

::::
::::{tab-item} Solid

```{feature} function bs.hitbox:get_entity/solid
```

*Example: get the box of the nearest boat*

```mcfunction
# Once
execute as @n[type=#minecraft:boat] run function #bs.hitbox:get_entity/solid

# See the result
data get storage bs.hitbox:get_entity out
```

::::
::::{tab-item} Targetable

```{feature} function bs.hitbox:get_entity/targetable
```

*Example: get the box of the nearest item frame*

```mcfunction
# Once
execute as @n[type=minecraft:item_frame] run function #bs.hitbox:get_entity/targetable

# See the result
data get storage bs.hitbox:get_entity out
```

::::
:::::

### Is inside

:::::{tab-set}
::::{tab-item} Block

```{feature} bs.hitbox:is_inside/block
```

*Example: check if your eyes are inside the collision of a block*

```mcfunction
# Once
data modify storage bs.hitbox:is_inside/block in set value {blocks:"#bs.hitbox:get_block/collision"}
execute anchored eyes positioned ^ ^ ^ if function #bs.hitbox:is_inside/block run say I can't see
```

::::
::::{tab-item} Entity

```{feature} bs.hitbox:is_inside/entity
```

*Example: check if your position is inside the nearest cow*

```mcfunction
# Once
data modify storage bs.hitbox:is_inside/entity in set value {entities:"#bs.hitbox:get_entity/sized"}
execute as @n[type=minecraft:cow] if function #bs.hitbox:is_inside/entity run say Oh no...
```

::::
:::::

### Overlaps

:::::{tab-set}
::::{tab-item} Block

````{feature} bs.hitbox:overlaps/block
```{admonition} Touching is not overlapping
:class: note

An entity that stands on a block, or leans against it, does not overlap it.
```
````

*Example: check if the nearest cow overlaps the collision of the block at your position*

```mcfunction
# Once
data modify storage bs.hitbox:overlaps/block in set value {blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized"}
execute as @n[type=minecraft:cow] if function #bs.hitbox:overlaps/block run say I'm in your block
```

::::
::::{tab-item} Blocks

````{feature} bs.hitbox:overlaps/blocks
```{admonition} Touching is not overlapping
:class: note

An entity that stands on a block, or leans against it, does not overlap it.
```
````

*Example: check if the nearest cow overlaps the collision of a block*

```mcfunction
# Once
data modify storage bs.hitbox:overlaps/blocks in set value {blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized"}
execute as @n[type=minecraft:cow] if function #bs.hitbox:overlaps/blocks run say I'm stuck
```

::::
:::::

---

## Predicates

The following predicates are available in this module.

---

### Get entity

Each predicate tells if the [entity provider](#entity-providers) of the same name may give a box for an entity, without getting the box.

:::::{tab-set}
::::{tab-item} Living

```{feature} predicate bs.hitbox:get_entity/living
```

::::
::::{tab-item} Pushable

```{feature} predicate bs.hitbox:get_entity/pushable
```

::::
::::{tab-item} Sized

```{feature} predicate bs.hitbox:get_entity/sized
```

::::
::::{tab-item} Solid

```{feature} predicate bs.hitbox:get_entity/solid
```

::::
::::{tab-item} Targetable

```{feature} predicate bs.hitbox:get_entity/targetable
```

::::
:::::

---

## Block tags

The following block tags are available in this module.

---

### Fluid

:::::{tab-set}
::::{tab-item} Has fluid

```{feature} bs.hitbox:has_fluid
```

::::
::::{tab-item} Is liquid

```{feature} bs.hitbox:is_liquid
```

::::
::::{tab-item} Is waterloggable

```{feature} bs.hitbox:is_waterloggable
```

::::
:::::

### Offset

:::::{tab-set}
::::{tab-item} Has shape offset

```{feature} bs.hitbox:has_shape_offset
```

::::
::::{tab-item} Has visual offset

```{feature} bs.hitbox:has_visual_offset
```

::::
:::::

### Shape

:::::{tab-set}
::::{tab-item} Has no collision

```{feature} bs.hitbox:has_no_collision
```

::::
::::{tab-item} Has no outline

```{feature} bs.hitbox:has_no_outline
```

::::
::::{tab-item} Is full cube collision

```{feature} bs.hitbox:is_full_cube_collision
```

::::
::::{tab-item} Is full cube outline

```{feature} bs.hitbox:is_full_cube_outline
```

::::
:::::

---

(block-providers)=
## Block providers

A block provider gives the boxes of a block. Some functions take one as an input.

---

A block provider is a function, such as `#bs.hitbox:get_block/collision`. It returns `0` when the block at the current position has no box. Otherwise it returns `1`, and `bs.hitbox:get_block out` holds one of two values:

:::{list-table}
*   - **Flags**
    - The block is a full cube, and the storage holds its flags as a number from `1` to `15`
*   - **Boxes**
    - The storage holds a list of `[x1,y1,z1,x2,y2,z2,flag]`, with at least one box
:::

Coordinates are measured from the corner of the block, where `1` is the length of one block: a full block goes from `0` to `1` on each axis. The random offset of blocks such as flowers and bamboo is already applied.

```{admonition} Flags
:class: info

A flag is a number that tells what a box is. Each provider chooses what its flags mean, and says so in its description. Flags are bits, so a full cube can combine several.

Bookshelf providers use `1` for the block itself, `2` for its fluid and `4` for an interaction box, such as the inside of a cauldron. Your own providers can use any convention.
```

```{admonition} Limit of 24 boxes
:class: warning

Only the first 24 boxes of a block are read. Bookshelf providers stay well under this limit.
```

Bookshelf has the following block providers:

:::{list-table}
*   - [`#get_block/outline`](#get-block-outline)
    - The boxes where a block can be targeted
*   - [`#get_block/outline_with_fluid`](#get-block-outline-with-fluid)
    - The outline, and the fluid of the block
*   - [`#get_block/collision`](#get-block-collision)
    - The boxes entities can't pass through
*   - [`#get_block/collision_with_fluid`](#get-block-collision-with-fluid)
    - The collision, and the fluid of the block
*   - [`#get_block/interaction`](#get-block-interaction)
    - The outline as the game uses it to place blocks
*   - [`#get_block/interaction_with_fluid`](#get-block-interaction-with-fluid)
    - The interaction, and the fluid of the block
:::

*Example: a provider that ignores glass and gives barriers a smaller box with a custom flag*

```mcfunction
# In the function my_pack:blocks
execute if block ~ ~ ~ minecraft:glass run return 0
execute unless block ~ ~ ~ minecraft:barrier run return run function #bs.hitbox:get_block/collision
data modify storage bs.hitbox:get_block out set value [[.25,.25,.25,.75,.75,.75,8.]]
return 1
```

```mcfunction
# Use it
data modify storage bs.hitbox:is_inside/block in set value {blocks:"my_pack:blocks"}
execute if function #bs.hitbox:is_inside/block run say I'm in a block
```

---

(entity-providers)=
## Entity providers

An entity provider gives the boxes of an entity. Some functions take one as an input.

---

An entity provider is a function, such as `#bs.hitbox:get_entity/sized`. It returns `0` when the executing entity has no box. Otherwise it returns `1`, and `bs.hitbox:get_entity out` holds a list of `[x1,y1,z1,x2,y2,z2]`, with at least one box.

Coordinates are measured from the position of the entity, where `1` is the length of one block, with its scale already applied. Bookshelf providers give one box. Your own providers may give several.

```{admonition} Limit of 8 boxes
:class: warning

Only the first 8 boxes of an entity are read. Bookshelf providers stay well under this limit.
```

Bookshelf has the following entity providers:

:::{list-table}
*   - [`#get_entity/sized`](#get-entity-sized-tags-function)
    - Any entity that has a box
*   - [`#get_entity/living`](#get-entity-living-tags-function)
    - Entities that have health, such as mobs, players and armor stands
*   - [`#get_entity/pushable`](#get-entity-pushable-tags-function)
    - Entities others bump into or push, such as boats and mobs
*   - [`#get_entity/solid`](#get-entity-solid-tags-function)
    - Entities others can't pass through, such as boats and shulkers
*   - [`#get_entity/targetable`](#get-entity-targetable-tags-function)
    - Entities a player can target, such as mobs and item frames
:::

Each of them comes with a predicate of the same ID, which passes for the entities it may give a box for. A predicate is how entities are filtered: use the one of a provider, or your own to narrow them further.

*Example: a provider that gives block displays a box of one block*

```mcfunction
# In the function my_pack:entities
execute unless entity @s[type=minecraft:block_display] run return 0
data modify storage bs.hitbox:get_entity out set value [[0f,0f,0f,1f,1f,1f]]
return 1
```

```mcfunction
# Use it
data modify storage bs.hitbox:is_inside/entity in set value {entities:"my_pack:entities"}
execute as @n[type=minecraft:block_display] if function #bs.hitbox:is_inside/entity run say You are inside me
```

*Example: a predicate that only keeps the entities you tagged*

```json
{
  "type": "entity_properties",
  "entity": "this",
  "predicate": {
    "entity_tags": {"all_of": ["my_pack.hitbox"]}
  }
}
```

```mcfunction
# Use it, as the predicate my_pack:tagged, with a Bookshelf provider
data modify storage bs.hitbox:is_inside/entity in set value {entities:"#bs.hitbox:get_entity/sized"}
execute as @e[predicate=my_pack:tagged] if function #bs.hitbox:is_inside/entity run say You are inside me
```

---

```{include} ../_templates/comments.md
```
