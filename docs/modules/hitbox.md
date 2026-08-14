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

### Bake entity

```{function} #bs.hitbox:bake_entity

Bake an [entity's hitbox](#entity-types) to improve performance when its size never changes. If the entity has passengers, they are also baked, and the base entity's hitbox is expanded to include the full bounding box of the entire stack.

:Inputs:
  **Execution `as <entities>`**: entities whose hitbox should be baked

:Outputs:
  **State**: the entity's hitbox is saved as a baked hitbox for later use
```

```{warning}
Only use baked hitboxes when you are sure the entity's size will not change, such as when it cannot grow, scale, gain passengers, or equip items that affect its size.

If the hitbox changes after baking, **it may lead to incorrect collisions or broken logic**.
```

```{dropdown} What is a bounding box?
:color: info
:icon: question

A bounding box is a simple rectangular box that surrounds an object, or part of it, to help the game figure out where it is and what it touches. For example, a set of stairs in Minecraft uses two bounding boxes: one for the lower step and one for the upper step.
```

```{dropdown} What is a baked hitbox?
:color: info
:icon: question

Baking captures a snapshot of the entity's hitbox at a specific moment. It does not update after that. If the entity has passengers, the baked result includes a bounding box that encapsulates both the base entity and all passengers.

See [Hitbox types](#hitbox-types) for full details on block and entity hitboxes.
```

> **Credits**: Aksiome

---

### Get block

:::::{tab-set}
::::{tab-item} Block shape

```{function} #bs.hitbox:get_block_shape

Get the `default` shape of a block, represented by a list of box coordinates. This shape defines the area where the player can target or interact with the block. Coordinates range from `0` to `16` within a block space, as in block models.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: position from which to get the block hitbox

:Outputs:
  **Storage `bs:out hitbox`**:
  :::{treeview}
  - {nbt}`compound` block hitbox
    - {nbt}`list` **shape**: list of cube coordinates (`[[min_x, min_y, min_z, max_x, max_y, max_z]]`)
    - {nbt}`compound` **offset**: hitbox offset (used by flowers, for example)
      - {nbt}`double` **x**: number describing the X coordinate offset
      - {nbt}`double` **z**: number describing the Z coordinate offset
  :::
```

*Example: get the shape of an open fence gate (can be targeted, even though you can walk through it)*

```mcfunction
setblock 0 0 0 minecraft:oak_fence_gate[open=true]
execute positioned 0 0 0 run function #bs.hitbox:get_block_shape
data get storage bs:out hitbox
```

::::
::::{tab-item} Block collision shape

```{function} #bs.hitbox:get_block_collision

Get the `collision` shape of a block, represented by a list of box coordinates. This shape defines the solid boundaries of the block that entities cannot pass through. Coordinates range from `0` to `16` within a block space, as in block models.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: position from which to get the block hitbox

:Outputs:
  **Storage `bs:out hitbox`**:
  :::{treeview}
  - {nbt}`compound` block hitbox
    - {nbt}`list` **shape**: list of cube coordinates (`[[min_x, min_y, min_z, max_x, max_y, max_z]]`)
    - {nbt}`compound` **offset**: hitbox offset (used by flowers, for example)
      - {nbt}`double` **x**: number describing the X coordinate offset
      - {nbt}`double` **z**: number describing the Z coordinate offset
  :::
```

*Example: get the collision of an open fence gate (no collision, entities can pass through)*

```mcfunction
setblock 0 0 0 minecraft:oak_fence_gate[open=true]
execute positioned 0 0 0 run function #bs.hitbox:get_block_collision
data get storage bs:out hitbox
```

::::
:::::

> **Credits**: Aksiome

---

### Get entity

```{function} #bs.hitbox:get_entity

Get the width and height of an entity.

:Inputs:
  **Execution `as <entities>`**: entity to get the hitbox from

:Outputs:
  **Storage `bs:out hitbox`**:
  :::{treeview}
  - {nbt}`compound` entity hitbox
    - {nbt}`double` **width**: width of the entity (X axis)
    - {nbt}`double` **height**: height of the entity (Y axis)
    - {nbt}`double` **depth**: depth of the entity (Z axis)
    - {nbt}`double` **scale**: scaling of the hitbox
  :::
```

```{note}
For most entities without a custom hitbox, `depth` is equal to `width`.
However, some entities like paintings and item frames return more complex dimensions.
```

