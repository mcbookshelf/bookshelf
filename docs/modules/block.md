# 🧱 Block

**`#bs.block:help`**

Manage blocks, including states and NBTs, while offering advanced tools for seamless transformations.

```{pull-quote}
"Architecture is the thoughtful making of space."

-- Louis Kahn
```

```{admonition} Virtual Block Format
:class: info

To manipulate blocks and their states, Bookshelf utilizes a [virtual block format](#get-block) stored in the block output. It's crucial not to update the virtual block format manually; instead, utilize the helper functions provided in the library.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Emit Particle

```{function} #bs.block:emit_block_particle

Emit block particle of a given block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the default **type** and reference for **pos**.

  **Storage `bs:in block.emit_block_particle`**:
  :::{treeview}
  - {nbt}`compound` Particle data
    - {nbt}`string` **type**: Block type (e.g. `minecraft:stone`).

      *If omitted, the block type at the current execution position will be used.*
    - {nbt}`compound` **properties**: Block properties (e.g. `{facing:"east"}`).

      *Only considered if **type** is present.*
    - {nbt}`string` **pos**: X Y Z coordinates, the position at which to create particle (default: `~ ~ ~`).
    - {nbt}`string` **delta**: X Y Z values, the random spread in blocks (default: `0 0 0`).
    - {nbt}`int` **speed**: Speed of the particle (default: `1`).
    - {nbt}`int` **count**: Number of particles to spawn (default: `1`).
    - {nbt}`string` **mode**: Display mode: `normal` or `force` (default: `normal`).
    - {nbt}`string` **viewers**: Control which player should view this particle (default: `@a`).
  :::

:Outputs:
  **State**: The particle is emitted.
```

*Example: Emit the particle of the block below your feet:*

```mcfunction
# Setup the input
data modify storage bs:in block.emit_block_particle set value { pos: "~ ~.5 ~", speed: 5, count: 30 }

# Emit the block particle (block below your feet)
execute positioned ~ ~-.5 ~ run function #bs.block:emit_block_particle
```

*Example: Emit the particle of the block at position 0 0 0:*

```mcfunction
# Get block data
execute positioned 0 0 0 run function #bs.block:get_type

# Setup the input with the retrieved block data
data modify storage bs:in block.emit_block_particle set from storage bs:out block
data modify storage bs:in block.emit_block_particle merge value { speed: 5, count: 30 }

# Emit the block particle
function #bs.block:emit_block_particle
```

> **Credits**: Aksiome, theogiraudet

---

### Fill Block

:::::{tab-set}
::::{tab-item} Block

```{function} #bs.block:fill_block

Fill all or part of a region with a specific block.

:Inputs:
  **Storage `bs:in block.fill_block`**:
  :::{treeview}
  - {nbt}`compound` Fill data
    - {nbt}`string` **block**: Block to fill the region with.
    - {nbt}`string` **from**: Starting position as a valid position string.
    - {nbt}`string` **to**: Ending position as a valid position string.
    - {nbt}`string` **mode**: Mode used to set blocks [outline|hollow|destroy|keep|replace|strict] (default: replace).
    - {nbt}`string` **filter**: Block used as a filter (default: none).
  :::

:Outputs:
  **State**: Blocks are placed in the world.
```

*Example: Fill an area with stone:*

```mcfunction
# Setup the input
data modify storage bs:in block.fill_block set value {block:"minecraft:stone",from:"~-3 ~-3 ~-3",to:"~3 ~3 ~3"}

# Run the fill
function #bs.block:fill_block
```
::::
::::{tab-item} Type

```{function} #bs.block:fill_type

Fill all or part of a region with a specific block type, preserving states and NBTs.

:Inputs:
  **Storage `bs:in block.fill_type`**:
  :::{treeview}
  - {nbt}`compound` Fill data
    - {nbt}`string` **type**: Block id to fill the region with.
    - {nbt}`string` **from**: Starting position as a valid position string.
    - {nbt}`string` **to**: Ending position as a valid position string.
    - {nbt}`string` **mode**: Mode used to set blocks [outline|hollow|destroy|keep|replace|strict] (default: replace).
    - {nbt}`string` **filter**: Block used as a filter (default: none).
  :::

:Outputs:
  **State**: Blocks are placed in the world.
```

*Example: Replace oak stairs with spruce stairs while preserving states and use a say command when finished:*

```mcfunction
# Setup the input
data modify storage bs:in block.fill_type set value {type:"minecraft:spruce_stairs",from:"~-3 ~-3 ~-3",to:"~3 ~3 ~3",filter:"minecraft:oak_stairs"}

# Run the process
function #bs.block:fill_type
```
::::
:::::

> **Credits**: Aksiome

---

### Get Block

:::::{tab-set}
::::{tab-item} Block

```{function} #bs.block:get_block

