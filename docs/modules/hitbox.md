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
    - {nbt}`list` **shape**: A list of cube coordinates (`[[min_x, min_y, min_z, max_x, max_y, max_z]]`).
    - {nbt}`compound` **offset**: Hitbox offset (used for example by flowers).
      - {nbt}`double` **x**: Number describing the X coordinate offset.
      - {nbt}`double` **z**: Number describing the Z coordinate offset.
  :::
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

*Get the hitbox of an armor_stand:*

```mcfunction
execute summon minecraft:armor_stand run function #bs.hitbox:get_entity
data get storage bs:out hitbox
```

```{important}
Static entities, such as paintings and item frames, do not provide height and width information. Instead, they return a shape similar to blocks in `bs:out hitbox`.
```

::::
:::::

> **Credits**: Aksiome

---

### Is Entity Inside

:::::{tab-set}
::::{tab-item} Entity in Block

```{function} #bs.hitbox:is_entity_in_block

Check if the specified entity is within the block at the execution position.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

```{note}
This function checks if the entity's bounding box is inside the block at the current position, not any other blocks the entity might touch.
```

*Check if a summoned cow is inside the fence at your position:*

```mcfunction
setblock ~ ~ ~ minecraft:oak_fence
# move to the edge of the fence, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_block run say I'm in the fence
# since the cow is bigger than the player, you should see the message
```

::::
::::{tab-item} Entity in Blocks

```{function} #bs.hitbox:is_entity_in_blocks

Check if the specified entity is within a block.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Optional settings.
      - {nbt}`string` **ignored_blocks**: Blocks to ignore (default: `#bs.hitbox:intangible`).
  :::

:Outputs:
  **Return**: Success or failure.
```

```{note}
Since an entity's bounding box can extend across multiple blocks, this function checks all blocks the entity might be in contact with.
```

*Check if a summoned cow is inside a block:*

```mcfunction
# move to the edge of a block, then run
execute summon minecraft:cow run function #bs.hitbox:is_entity_in_blocks {with:{}}
# since the cow is bigger than the player, you should get a success
```

::::
:::::

> **Credits**: Aksiome

---

### Is inside

::::{tab-set}
:::{tab-item} Block

```{function} #bs.hitbox:is_in_block

Check if the execution position is inside the hitbox of a block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

*Say "My name is Pavel" if you are inside a block:*

```mcfunction
execute if function #bs.hitbox:is_in_block run say My name is Pavel
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
:::{tab-item} Has offset

**`#bs.hitbox:has_offset`**

Determines if the block's hitbox has an intentional random offset. This is commonly used in blocks that have slightly shifted hitboxes to give a more dynamic visual effect.

:::
:::{tab-item} Intangible

**`#bs.hitbox:intangible`**

Indicates whether the block is intangible, meaning it is typically invisible and lacks interaction collision.

:::
:::{tab-item} Is composite

**`#bs.hitbox:is_composite`**

Checks if the block is made up of multiple smaller hitboxes or shapes, rather than a single unified block.

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
:::{tab-item} Is shaped

**`#bs.hitbox:is_shaped`**

Identifies if the entity has a non-standard hitbox shape, differing from the typical cubic or rectangular hitbox.

:::
:::{tab-item} Is sized

**`#bs.hitbox:is_sized`**

Identifies if the entity has a rectangular hitbox size.

:::
::::

> **Credits**: Aksiome

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