*Example: get the hitbox of an armor stand*

```mcfunction
execute summon minecraft:armor_stand run function #bs.hitbox:get_entity
data get storage bs:out hitbox
```

> **Credits**: Aksiome

---

### Is entity inside

:::::{tab-set}
::::{tab-item} Any block shape

```{function} #bs.hitbox:is_entity_in_blocks_shape

Check if the specified entity is within the `default` shape of any block.

:Inputs:
  **Execution `as <entity>`**: entity to check

:Outputs:
  **Return**: success or failure
```

```{note}
Since an entity's bounding box can extend across multiple blocks, this function checks all blocks the entity might be in contact with.
```

*Example: check if a summoned cow is inside a block*

```mcfunction
# Move to the edge of a block, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_blocks_shape run say I'm in the fence
# Since the cow is bigger than the player, you should get a success
```

::::
::::{tab-item} Any block collision shape

```{function} #bs.hitbox:is_entity_in_blocks_collision

Check if the specified entity is within the `collision` shape of any block.

:Inputs:
  **Execution `as <entity>`**: entity to check

:Outputs:
  **Return**: success or failure
```

```{note}
Since an entity's bounding box can extend across multiple blocks, this function checks all blocks the entity might be in contact with.
```

*Example: check if a summoned cow is inside a block*

```mcfunction
# Move to the edge of a block, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_blocks_collision run say I'm in the fence
# Since the cow is bigger than the player, you should get a success
```

::::
::::{tab-item} Block shape

```{function} #bs.hitbox:is_entity_in_block_shape

Check if the specified entity is within the `default` shape of the block at the execution position.

:Inputs:
  **Execution `as <entity>`**: entity to check

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: position to check

:Outputs:
  **Return**: success or failure
```

```{note}
This function checks whether the entity's bounding box intersects with the block at the execution position. It does *not* consider other blocks the entity might be touching.
```

*Example: check if a summoned cow is inside the fence at your position*

```mcfunction
setblock ~ ~ ~ minecraft:oak_fence
# Move to the edge of the fence, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_block_shape run say I'm in the fence
# Since the cow is bigger than the player, you should see the message
```

::::
::::{tab-item} Block collision shape

```{function} #bs.hitbox:is_entity_in_block_collision

Check if the specified entity is within the `collision` shape of the block at the execution position.

:Inputs:
  **Execution `as <entity>`**: entity to check

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: position to check

:Outputs:
  **Return**: success or failure
```

```{note}
This function checks whether the entity's bounding box intersects with the block at the execution position. It does *not* consider other blocks the entity might be touching.
```

*Example: check if a summoned cow is inside the fence at your position*

```mcfunction
setblock ~ ~ ~ minecraft:oak_fence
# Move to the edge of the fence, then run
execute summon minecraft:cow if function #bs.hitbox:is_entity_in_block_collision run say I'm in the fence
# Since the cow is bigger than the player, you should see the message
```

::::
:::::

> **Credits**: Aksiome

---

### Is inside

::::{tab-set}
:::{tab-item} Block shape

```{function} #bs.hitbox:is_in_block_shape

Check if the execution position is within the `default` shape of a block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: position to check

:Outputs:
  **Return**: success or failure
```

*Example: say "My name is Pavel" if you are inside a block*

```mcfunction
execute if function #bs.hitbox:is_in_block_shape run say My name is Pavel
```

:::
:::{tab-item} Block collision shape

```{function} #bs.hitbox:is_in_block_collision

Check if the execution position is within the `collision` shape of a block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: position to check

:Outputs:
  **Return**: success or failure
```

*Example: say "My name is Pavel" if you are inside a block*

```mcfunction
execute if function #bs.hitbox:is_in_block_collision run say My name is Pavel
```

:::
:::{tab-item} Entity

```{function} #bs.hitbox:is_in_entity

Check if the execution position is within the entity executing the command.

:Inputs:
  **Execution `as <entities>`**: entity to check

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: position to check

:Outputs:
  **Return**: success or failure
```

*Example: check if you are inside an entity*

```mcfunction
execute summon minecraft:cow if function #bs.hitbox:is_in_entity run say Oh no...
```

:::
::::

> **Credits**: Aksiome

---

### Reset entity

