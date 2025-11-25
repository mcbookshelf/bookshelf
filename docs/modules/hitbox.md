# 🎯 Hitbox

**`#bs.hitbox:help`**

Get and check the hitboxes of blocks or entities.

```{pull-quote}
"Talent hits a target no one else can hit; Genius hits a target no one else can see."

-- Arthur Schopenhauer
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Bake Entity

```{function} #bs.hitbox:bake_entity

Bake an [entity's hitbox](#entity-types) to improve performance when its size never changes. If the entity has passengers, they are also baked, and the base entity's hitbox is expanded to include the full bounding box of the entire stack.

:Inputs:
  **Execution `as <entities>`**: The entity or entities whose hitbox should be baked.

:Outputs:
  **State**: The entity's hitbox is saved in a baked state for later use.
```

```{warning}
Only use baked hitboxes when you are sure the entity's size will not change, for example: no growth (babies), no scaling, no new passengers, and no equipment that could affect size.

If the hitbox changes after baking, **it may lead to incorrect collisions or broken logic**.
```

```{dropdown} What is a Bounding Box?
:color: info
:icon: question

A bounding box is a simple rectangular box that surrounds an object—or part of it—to help the game figure out where it is and what it touches. For example, a set of stairs in Minecraft uses two bounding boxes: one for the lower step and one for the upper step.
```

```{dropdown} What is a Baked Hitbox?
:color: info
:icon: question

Baking captures a snapshot of the entity's hitbox at a specific moment. It does not update after that. If the entity has passengers, the baked result includes a bounding box that encapsulates both the base entity and all passengers.

See [Hitbox Types](#types) for full details on block and entity hitboxes.
```

> **Credits**: Aksiome

---

### Get Block

:::::{tab-set}
::::{tab-item} Block Shape

```{function} #bs.hitbox:get_block_shape

Get the `default` shape of a block, represented by a list of box coordinates. This shape defines the area where the player can interact with or aim at the block. Coordinates range from `0` to `16` within a block space, as in block models.

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

*Example: Get the shape of an open fence gate (can be targeted, even though you can walk through it):*

```mcfunction
setblock 0 0 0 minecraft:oak_fence_gate[open=true]
execute positioned 0 0 0 run function #bs.hitbox:get_block_shape
data get storage bs:out hitbox
```

::::
::::{tab-item} Block Collision Shape

```{function} #bs.hitbox:get_block_collision

Get the `collision` shape of a block, represented by a list of box coordinates. This shape defines the solid boundaries of the block that entities cannot pass through. Coordinates range from `0` to `16` within a block space, as in block models.

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

*Example: Get the collision of an open fence gate (no collision, entities can pass through):*

```mcfunction
setblock 0 0 0 minecraft:oak_fence_gate[open=true]
execute positioned 0 0 0 run function #bs.hitbox:get_block_collision
data get storage bs:out hitbox
```

::::
::::{tab-item} Block

```{deprecated} v3.2.0
This feature is deprecated and will be removed in v4.0.0.

Please use `#bs.hitbox:get_block_shape` or `#bs.hitbox:get_block_collision` instead.
```

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

```{dropdown} Collision or Interaction Shape?
:color: info
:icon: question

- **Collision Shape**: Defines the physical boundaries of a block that entities cannot pass through. It determines where an entity will stop when moving towards the block.
- **Interaction Shape**: Defines the area where the player can interact with or break the block. This includes actions such as right-clicking to open a GUI (e.g., chests, furnaces) or mining the block. Some blocks have an interaction shape but no collision, such as crops or scaffolding.

See [Hitbox Types](#types) for full details on block and entity hitboxes.
```

*Example: Get the hitbox of stairs:*

```mcfunction
setblock 0 0 0 minecraft:oak_stairs
execute positioned 0 0 0 run function #bs.hitbox:get_block
data get storage bs:out hitbox
```

::::
:::::

> **Credits**: Aksiome

---

### Get Entity

```{function} #bs.hitbox:get_entity

Get the width and height of an entity.

:Inputs:
  **Execution `as <entities>`**: Entity to get the hitbox from.

:Outputs:
  **Storage `bs:out hitbox`**:
  :::{treeview}
  - {nbt}`compound` Entity hitbox data
    - {nbt}`double` **width**: Width of the entity (X axis).
    - {nbt}`double` **height**: Height of the entity (Y axis).
    - {nbt}`double` **depth**: Depth of the entity (Z axis).
    - {nbt}`double` **scale**: Scaling of the hitbox.
  :::
```

```{note}
For most entities without a custom hitbox, `depth` is equal to `width`.
However, static entities like paintings and item frames use shaped hitboxes and may return different dimensions.
Their full shape is also available in `bs:out hitbox.shape`, in a format similar to block shapes.
```

*Example: Get the hitbox of an armor stand:*

```mcfunction
execute summon minecraft:armor_stand run function #bs.hitbox:get_entity
data get storage bs:out hitbox
```

> **Credits**: Aksiome

---

### Is Entity Inside

:::::{tab-set}
::::{tab-item} Any Block Shape

```{function} #bs.hitbox:is_entity_in_blocks_shape

Check if the specified entity is within the `default` shape of any block.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

:Outputs:
  **Return**: Success or failure.
```

```{note}
Since an entity's bounding box can extend across multiple blocks, this function checks all blocks the entity might be in contact with.
```

*Example: Check if a summoned cow is inside a block:*

```mcfunction
# Move to the edge of a block, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_blocks_shape run say I'm in the fence
# Since the cow is bigger than the player, you should get a success
```

::::
::::{tab-item} Any Block Collision Shape

```{function} #bs.hitbox:is_entity_in_blocks_collision

Check if the specified entity is within the `collision` shape of any block.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

:Outputs:
  **Return**: Success or failure.
```

```{note}
Since an entity's bounding box can extend across multiple blocks, this function checks all blocks the entity might be in contact with.
```

*Example: Check if a summoned cow is inside a block:*

```mcfunction
# Move to the edge of a block, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_blocks_collision run say I'm in the fence
# Since the cow is bigger than the player, you should get a success
```

::::
::::{tab-item} Block Shape

```{function} #bs.hitbox:is_entity_in_block_shape

Check if the specified entity is within the `default` shape of the block at the execution position.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

```{note}
This function checks whether the entity's bounding box intersects with the block at the execution position. It does *not* consider other blocks the entity might be touching.
```

*Example: Check if a summoned cow is inside the fence at your position:*

```mcfunction
setblock ~ ~ ~ minecraft:oak_fence
# Move to the edge of the fence, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_block_shape run say I'm in the fence
# Since the cow is bigger than the player, you should see the message
```

::::
::::{tab-item} Block Collision Shape

```{function} #bs.hitbox:is_entity_in_block_collision

Check if the specified entity is within the `collision` shape of the block at the execution position.

:Inputs:
  **Execution `as <entity>`**: Entity to check.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

```{note}
This function checks whether the entity's bounding box intersects with the block at the execution position. It does *not* consider other blocks the entity might be touching.
```

*Example: Check if a summoned cow is inside the fence at your position:*

```mcfunction
setblock ~ ~ ~ minecraft:oak_fence
# Move to the edge of the fence, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_block_collision run say I'm in the fence
# Since the cow is bigger than the player, you should see the message
```

::::
::::{tab-item} Block Interaction Boxes

```{deprecated} v3.2.0
This feature is deprecated and will be removed in v4.0.0.

Please use `#bs.hitbox:is_entity_in_blocks_shape` instead.
```

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

*Example: Check if a summoned cow is inside a block:*

```mcfunction
# Move to the edge of a block, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_blocks_interaction run say I'm in the fence
# Since the cow is bigger than the player, you should get a success
```

::::
::::{tab-item} Block Interaction Box
```{deprecated} v3.2.0
This feature is deprecated and will be removed in v4.0.0.

Please use `#bs.hitbox:is_entity_in_block_shape` instead.
```

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

*Example: Check if a summoned cow is inside the fence at your position:*

```mcfunction
setblock ~ ~ ~ minecraft:oak_fence
# Move to the edge of the fence, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_block_interaction run say I'm in the fence
# Since the cow is bigger than the player, you should see the message
```

::::
:::::

> **Credits**: Aksiome

---

### Is Inside

::::{tab-set}
:::{tab-item} Block Shape

```{function} #bs.hitbox:is_in_block_shape

Check if the execution position is within the `default` shape of a block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

*Example: Say "My name is Pavel" if you are inside a block:*

```mcfunction
execute if function #bs.hitbox:is_in_block_shape run say My name is Pavel
```

:::
:::{tab-item} Block Collision Shape

```{function} #bs.hitbox:is_in_block_collision

Check if the execution position is within the `collision` shape of a block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

*Example: Say "My name is Pavel" if you are inside a block:*

```mcfunction
execute if function #bs.hitbox:is_in_block_collision run say My name is Pavel
```

:::
:::{tab-item} Block Interaction Box

```{deprecated} v3.2.0
This feature is deprecated and will be removed in v4.0.0.

Please use `#bs.hitbox:is_in_block_shape` instead.
```

```{function} #bs.hitbox:is_in_block_interaction

Check if the execution position is within the `interaction` hitbox of a block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to check.

:Outputs:
  **Return**: Success or failure.
```

*Example: Say "My name is Pavel" if you are inside a block:*

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

*Example: Check if you are inside an entity:*

```mcfunction
execute summon minecraft:cow if function #bs.hitbox:is_in_entity run say Oh no...
```

:::
::::

> **Credits**: Aksiome

---

### Reset Entity

```{function} #bs.hitbox:reset_entity

Reset an [entity's hitbox](#entity-types) to its default **dynamic** form, removing any previously applied **baked** or **custom** hitbox.

:Inputs:
  **Execution `as <entities>`**: The entity or entities whose hitbox should be reset.

:Outputs:
  **State**: The entity's hitbox is now dynamic again and will automatically update with scaling, growth, or other changes.
```

> **Credits**: Aksiome

---

### Set Entity

```{function} #bs.hitbox:set_entity

Define a [custom hitbox](#entity-types) for an entity with full control over its dimensions. This allows setting a hitbox not constrained by Minecraft's built-in width/height system and can be used on entities that normally have no hitbox.

:Inputs:
  **Execution `as <entities>`**: The entity or entities whose hitbox should be set with custom dimensions.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Hitbox data.
      - {nbt}`double` **width**: The total horizontal size along the X axis.
      - {nbt}`double` **height**: The total vertical size along the Y axis.
      - {nbt}`double` **depth**: The total size along the Z axis. Defaults to the same value as **width** if not provided.
      - {nbt}`bool` **centered**: Whether the hitbox should be vertically centered on the Y axis. Defaults to `false`, meaning the hitbox starts at the entity's feet (like in vanilla).
  :::
:Outputs:
  **State**: The entity now has a custom axis-aligned bounding box (AABB) hitbox.
```

```{warning}
Custom hitboxes come with a **small performance cost**. Use them when you need precise control over shape and position, but avoid using too many of them in the same area.
```

```{dropdown} What is a Bounding Box?
:color: info
:icon: question

A bounding box is a simple rectangular box that surrounds an object—or part of it—to help the game figure out where it is and what it touches. For example, a set of stairs in Minecraft uses two bounding boxes: one for the lower step and one for the upper step.
```

```{dropdown} What is a Custom Hitbox?
:color: info
:icon: question

A custom hitbox lets you override Minecraft's default hitbox system and define your own shape using width, height, and depth. Unlike dynamic or baked hitboxes, custom hitboxes:

- Can be **freely shaped**, including along the Z axis (depth).
- Are not tied to Minecraft's internal collision model.
- Work on entities **without a native hitbox**, such as display entities.

See [Hitbox Types](#types) for full details on block and entity hitboxes.
```

> **Credits**: Aksiome

---

## 🏷️ Tags

You can find below below all tags available in this module.

---

### Blocks

:::::{tab-set}
::::{tab-item} Can Pass Through

**`#bs.hitbox:can_pass_through`**

Determine if the block has a collision box.

::::
:::: {tab-item} Has Shape Offset

**`#bs.hitbox:has_shape_offset`**

Determine if the block has a physical random offset.

::::
:::: {tab-item} Has Visual Offset

**`#bs.hitbox:has_visual_offset`**

Determine if the block has a purely visual random offset.

::::
:::{tab-item} Has Offset

```{deprecated} v3.2.0
This feature is deprecated and will be removed in v4.0.0.

Please use `#bs.hitbox:has_shape_offset` instead.
```

**`#bs.hitbox:has_offset`**

Determine if the block's hitbox has an intentional random offset. This is commonly used in blocks that have slightly shifted hitboxes to give a more dynamic visual effect.

:::
::::{tab-item} Intangible

**`#bs.hitbox:intangible`**

Indicate whether the block is intangible, meaning it is typically invisible and lacks interaction collision.

::::
::::{tab-item} Is Full Cube

**`#bs.hitbox:is_full_cube`**

Check if the block is a full cube of 16×16×16.

::::
:::::

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

(types)=
## 🎓 Hitbox Types

Bookshelf provides multiple hitbox types, each suited to different use cases. Understanding the differences helps you choose the right one.

---

(block-types)=
### Blocks

::::{tab-set}

:::{tab-item} 🖱 Default

The `default` shape defines the area where players can interact with or break the block:

- Specifies the zone where right-clicks, mining, or other interactions register.
- Can differ from the collision shape, for example, fence gates keep the same default shape whether open or closed.

➔ Returned by [#bs.hitbox:get_block_shape](#get-block)

:::
:::{tab-item} 🧊 Collision

The `collision` shape defines the physical boundaries of a block that entities cannot pass through. It determines where an entity will stop when moving towards the block:

- Matches the block's solid parts and prevents entities from moving through.
- Can change dynamically depending on block state (e.g., a fence gate's collision shape differs when open vs closed).

➔ Returned by [#bs.hitbox:get_block_collision](#get-block)

:::
::::

---

(entity-types)=
### Entities

::::{tab-set}
:::{tab-item} 🔄 Dynamic

This is the native Minecraft hitbox, which updates automatically:

- Adjusts in real time with entity changes like scaling, baby growth, equipment, or new passengers.
- No setup required, this is the default behavior.
- Use when the entity's shape is expected to change.

➔ Restored using [#bs.hitbox:reset_entity](#reset-entity)

:::
:::{tab-item} ❄️ Baked

A snapshot of the entity's hitbox at a specific moment:

- Improves performance when the entity's size will never change.
- Includes the base entity and all passengers in one combined box. When baking a pile of passengers, the base entity bakes all passengers and sets its hitbox to encompass the entire stack.
- Does not update dynamically, collisions may break if the entity changes later.

➔ Set using [#bs.hitbox:bake_entity](#bake-entity)

:::
:::{tab-item} 🛠️ Custom

A fully user-defined hitbox:

- Set exact `width`, `height`, and optional `depth`.
- Works on entities with no native hitbox (e.g. display entities).
- Independent from Minecraft's internal hitbox system.
- Only applies to the base entity. When used with modules that process entity stacks, only the base entity's hitbox is considered, passengers are ignored.
- Slight performance cost, avoid overuse in the same area.

➔ Set using [#bs.hitbox:set_entity](#set-entity)

:::
::::

---

(providers)=
## 🔌 Hitbox Providers

A hitbox provider is a callback that returns a block's shape for consumers such as [`bs.raycast`](raycast.md) or [`bs.move`](move.md).

A provider can return one of two forms:

1. **A single flag** (e.g., `return 1`), telling the consumer to treat the block as a full 16×16×16 cube.
2. **An array of bounding boxes**, stored in `bs:lambda hitbox`:
   ```mcfunction
   {shape:[[min_x, min_y, min_z, max_x, max_y, max_z, flag], ...]}
   ```
   Each bounding box uses coordinates from 0 to 16, and may include a flag (defaults to `1` if omitted).

```{dropdown} What is a Bounding Box?
:color: info
:icon: question

A bounding box is a simple rectangular box that surrounds an object—or part of it—to help the game figure out where it is and what it touches. For example, a set of stairs in Minecraft uses two bounding boxes: one for the lower step and one for the upper step.
```

```{admonition} Flags
:class: info
Flags do not have inherent meaning. They are numeric labels used by providers and consumers to classify bounding boxes.
You may use any of the following flags: `1`, `2`, `4`, or `8`.

For example the Bookshelf built-in providers use `1` for solid and `2` for fluids.
```

---

### Available Providers

All built-in providers include a fluid variant, where `1` represents the solid part and `2` represents the fluid part.

::::{tab-set}

:::{tab-item} 🖱 Default
These providers return the block's **default** shape as defined in [block types](#block-types).
- `#bs.hitbox:callback/get_block_shape`  
- `#bs.hitbox:callback/get_block_shape_with_fluid`  
:::

:::{tab-item} 🧊 Collision
These providers return the block's **collision** shape as defined in [block types](#block-types).
- `#bs.hitbox:callback/get_block_collision`  
- `#bs.hitbox:callback/get_block_collision_with_fluid`  
:::

:::{tab-item} 🏗 Placement
Returns the block's default shape and adds a placement-only bounding box (flag `4`) to replicate vanilla block-placement behavior for blocks such as cauldrons, composters, hoppers, and scaffolding.

- `#bs.hitbox:callback/get_block_placement`  
- `#bs.hitbox:callback/get_block_placement_with_fluid`  
:::
::::

---

### Custom Providers

A common pattern for custom providers is either to directly return a custom shape or to:

1. Copy a built-in shape.
2. Modify it.
3. Return it.

*Example: Defining a custom shape with a custom flag:*

```mcfunction
# Custom shape for <my_custom_block>. You can add multiple bounding boxes, each with its own flag, if your block has a complex shape
execute if block ~ ~ ~ <my_custom_block> run return run data modify storage bs:lambda hitbox set value {shape:[[2,2,2,14,14,14,<flag>]]}

# If the block is a full cube, return 1
execute if block ~ ~ ~ #bs.hitbox:is_full_cube run return 1
# Get the shape (step 1)
function #bs.hitbox:get_block_shape
# Copy and return the shape (step 3)
data modify storage bs:lambda hitbox set from storage bs:out hitbox
```

---

```{include} ../_templates/comments.md
```