Get all data related to the block at the current location, including its state and NBTs.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`int` **group**: Blocks within the same group share the same possible state (e.g., stairs).
    - {nbt}`string` **block**: Full string representation of the block `type[state]{nbt}`.
    - {nbt}`string` **item**: Item string id associated with the block, if it exists.
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
    - {nbt}`string` **state**: Represent the state of a block (e.g., `[shape=straight]`), if it exists.
    - {nbt}`compound` **nbt**: Data tags used by block entities, if it exists.
    - {nbt}`compound` **properties**: Block state as properties (used by entities like falling blocks), if it exists.
  :::
```

*Example: Get block data of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_block

# See the result
data get storage bs:out block
```

::::
::::{tab-item} Type

```{function} #bs.block:get_type

Get the block type at the current location. Although states, NBTs, and properties will be empty, state transformation functions are still available.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`int` **group**: Blocks within the same group share the same possible state (e.g., stairs).
    - {nbt}`string` **block**: Full string representation of the block (only the type).
    - {nbt}`string` **item**: Item string id associated with the block, if it exists.
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
  :::
```

*Example: Get type data of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_type

# See the result
data get storage bs:out block
```

::::
:::::

```{admonition} Read-only Output
:class: warning

The `bs:out block` output is intended to be read-only. Modifying parts manually could lead to potential bugs. That's why the module provides numerous functions capable of making modifications to the output while preserving its integrity.
```

> **Credits**: Aksiome, theogiraudet

---

### Get Extras

:::::{tab-set}
::::{tab-item} Blast Res...
```{function} #bs.block:get_blast_resistance

Get the blast resistance value of the block at the current location.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`double` **blast_resistance**: The blast resistance of the block at the position.
  :::
```

```{dropdown} What is Blast Resistance?
:color: info
:icon: question
Blast resistance is a numeric value used by Minecraft to determine how well a block resists explosions. Higher values mean the block is harder to destroy by TNT, creepers, or other explosions.
```

*Example: Get the blast resistance of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_blast_resistance

# See the result
data get storage bs:out block
```
::::
::::{tab-item} Friction
```{function} #bs.block:get_friction

Get the friction value of the block at the current location.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`double` **friction**: The friction of the block at the position.
  :::
```

```{dropdown} What is Friction?
:color: info
:icon: question
Friction is a numeric value used by Minecraft to determine how slippery a block is. For example, normal blocks like stone have a friction of `0.6`, while ice has a higher friction of `0.98`.
```

*Example: Get the friction of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_friction

# See the result
data get storage bs:out block
```
::::
::::{tab-item} Hardness
```{function} #bs.block:get_hardness

Get the hardness value of the block at the current location.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`double` **hardness**: The hardness of the block at the position.
  :::
```

```{dropdown} What is Hardness?
:color: info
:icon: question
Hardness is a numeric value used by Minecraft to determine how long it takes to break a block with a tool.
For example, stone has a higher hardness than dirt, and obsidian has one of the highest hardness values in the game.
```

*Example: Get the hardness of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_hardness

# See the result
data get storage bs:out block
```
::::
::::{tab-item} Instrument
```{function} #bs.block:get_instrument

Get the note block instrument of the block at the current location (e.g., `harp`, `bass`, `snare`).

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`string` **instrument**: The instrument of the block at the position.
  :::
```

*Example: Get the instrument of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_instrument

# See the result
data get storage bs:out block
```
::::
::::{tab-item} Jump Factor
```{function} #bs.block:get_jump_factor

Get the jump factor value of the block at the current location.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`double` **jump_factor**: The jump factor of the block at the position.
  :::
```

*Example: Get the jump factor of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_jump_factor

# See the result
data get storage bs:out block
```
::::
::::{tab-item} Luminance
```{function} #bs.block:get_luminance

Get the luminance value of the block at the current location. The luminance can depend on block properties. For example, a `light` block may have different luminance values depending on its level.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`int` **luminance**: The luminance of the block at the position.
  :::
```

*Example: Get the luminance of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_luminance

# See the result
data get storage bs:out block
```
::::
::::{tab-item} Sounds
```{function} #bs.block:get_sounds

Get the sounds of the block at the current location.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`compound` **sounds**: The sounds of the block.
      - {nbt}`string` **break**: The sound played when a player breaks the block.
      - {nbt}`string` **fall**: The sound played when a player falls on the block.
      - {nbt}`string` **hit**: The sound played when a player hits the block.
      - {nbt}`string` **place**: The sound played when a player places the block.
      - {nbt}`string` **step**: The sound played when a player steps on the block.
  :::
```

*Example: Get the sounds of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_sounds

# See the result
data get storage bs:out block
```
::::
::::{tab-item} Speed Factor
```{function} #bs.block:get_speed_factor

Get the speed factor value of the block at the current location.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get block data from.

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`double` **speed_factor**: The speed factor of the block at the position.
  :::
```