```{function} #bs.hitbox:reset_entity

Reset an [entity's hitbox](#entity-types) to its **dynamic** form, removing any previously applied **baked** or **custom** hitbox.

:Inputs:
  **Execution `as <entities>`**: entities whose hitbox should be reset

:Outputs:
  **State**: the entity's hitbox is now dynamic again and will automatically update with scaling, growth, or other changes
```

> **Credits**: Aksiome

---

### Set entity

```{function} #bs.hitbox:set_entity {with:{}}

Define a [custom hitbox](#entity-types) for an entity with full control over its dimensions. This allows setting a hitbox not constrained by Minecraft's built-in width/height system and can be used on entities that normally have no hitbox.

:Inputs:
  **Execution `as <entities>`**: entities whose hitbox should be set to custom dimensions

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`compound` **with**:
      - {nbt}`double` **width**: total horizontal size along the X axis
      - {nbt}`double` **height**: total vertical size along the Y axis
      - {nbt}`double` **depth**: total size along the Z axis. Defaults to the same value as **width** if not provided
      - {nbt}`bool` **centered**: whether the hitbox should be vertically centered on the Y axis. Defaults to `false`, meaning the hitbox starts at the entity's feet (like in vanilla)
  :::
:Outputs:
  **State**: the entity now has a custom axis-aligned bounding box (AABB) hitbox
```

```{warning}
Custom hitboxes come with a **slight performance cost**. Use them when you need precise control over shape and position, but avoid using too many of them in the same area.
```

```{dropdown} What is a bounding box?
:color: info
:icon: question

A bounding box is a simple rectangular box that surrounds an object, or part of it, to help the game figure out where it is and what it touches. For example, a set of stairs in Minecraft uses two bounding boxes: one for the lower step and one for the upper step.
```

```{dropdown} What is a custom hitbox?
:color: info
:icon: question

A custom hitbox lets you override Minecraft's default hitbox system and define your own shape using width, height, and depth. Unlike dynamic or baked hitboxes, custom hitboxes:

- Can have independent width, height, and depth
- Are not tied to Minecraft's internal collision model
- Work on entities **without a native hitbox**, such as display entities

See [Hitbox types](#hitbox-types) for full details on block and entity hitboxes.
```

> **Credits**: Aksiome

---

## 🏷️ Tags

You can find below all tags available in this module.

---

### Blocks

#### Physical

:::::{tab-set}
::::{tab-item} Can pass through

**`#bs.hitbox:can_pass_through`**

Blocks without a collision box

::::
::::{tab-item} Has shape offset

**`#bs.hitbox:has_shape_offset`**

Blocks with a physical random offset

::::
::::{tab-item} Has visual offset

**`#bs.hitbox:has_visual_offset`**

Blocks with a purely visual random offset

::::
::::{tab-item} Intangible

**`#bs.hitbox:intangible`**

Blocks that cannot be physically interacted with, such as air variants, light blocks, and structure void

::::
::::{tab-item} Is full cube

**`#bs.hitbox:is_full_cube`**

Blocks whose `default` and `collision` shapes are both full 16×16×16 cubes

For shape-specific checks, use:
- `#bs.hitbox:is_full_cube_shape`
- `#bs.hitbox:is_full_cube_collision`
::::
:::::

#### Fluid

:::::{tab-set}
::::{tab-item} Is fluid

**`#bs.hitbox:is_fluid`**

Blocks whose fluid occupies the block space, such as water and lava

::::
::::{tab-item} Is water

**`#bs.hitbox:is_water`**

Blocks that represent water itself, such as water and bubble columns

::::
::::{tab-item} Is waterloggable

**`#bs.hitbox:is_waterloggable`**

Blocks that can contain water through a `waterlogged` block state

::::
::::{tab-item} Is waterlogged

**`#bs.hitbox:is_waterlogged`**

Blocks that contain water by default without having a `waterlogged` block state, such as kelp and seagrass

::::
:::::

> **Credits**: Aksiome

---

### Entities

::::{tab-set}
:::{tab-item} Intangible

**`#bs.hitbox:intangible`**

Entities that don't act as physical obstacles, such as projectiles, markers, and displays

:::
:::{tab-item} Is shaped

**`#bs.hitbox:is_shaped`**

Entities with different width and depth, such as paintings and item frames

:::
:::{tab-item} Is sized

