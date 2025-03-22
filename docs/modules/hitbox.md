# 🎯 Hitbox

**`#bs.hitbox:help`**

Get and check the hitboxes of blocks or entities.

```{epigraph}
"Talent hits a target no one else can hit; Genius hits a target no one else can see."

-- Arthur Schopenhauer
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Get

:::::{tab-set}
::::{tab-item} Block

```{function} #bs.hitbox:get_block

Get the hitbox of a block as a shape, represented by a list of boxes coordinates. Dimensions range from 0 to 16 as for models.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position from which to get the block hitbox.

:Outputs:
  **Storage `bs:out hitbox`**:
  :::{treeview}
  - {nbt}`compound` Block collision box
    - {nbt}`list` **collision_shape**: A list of cube coordinates (`[[min_x, min_y, min_z, max_x, max_y, max_z]]`).
    - {nbt}`list` **interaction_shape**: A list of cube coordinates (`[[min_x, min_y, min_z, max_x, max_y, max_z]]`).
    - {nbt}`compound` **offset**: Hitbox offset (used for example by flowers).
      - {nbt}`double` **x**: Number describing the X coordinate offset.
      - {nbt}`double` **z**: Number describing the Z coordinate offset.
  :::
```

```{admonition} Collision / Interaction Shape
:class: info
- **Collision Shape**: Defines the physical boundaries of a block that entities cannot pass through. It determines where an entity will stop when moving towards the block.
- **Interaction Shape**: Defines the area where the player can interact with or break the block. This includes actions such as right-clicking to open a GUI (e.g., chests, furnaces) or mining the block. Some blocks have an interaction shape but no collision, such as crops or scaffolding.
```

*Get the hitbox of stairs:*

```mcfunction
setblock 0 0 0 minecraft:oak_stairs
execute positioned 0 0 0 run function #bs.hitbox:get_block
data get storage bs:out hitbox
```

::::
::::{tab-item} Entity

```{function} #bs.hitbox:get_entity

Get the width and height of an entity.

:Inputs:
  **Execution `as <entities>`**: Entity to get the hitbox from.

:Outputs:
  **Storage `bs:out hitbox`**:
  :::{treeview}
  - {nbt}`compound` Block collision box
    - {nbt}`double` **height**: Height of the entity.
    - {nbt}`double` **width**: Width of the entity.
    - {nbt}`double` **scale**: Scaling of the hitbox.
  :::
```

```{important}
Static entities, such as paintings and item frames, do not provide height and width information. Instead, they return a shape similar to blocks in `bs:out hitbox.shape`.
```

*Get the hitbox of an armor_stand:*

```mcfunction
execute summon minecraft:armor_stand run function #bs.hitbox:get_entity
data get storage bs:out hitbox
```

::::
:::::

> **Credits**: Aksiome

---

### Is Entity Inside

:::::{tab-set}
::::{tab-item} Block Collision Boxes

```{function} #bs.hitbox:is_entity_in_blocks_collision

Check if the specified entity is within the `collision` hitbox of any block.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

:Outputs:
  **Return**: Success or failure.
```

```{note}
Since an entity's bounding box can extend across multiple blocks, this function checks all blocks the entity might be in contact with.
```

*Check if a summoned cow is inside a block:*

```mcfunction
# move to the edge of a block, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_blocks_collision run say I'm in the fence
# since the cow is bigger than the player, you should get a success
```

::::
::::{tab-item} Block Interaction Boxes

```{function} #bs.hitbox:is_entity_in_blocks_interaction

Check if the specified entity is within the `interaction` hitbox of any block.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

:Outputs:
  **Return**: Success or failure.
```

```{note}
Since an entity's bounding box can extend across multiple blocks, this function checks all blocks the entity might be in contact with.
```

*Check if a summoned cow is inside a block:*

```mcfunction
# move to the edge of a block, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_blocks_collision run say I'm in the fence
# since the cow is bigger than the player, you should get a success
```

::::
::::{tab-item} Block Collision Box

```{function} #bs.hitbox:is_entity_in_block_collision

Check if the specified entity is within the `collision` hitbox of the block at the execution position.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

```{note}
This function checks whether the entity's bounding box intersects with the block at the execution position. It does *not* consider other blocks the entity might be touching.
```

*Check if a summoned cow is inside the fence at your position:*

```mcfunction
setblock ~ ~ ~ minecraft:oak_fence
# move to the edge of the fence, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_block_collision run say I'm in the fence
# since the cow is bigger than the player, you should see the message
```

::::
::::{tab-item} Block Interaction Box

```{function} #bs.hitbox:is_entity_in_block_interaction

Check if the specified entity is within the `interaction` hitbox of the block at the execution position.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

```{note}
This function checks whether the entity's bounding box intersects with the block at the execution position. It does *not* consider other blocks the entity might be touching.
```

*Check if a summoned cow is inside the fence at your position:*

```mcfunction
setblock ~ ~ ~ minecraft:oak_fence
# move to the edge of the fence, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_block_interaction run say I'm in the fence
# since the cow is bigger than the player, you should see the message
```

::::
:::::

> **Credits**: Aksiome

---

### Is inside

::::{tab-set}
:::{tab-item} Block Collision Box

```{function} #bs.hitbox:is_in_block_collision

Check if the execution position is within the `collision` hitbox of a block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

*Say "My name is Pavel" if you are inside a block:*

```mcfunction
execute if function #bs.hitbox:is_in_block_collision run say My name is Pavel
```

:::
:::{tab-item} Block Interaction Box

```{function} #bs.hitbox:is_in_block_interaction

Check if the execution position is within the `interaction` hitbox of a block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

*Say "My name is Pavel" if you are inside a block:*

```mcfunction
execute if function #bs.hitbox:is_in_block_interaction run say My name is Pavel
```

:::
:::{tab-item} Entity

```{function} #bs.hitbox:is_in_entity

Check if the execution position is inside the entity executing the command.

:Inputs:
  **Execution `as <entities>`**: Entity to check.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

*Check if you are inside an entity:*

```mcfunction
execute summon minecraft:cow if function #bs.hitbox:is_in_entity run say Oh no...
```

:::
::::

> **Credits**: Aksiome

---

## 🏷️ Tags

You can find below all tags available in this module.

---

### Blocks

::::{tab-set}
:::{tab-item} Can Pass Through

**`#bs.hitbox:can_pass_through`**

Determine if the block has a collision box.

:::
:::{tab-item} Has Offset

**`#bs.hitbox:has_offset`**

Determine if the block's hitbox has an intentional random offset. This is commonly used in blocks that have slightly shifted hitboxes to give a more dynamic visual effect.

:::
:::{tab-item} Intangible

**`#bs.hitbox:intangible`**

Indicate whether the block is intangible, meaning it is typically invisible and lacks interaction collision.

:::
:::{tab-item} Is Full Cube

**`#bs.hitbox:is_full_cube`**

Check if the block is a full cube of 16\*16\*16.

:::
::::

> **Credits**: Aksiome

---

### Entities

::::{tab-set}
:::{tab-item} Intangible

**`#bs.hitbox:intangible`**

Determines if the entity's hitbox is intangible, meaning it won't interact physically with other blocks or entities.

:::
:::{tab-item} Is Shaped

**`#bs.hitbox:is_shaped`**

Identifies if the entity has a non-standard hitbox shape, differing from the typical cubic or rectangular hitbox.

:::
:::{tab-item} Is Sized

**`#bs.hitbox:is_sized`**

Identifies if the entity has a rectangular hitbox size.

:::
::::

> **Credits**: Aksiome

---

```{include} ../_templates/comments.md
```