*Example: Get the speed factor of the block below your feet:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~-.5 ~ run function #bs.block:get_speed_factor

# See the result
data get storage bs:out block
```
::::
:::::

```{tip}
These functions merge their results into `bs:out block` rather than replacing it. This means previously retrieved block data (for example, from [`#bs.block:get_block`](#get-block)) remains intact.
```

> **Credits**: Aksiome

---

### Is Touching Power

:::::{tab-set}
::::{tab-item} Any

```{function} #bs.block:is_touching_power

Determine whether the current position is touching a powered block or is powered by a redstone component.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the block to check.

:Outputs:
  **Return**: Success or failure.
```
::::
::::{tab-item} Strong

```{function} #bs.block:is_touching_strong_power

Determine whether the current position is touching a strongly powered block or is powered by a redstone component.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the block to check.

:Outputs:
  **Return**: Success or failure.
```
::::
::::{tab-item} Weak

````{function} #bs.block:is_touching_weak_power

Determine whether the current position is touching a weakly powered block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the block to check.

:Outputs:
  **Return**: Success or failure.
````
::::
:::::

*Example: Check whether the current location should activate a redstone mechanism:*

```mcfunction
execute if function #bs.block:is_touching_power run say ACTIVATE
```

```{admonition} Unsupported Redstone Components
:class: warning

The `trapped_chest` block is not supported by these functions. They rely on block states to determine power, and `trapped_chest` blocks do not update their block state when opened.
```

> **Credits**: Aksiome

---

### Lookup Block

:::::{tab-set}
::::{tab-item} By Type

```{function} #bs.block:lookup_type {type:<value>}

Get block data from the given type string id. The output is equivalent to [`#bs.block:get_type`](#get-block), but also includes all additional attributes that are not dependent on block state.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **type**: Type string id associated to a block.
  :::

:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`int` **group**: Blocks within the same group share the same possible state (e.g., stairs).
    - {nbt}`string` **block**: Full string representation of the block (only the type).
    - {nbt}`string` **item**: Item string id associated with the block, if it exists.
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
    - {nbt}`bool` **can_occlude**: Whether the block occludes neighboring faces.
    - {nbt}`bool` **ignited_by_lava**: Whether the block can catch fire when exposed to lava.
    - {nbt}`double` **blast_resistance**: The blast resistance of the block at the position.
    - {nbt}`double` **friction**: The friction of the block at the position.
    - {nbt}`double` **hardness**: The hardness of the block at the position.
    - {nbt}`double` **jump_factor**: The jump factor of the block at the position.
    - {nbt}`double` **speed_factor**: The speed factor of the block at the position.
    - {nbt}`string` **instrument**: The instrument of the block at the position.
    - {nbt}`compound` **sounds**: The sounds of the block.
      - {nbt}`string` **break**: The sound played when a player breaks the block.
      - {nbt}`string` **hit**: The sound played when a player hits the block.
      - {nbt}`string` **fall**: The sound played when a player falls on the block.
      - {nbt}`string` **place**: The sound played when a player places the block.
      - {nbt}`string` **step**: The sound played when a player steps on the block.
  :::
```

*Example: Get block data for the stone type:*

```mcfunction
# Get block type data
function #bs.block:lookup_type {type:"minecraft:stone"}

# See the result
data get storage bs:out block.block
```
::::
::::{tab-item} By Item

````{function} #bs.block:lookup_item {item:<value>}

```{important}
Minecraft does not perfectly map between blocks and items. Some items may correspond to multiple blocks, and this function will only return one of them.
```

Get block data from the given item string id. The output is equivalent to [`#bs.block:get_type`](#get-block), but also includes all additional attributes that are not dependent on block state.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **item**: Item string id associated to a block.
  :::


:Outputs:
  **Storage `bs:out block`**:
  :::{treeview}
  - {nbt}`compound` **[readonly]** Block data
    - {nbt}`int` **group**: Blocks within the same group share the same possible state (e.g., stairs).
    - {nbt}`string` **block**: Full string representation of the block (only the type).
    - {nbt}`string` **item**: Item string id associated with the block, if it exists.
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
    - {nbt}`bool` **can_occlude**: Whether the block occludes neighboring faces.
    - {nbt}`bool` **ignited_by_lava**: Whether the block can catch fire when exposed to lava.
    - {nbt}`double` **blast_resistance**: The blast resistance of the block at the position.
    - {nbt}`double` **friction**: The friction of the block at the position.
    - {nbt}`double` **hardness**: The hardness of the block at the position.
    - {nbt}`double` **jump_factor**: The jump factor of the block at the position.
    - {nbt}`double` **speed_factor**: The speed factor of the block at the position.
    - {nbt}`string` **instrument**: The instrument of the block at the position.
    - {nbt}`compound` **sounds**: The sounds of the block.
      - {nbt}`string` **break**: The sound played when a player breaks the block.
      - {nbt}`string` **hit**: The sound played when a player hits the block.
      - {nbt}`string` **fall**: The sound played when a player falls on the block.
      - {nbt}`string` **place**: The sound played when a player places the block.
      - {nbt}`string` **step**: The sound played when a player steps on the block.
  :::
````

*Example: Get block data for the stone item:*

```mcfunction
# Get block type data
function #bs.block:lookup_item {item:"minecraft:stone"}

# See the result
data get storage bs:out block.block
```

::::
:::::

```{admonition} Read-only Output
:class: warning

The `bs:out block` output is intended to be read-only. Modifying parts manually could lead to potential bugs. That's why the module provides numerous functions capable of making modifications to the output while preserving its integrity.
```

> **Credits**: Aksiome

---

### Manage State

:::::{tab-set}
::::{tab-item} Keep

```{function} #bs.block:keep_properties {properties:[]}

Filter properties to keep only the desired ones. This function acts on the [virtual block format](#get-block) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to keep.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `shape`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There's no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get-block).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Example: Keep only the facing and shape properties:*

```mcfunction
# Once (on stairs)
execute positioned ~ ~ ~ run function #bs.block:get_block

# Run the transformation
function #bs.block:keep_properties {properties:[{name:"facing"},{name:"shape"}]}

# See the result
data get storage bs:out block.block
```

::::
::::{tab-item} Merge

```{function} #bs.block:merge_properties {properties:[]}

Merge state properties from the current location into the output. The merge occurs if the syntax is correct, regardless of logical coherence (e.g., using 'age' for different plants). This function acts on the [virtual block format](#get-block) stored in the block output.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Location of the block that act as input.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to merge.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `shape`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There's no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get-block).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Example: Merge the facing of a block onto stairs:*

```mcfunction
# Once (on stairs)
execute positioned ~ ~ ~ run function #bs.block:get_block

# Run the transformation (on a block with facing)
execute positioned ~ ~ ~ run function #bs.block:merge_properties {properties:[{name:"facing"}]}

# See the result
data get storage bs:out block.block
```

::::
::::{tab-item} Remove

```{function} #bs.block:remove_properties {properties:[]}

Filter properties by removing the undesired ones. This function acts on the [virtual block format](#get-block) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to remove.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `shape`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There's no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get-block).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Example: Remove the facing and shape properties:*

```mcfunction
# Once (on stairs)
execute positioned ~ ~ ~ run function #bs.block:get_block

# Run the transformation
function #bs.block:remove_properties {properties:[{name:"facing"},{name:"shape"}]}

# See the result
data get storage bs:out block.block
```

::::
::::{tab-item} Replace

```{function} #bs.block:replace_properties {properties:[]}

Replace property values. Invalid values will not be replaced. This function acts on the [virtual block format](#get-block) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to replace.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `facing`).
        - {nbt}`string` **value**: Value of the property (e.g., `east`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There's no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get-block).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Example: Replace the facing property value:*

```mcfunction
# Once (on stairs)
execute positioned ~ ~ ~ run function #bs.block:get_block

# Run the transformation
function #bs.block:replace_properties {properties:[{name:"facing",value:"east"}]}

# See the result
data get storage bs:out block.block
```

::::
::::{tab-item} Shift

```{function} #bs.block:shift_properties {properties:[]}

Shift properties by any amount, allowing cycling through their values. This function acts on the [virtual block format](#get-block) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to shift.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `shape`).
        - {nbt}`string` **by**: Shift amount (defaults to 1).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There's no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get-block).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Example: Shift the facing property value by 2:*

```mcfunction
# Once (on stairs)
execute positioned ~ ~ ~ run function #bs.block:get_block

# Run the transformation
function #bs.block:shift_properties {properties:[{name:"facing",by:2}]}

# See the result
data get storage bs:out block.block
```

::::
:::::

> **Credits**: Aksiome

---

### Manage Type

:::::{tab-set}
::::{tab-item} Replace

```{function} #bs.block:replace_type {type:<value>}

Replace the block type while trying to conserve the state. State is preserved only if the group of the output matches the input. This function acts on the [virtual block format](#get-block) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There's no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get-block).

:Outputs:
  **Return**: Whether a type was found and the replacement occurred.

  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Example: Replace oak stairs with spruce stairs, preserving the current state:*

```mcfunction
# Once (on oak_stairs)
execute positioned ~ ~ ~ run function #bs.block:get_block

# Replace type data
function #bs.block:replace_type {type:"minecraft:spruce_stairs"}

# See the result
data get storage bs:out block.block
```

::::
::::{tab-item} Map

`````{function} #bs.block:map_type {type:<value>,mapping_registry:<value>}

Swap related block types while ensuring coherent replacements within the defined mapping registry. A mapping registry is defined as follows:

```{code-block} mcfunction
:force:
data modify storage bs:const block.mapping_registry.bs.colors set value [ \
  { set: "wool", attrs: ["red"], type: "minecraft:red_wool" }, \
  { set: "wool", attrs: ["green"], type: "minecraft:green_wool" }, \
  { set: "carpet", attrs: ["red"], type: "minecraft:red_carpet" }, \
  { set: "carpet", attrs: ["green"], type: "minecraft:green_carpet" }, \
]
```

This function operates on the [virtual block format](#get-block) stored in the block output. It replaces the type in the output with one that belongs to the same set and better matches the attributes of the inputted type.

For example, with the above mapping registry: if the input is `minecraft:red_wool` (attrs:["red"]), and the virtual block type is `minecraft:green_carpet` (set:"carpet"), the resulting block will be `minecraft:red_carpet` (set:"carpet",attrs:["red"]).

Bookshelf includes two predefined mapping registries (`bs.shapes` and `bs.colors`). If these are insufficient, you can [create your own](#custom-mapping-registry).

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
    - {nbt}`string` **mapping_registry**: A path to the mapping registry used for the replacement (e.g., `bs.shapes`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There's no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get-block).

:Outputs:
  **Return**: Whether a type was found and the replacement occurred.

  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
`````

*Example: Replace all oak-related blocks with spruce ones (the function replaces the oak stairs block with a spruce stairs block):*

```mcfunction
# Once (on oak_stairs)
execute positioned ~ ~ ~ run function #bs.block:get_block

# Replace type data
function #bs.block:map_type { type: "minecraft:spruce_planks", mapping_registry: "bs.shapes" }

# See the result
data get storage bs:out block.block
```

::::
::::{tab-item} Mix

`````{function} #bs.block:mix_type {type:<value>,mapping_registry:<value>}

```{admonition} Experimental
:class: warning

This function may sometimes behave unpredictably due to the arbitrary nature of block relationship definitions. Additionally, while the provided registries aim to cover a wide range of blocks, they are handcrafted and therefore not exhaustive.
```

Mix block types while ensuring coherent replacements within the defined mapping registry. A mapping registry is defined as follows:

```{code-block} mcfunction
:force:
data modify storage bs:const block.mapping_registry.bs.shapes set value [ \
  { set: "cube", attrs: ["stone"], type: "minecraft:stone" }, \
  { set: "cube", attrs: ["brick"], type: "minecraft:bricks" }, \
  { set: "cube", attrs: ["stone", "brick"], type: "minecraft:stone_bricks" }, \
  { set: "stairs", attrs: ["stone"], type: "minecraft:stone_stairs" }, \
  { set: "stairs", attrs: ["brick"], type: "minecraft:brick_stairs" }, \
  { set: "stairs", attrs: ["stone","brick"], type: "minecraft:stone_brick_stairs" }, \
]
```

This function operates on the [virtual block format](#get-block) stored in the block output. It replaces the type in the output with one that belongs to the same set and better matches the attributes of both the output and input types while prioritizing the input type.

For example, with the above mapping registry: if the input is `minecraft:bricks` (attrs:["brick"]), and the virtual block type is `minecraft:stone_stairs` (set:"stairs",attrs:["stone"]), the resulting block will be `minecraft:stone_brick_stairs` (set:"stairs",attrs:["stone","brick"]).

Bookshelf includes two predefined mapping registries (`bs.shapes` and `bs.colors`). If these are insufficient, you can [create your own](#custom-mapping-registry).

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
    - {nbt}`string` **mapping_registry**: A path to the mapping registry used for the replacement (e.g., `bs.shapes`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There's no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get-block).

:Outputs:
  **Return**: Whether a type was found and the replacement occurred.

  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
`````

*Example: Mix a mossy cobblestone block with bricks resulting in a mossy stone bricks block:*

```mcfunction
# Once (on mossy_cobblestone)
execute positioned ~ ~ ~ run function #bs.block:get_block

# Replace type data
function #bs.block:mix_type { type: "minecraft:bricks", mapping_registry: "bs.shapes" }

# See the result
data get storage bs:out block.block
```

::::
:::::

> **Credits**: Aksiome

---

### Match

```{function} #bs.block:match

Determine if the block at the specified location matches the provided one.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Location of the block to check.

  **Storage `bs:in block.match.block`**: {nbt}`string` Full string representation of the block to check against.

:Outputs:
  **Return**: Whether the check is a success or a failure (1 or 0).
```

*Example: Check that the block at 0 0 0 matches the block at 0 1 0:*

```mcfunction
# Get block data at 0 0 0
execute positioned 0 0 0 run function #bs.block:get_block

# Setup the input
data modify storage bs:in block.match.block set from storage bs:out block.block

# Run a command if it's a match
execute positioned 0 1 0 if function #bs.block:match run say It's a match
```

> **Credits**: Aksiome, theogiraudet

---

### Play Sound

:::::{tab-set}
::::{tab-item} Break
```{function} #bs.block:play_break_sound

Play the block’s break sound.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the default **type** and reference for **pos**.

  **Storage `bs:in block.play_break_sound`**:
  :::{treeview}
  - {nbt}`compound` Block sound data
    - {nbt}`string` **type**: Block type (e.g. `minecraft:stone`).

      *If omitted, the block type at the current execution position will be used.*
    - {nbt}`string` **source**: Source of the sound: `master`, `music`, `record`, `weather`, `block`, `hostile`, `neutral`, `player`, `ambient`, or `voice` (default: `master`).
    - {nbt}`string` **targets**: The entities who will hear the sound (default: `@s`).
    - {nbt}`string` **pos**: X Y Z coordinates of the sound’s position (default: `~ ~ ~`).
    - {nbt}`double` **pitch**: Pitch of the sound (default: `1.0`).
    - {nbt}`double` **volume**: Volume of the sound (default: `1.0`).
    - {nbt}`double` **min_volume**: Minimum volume of the sound (default: `0.0`).
  :::

:Outputs:
  **State**: The sound is played.
```
::::
::::{tab-item} Fall
```{function} #bs.block:play_fall_sound

Play the block’s fall sound.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the default **type** and reference for **pos**.

  **Storage `bs:in block.play_fall_sound`**:
  :::{treeview}
  - {nbt}`compound` Block sound data
    - {nbt}`string` **type**: Block type (e.g. `minecraft:stone`).

      *If omitted, the block type at the current execution position will be used.*
    - {nbt}`string` **source**: Source of the sound: `master`, `music`, `record`, `weather`, `block`, `hostile`, `neutral`, `player`, `ambient`, or `voice` (default: `master`).
    - {nbt}`string` **targets**: The entities who will hear the sound (default: `@s`).
    - {nbt}`string` **pos**: X Y Z coordinates of the sound’s position (default: `~ ~ ~`).
    - {nbt}`double` **pitch**: Pitch of the sound (default: `1.0`).
    - {nbt}`double` **volume**: Volume of the sound (default: `1.0`).
    - {nbt}`double` **min_volume**: Minimum volume of the sound (default: `0.0`).
  :::

:Outputs:
  **State**: The sound is played.
```
::::
::::{tab-item} Hit
```{function} #bs.block:play_hit_sound

Play the block’s hit sound.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the default **type** and reference for **pos**.

  **Storage `bs:in block.play_hit_sound`**:
  :::{treeview}
  - {nbt}`compound` Block sound data
    - {nbt}`string` **type**: Block type (e.g. `minecraft:stone`).

      *If omitted, the block type at the current execution position will be used.*
    - {nbt}`string` **source**: Source of the sound: `master`, `music`, `record`, `weather`, `block`, `hostile`, `neutral`, `player`, `ambient`, or `voice` (default: `master`).
    - {nbt}`string` **targets**: The entities who will hear the sound (default: `@s`).
    - {nbt}`string` **pos**: X Y Z coordinates of the sound’s position (default: `~ ~ ~`).
    - {nbt}`double` **pitch**: Pitch of the sound (default: `1.0`).
    - {nbt}`double` **volume**: Volume of the sound (default: `1.0`).
    - {nbt}`double` **min_volume**: Minimum volume of the sound (default: `0.0`).
  :::

:Outputs:
  **State**: The sound is played.
```
::::
::::{tab-item} Place
```{function} #bs.block:play_place_sound

Play the block’s place sound.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the default **type** and reference for **pos**.

  **Storage `bs:in block.play_place_sound`**:
  :::{treeview}
  - {nbt}`compound` Block sound data
    - {nbt}`string` **type**: Block type (e.g. `minecraft:stone`).

      *If omitted, the block type at the current execution position will be used.*
    - {nbt}`string` **source**: Source of the sound: `master`, `music`, `record`, `weather`, `block`, `hostile`, `neutral`, `player`, `ambient`, or `voice` (default: `master`).
    - {nbt}`string` **targets**: The entities who will hear the sound (default: `@s`).
    - {nbt}`string` **pos**: X Y Z coordinates of the sound’s position (default: `~ ~ ~`).
    - {nbt}`double` **pitch**: Pitch of the sound (default: `1.0`).
    - {nbt}`double` **volume**: Volume of the sound (default: `1.0`).
    - {nbt}`double` **min_volume**: Minimum volume of the sound (default: `0.0`).
  :::

:Outputs:
  **State**: The sound is played.
```
::::
::::{tab-item} Step
```{function} #bs.block:play_step_sound

Play the block’s step sound.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position of the default **type** and reference for **pos**.

  **Storage `bs:in block.play_step_sound`**:
  :::{treeview}
  - {nbt}`compound` Block sound data
    - {nbt}`string` **type**: Block type (e.g. `minecraft:stone`).

      *If omitted, the block type at the current execution position will be used.*
    - {nbt}`string` **source**: Source of the sound: `master`, `music`, `record`, `weather`, `block`, `hostile`, `neutral`, `player`, `ambient`, or `voice` (default: `master`).
    - {nbt}`string` **targets**: The entities who will hear the sound (default: `@s`).
    - {nbt}`string` **pos**: X Y Z coordinates of the sound’s position (default: `~ ~ ~`).
    - {nbt}`double` **pitch**: Pitch of the sound (default: `1.0`).
    - {nbt}`double` **volume**: Volume of the sound (default: `1.0`).
    - {nbt}`double` **min_volume**: Minimum volume of the sound (default: `0.0`).
  :::

:Outputs:
  **State**: The sound is played.
```
::::
:::::

*Example: Play the step sound of the block below your feet:*

```mcfunction
# Setup the input
data modify storage bs:in block.play_step_sound set value { source: "block", pos: "~ ~.5 ~" }

# Play the block sound (block below your feet)
execute positioned ~ ~-.5 ~ run function #bs.block:play_step_sound
```

*Example: Play the break sound of the block at position 0 0 0:*

```mcfunction
# Get block data
execute positioned 0 0 0 run function #bs.block:get_type

# Setup the input with the retrieved block data
data modify storage bs:in block.play_break_sound set value { source: "block" }
data modify storage bs:in block.play_break_sound.type set from storage bs:out block.type

# Play the block sound
function #bs.block:play_break_sound
```

> **Credits**: Aksiome, theogiraudet

---

### Set Block

:::::{tab-set}
::::{tab-item} Block

```{function} #bs.block:set_block

Place a block at the current location.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to set the block to.

  **Storage `bs:in block.set_block`**:
  :::{treeview}
  - {nbt}`compound` Set block data
    - {nbt}`string` **block**: Full string representation of the block to set.
    - {nbt}`string` **mode**: Mode used to set the block [destroy|keep|replace|strict] (default: replace).
  :::

:Outputs:
  **State**: A block is placed in the world.
```

*Example: Place a block of stone at 0 0 0 by destroying the existing one:*

```mcfunction
# Setup the input
data modify storage bs:in block.set_block set value {block:"minecraft:stone",mode:"destroy"}

# Run the function
execute positioned 0 0 0 run function #bs.block:set_block
```

::::
::::{tab-item} Type

```{function} #bs.block:set_type

Replace the block type at the current location while trying to conserve its state and NBTs.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to set the block to.

  **Storage `bs:in block.set_type`**:
  :::{treeview}
  - {nbt}`compound` Set type data
    - {nbt}`string` **type**: String representation of the block id to set.
    - {nbt}`string` **mode**: Mode used to set the block [destroy|keep|replace|strict] (default: replace).
  :::

:Outputs:
  **State**: A block is placed in the world.
```

*Example: Replace any stairs with oak stairs, preserving the current state:*

```mcfunction
# Setup the input
data modify storage bs:in block.set_type.type set value "minecraft:oak_stairs"

# Run the function
execute positioned 0 0 0 run function #bs.block:set_type
```

::::
:::::

> **Credits**: Aksiome, theogiraudet

---

### Spawn Entity

:::::{tab-set}
::::{tab-item} Block Display

```{function} #bs.block:spawn_block_display

Spawn a block display representing the given block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position where the entity will be summoned.

  **Storage `bs:in block.spawn_block_display`**:
  :::{treeview}
  - {nbt}`compound` Block display data
    - {nbt}`string` **type**: Block type (similar to block output).
    - {nbt}`compound` **properties**: Block properties (similar to block output).
    - {nbt}`compound` **extra_nbt**: Additional NBTs to summon the entity with.
  :::

:Outputs:
  **State**: The entity is summoned.
```

*Example: Summon a block display using the block at 0 0 0:*

```mcfunction
# Get block data
execute positioned 0 0 0 run function #bs.block:get_block

# Setup the input
data modify storage bs:in block.spawn_block_display set from storage bs:out block

# Summon the block display
function #bs.block:spawn_block_display
```

::::
::::{tab-item} Falling Block

```{function} #bs.block:spawn_falling_block

Spawn a falling block representing the given block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position where the entity will be summoned.

  **Storage `bs:in block.spawn_falling_block`**:
  :::{treeview}
  - {nbt}`compound` Falling block data
    - {nbt}`string` **type**: Block type (similar to block output).
    - {nbt}`compound` **properties**: Block properties (similar to block output).
    - {nbt}`compound` **extra_nbt**: Additional NBTs to summon the entity with.
  :::

:Outputs:
  **State**: The entity is summoned.
```

*Example: Summon a falling block using the block at 0 0 0:*

```mcfunction
# Get block data
execute positioned 0 0 0 run function #bs.block:get_block

# Setup the input
data modify storage bs:in block.spawn_falling_block set from storage bs:out block

# Summon the block display
function #bs.block:spawn_falling_block
```

::::
::::{tab-item} Solid Block Display

```{function} #bs.block:spawn_solid_block_display

Spawn a block display with a hitbox, representing the given block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position where the entity will be summoned.

  **Storage `bs:in block.spawn_solid_block_display`**:
  :::{treeview}
  - {nbt}`compound` Block display data
    - {nbt}`string` **type**: Block type (similar to block output).
    - {nbt}`compound` **properties**: Block properties (similar to block output).
    - {nbt}`compound` **extra_nbt**: Additional NBTs to summon the entity with.
  :::

:Outputs:
  **State**: The entity is summoned.
```

*Example: Summon a block display with a hitbox using the block at 0 0 0:*

```mcfunction
# Get block data
execute positioned 0 0 0 run function #bs.block:get_block

# Setup the input
data modify storage bs:in block.spawn_solid_block_display set from storage bs:out block

# Summon the block display
function #bs.block:spawn_solid_block_display
```

::::
:::::

> **Credits**: Aksiome, theogiraudet

---

## 👁️ Predicates

You can find below all predicates available in this module.

---

### Is Conductive

**`bs.block:is_conductive`**

Check if the block at the current location can conduct redstone. The conductivity can depend on block properties. For example, a slab block may only be conductive if it is a double slab.

> **Credits**: Aksiome

---

### Is Powered

**`bs.block:is_powered`**

Check if the block is [`conductive`](#is-conductive) and powered by redstone.

> **Credits**: Aksiome

---

### Is Spawnable

**`bs.block:is_spawnable`**

Check if the block at the current location can serve as a valid spawn surface. This does not consider light level and may depend on block properties. For example, a `slab` may be spawnable only if it is not a bottom slab.

> **Credits**: Aksiome

---

### Is Strongly Powered

**`bs.block:is_strongly_powered`**

Check if the block is [`conductive`](#is-conductive) and strongly powered by redstone.

```{dropdown} What is Strongly Powered?
:color: info
:icon: question
A block is strongly powered when it can power adjacent redstone dust (including redstone dust on and beneath the block), in addition to activating adjacent mechanism component, and powering redstone repeaters and redstone comparators facing away from the block.

A block becomes strongly powered by being powered by a redstone power component, a powered redstone repeater, or a powered redstone comparator.
```

> **Credits**: Aksiome

---

### Is Weakly Powered

**`bs.block:is_weakly_powered`**

Check if the block is [`conductive`](#is-conductive) and weakly powered by redstone.

```{dropdown} What is Weakly Powered?
:color: info
:icon: question
A block that is weakly powered cannot power adjacent redstone dust, but can still activate adjacent redstone mechanisms, and power redstone repeaters and redstone comparators facing away from the block.

A block becomes weakly powered when it is powered only by redstone dust.
```

> **Credits**: Aksiome

---

## 🏷️ Tags

You can find below below all tags available in this module.

---

### Can Occlude

**`#bs.block:can_occlude`**

Determine if the block occludes neighboring faces (i.e., whether it’s solid enough to hide adjacent block faces).

> **Credits**: Aksiome

---

### Has State

**`#bs.hitbox:has_state`**

Determine if the block can have state properties (e.g., facing, waterlogged).

> **Credits**: Aksiome

---

### Ignited by Lava

**`#bs.hitbox:ignited_by_lava`**

Determine if the block can catch fire when exposed to lava.

> **Credits**: Aksiome

---

(custom-mapping-registry)=
## 🎓 Custom Mapping Registry

This module allows you to create a personalized mapping registry tailored to your specific needs.

---

To create a new registry, you need to define an array within the `bs:const block.mapping_registry` storage. Each new registry should be namespaced, and each element must include `set`, `attrs`, and `type`. Here's how you can define a new mapping registry:

```{code-block} mcfunction
:force:
data modify storage bs:const block.mapping_registry.<namespace>.<name> [
  { set: "cube", attrs: ["oak"], type: "minecraft:oak_planks" }, \
  { set: "cube", attrs: ["spruce"], type: "minecraft:spruce_planks" }, \
  \
  { set: "stairs", attrs: ["oak"], type: "minecraft:oak_stairs" }, \
  { set: "stairs", attrs: ["spruce"], type: "minecraft:spruce_stairs" }, \
  \
  { set: "slab", attrs: ["oak"], type: "minecraft:oak_slab" }, \
  { set: "slab", attrs: ["spruce"], type: "minecraft:spruce_slab" }, \
]
```

---

```{include} ../_templates/comments.md
```