**`#bs.hitbox:is_sized`**

Entities with equal width and depth

:::
::::

> **Credits**: Aksiome

---

(hitbox-types)=
## 🎓 Hitbox types

Bookshelf provides multiple hitbox types, each suited to different use cases. Understanding the differences helps you choose the right one.

---

(block-types)=
### Blocks

::::{tab-set}

:::{tab-item} 🖱 Default

The `default` shape defines the area where players can interact with or break the block:

- Specifies the zone where right-clicks, mining, or other interactions register
- Can differ from the collision shape, for example, fence gates keep the same default shape whether open or closed

➔ Returned by [#bs.hitbox:get_block_shape](#get-block)

:::
:::{tab-item} 🧊 Collision

The `collision` shape defines the physical boundaries of a block that entities cannot pass through. It determines where an entity will stop when moving towards the block:

- Matches the block's solid parts and prevents entities from moving through
- Can change dynamically depending on block state (e.g., a fence gate's collision shape differs when open vs closed)

➔ Returned by [#bs.hitbox:get_block_collision](#get-block)

:::
::::

---

(entity-types)=
### Entities

::::{tab-set}
:::{tab-item} 🔄 Dynamic

The native Minecraft hitbox, which updates automatically:

- Adjusts in real time with entity changes like scaling, baby growth, equipment, or new passengers
- No setup required, this is the default
- Use when the entity's shape is expected to change

➔ Restored using [#bs.hitbox:reset_entity](#reset-entity)

:::
:::{tab-item} ❄️ Baked

A snapshot of the entity's hitbox at a specific moment:

- Improves performance when the entity's size will never change
- Includes the base entity and all passengers in one combined box. When baking a pile of passengers, the base entity bakes all passengers and sets its hitbox to encompass the entire stack
- Does not update dynamically, collisions may break if the entity changes later

➔ Set using [#bs.hitbox:bake_entity](#bake-entity)

:::
:::{tab-item} 🛠️ Custom

A fully user-defined hitbox:

- Set exact `width`, `height`, and optional `depth`
- Works on entities with no native hitbox (e.g. display entities)
- Independent from Minecraft's internal hitbox system
- Only applies to the base entity. When used with modules that process entity stacks, only the base entity's hitbox is considered, passengers are ignored
- Slight performance cost, avoid using too many of them in the same area

➔ Set using [#bs.hitbox:set_entity](#set-entity)

:::
::::

---

(providers)=
## 🔌 Hitbox providers

A hitbox provider is a callback that returns a block's shape for consumers such as [`bs.raycast`](raycast.md) or [`bs.move`](move.md).

A provider can return one of two forms:

1. **A single flag** (e.g., `return 1`), telling the consumer to treat the block as a full 16×16×16 cube.
2. **An array of bounding boxes**, stored in `bs:lambda hitbox`:
   ```mcfunction
   {shape:[[min_x, min_y, min_z, max_x, max_y, max_z, flag], ...]}
   ```
   Each bounding box uses coordinates from 0 to 16, and may include a flag (defaults to `1` if omitted).

```{dropdown} What is a bounding box?
:color: info
:icon: question

A bounding box is a simple rectangular box that surrounds an object, or part of it, to help the game figure out where it is and what it touches. For example, a set of stairs in Minecraft uses two bounding boxes: one for the lower step and one for the upper step.
```

```{admonition} Flags
:class: info
Flags do not have inherent meaning. They are numeric labels used by providers and consumers to classify bounding boxes.
You may use any of the following flags: `1`, `2`, `4`, or `8`.

For example, the Bookshelf built-in providers use `1` for solid and `2` for fluids.
```

---

### Available providers

All built-in providers have a fluid variant, where `1` represents the solid part and `2` represents the fluid part.

::::{tab-set}

:::{tab-item} 🖱 Default
These providers return the block's **default** shape as defined in [Blocks](#block-types).
- `#bs.hitbox:callback/get_block_shape`  
- `#bs.hitbox:callback/get_block_shape_with_fluid`  
:::

:::{tab-item} 🧊 Collision
These providers return the block's **collision** shape as defined in [Blocks](#block-types).
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

### Custom providers

A common pattern for custom providers is either to directly return a custom shape or to:

1. Copy a built-in shape
2. Modify it
3. Return it

*Example: defining a custom shape with a custom flag*

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
