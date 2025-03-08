# 🧱 Block

**`#bs.block:help`**

Manage blocks, including states and NBTs, while offering advanced tools for seamless transformations.

```{epigraph}
"Architecture is the thoughtful making of space."

-- Louis Kahn
```

```{admonition} Virtual Block Format
:class: info

To manipulate blocks and their states, Bookshelf utilizes a [virtual block format](#get) stored in the block output. It's crucial not to update it manually; instead, utilize the helper functions provided in the library.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Fill

:::::{tab-set}
::::{tab-item} Block

```{function} #bs.block:fill_block

Fill all or part of a region with a specific block.

:Inputs:
  **Storage `bs:in block.fill_block`**:
  :::{treeview}
  - {nbt}`compound` Fill block data
    - {nbt}`string` **block**: Block to fill the region with.
    - {nbt}`string` {nbt}`list` **from**: Starting position as a valid position string or a list of 3 elements (x, y, z).
    - {nbt}`string` {nbt}`list` **to**: Ending position as a valid position string or a list of 3 elements (x, y, z).
    - {nbt}`int` **limit**: Limit how many blocks can be set in a single tick (default: 4096).
    - {nbt}`string` **mode**: Mode used to set blocks [destroy|keep|replace] (default: replace).
    - {nbt}`string` **on_finished**: Command executed at the end of the operation (at the location of the final block).
    - {nbt}`list` **masks**: Determine which blocks will be replaced.
      - {nbt}`compound` Block mask
        - {nbt}`string` **block**: Block acting as a filter.
        - {nbt}`bool` **negate**: Reverse the mask (default: false).
        - {nbt}`int` **x**: Mask filter x offset (default: 0).
        - {nbt}`int` **y**: Mask filter y offset (default: 0).
        - {nbt}`int` **z**: Mask filter z offset (default: 0).
  :::

:Outputs:
  **State**: Blocks are placed in the world.
```

*Replace the top layer of dirt by grass and use a say command when finished:*

```mcfunction
# Setup the input
data modify storage bs:in block.fill_block set value {block:"minecraft:grass_block",from:[-16,100,0],to:[-1,103,15],on_finished:"say added grass on top",masks:[{block:"minecraft:dirt"},{block:"minecraft:air",y:1}]}

# Run the process
function #bs.block:fill_block
```

*Fill an area with stone a few blocks at a time:*

```mcfunction
# Setup the input
data modify storage bs:in block.fill_block set value {block:"minecraft:stone",from:[-16,100,0],to:[-1,103,15],limit:8}

# Run the process
function #bs.block:fill_block
```
::::
::::{tab-item} Type

```{function} #bs.block:fill_type

Fill all or part of a region with a specific block type, preserving states and NBTs.

:Inputs:
  **Storage `bs:in block.fill_type`**:
  :::{treeview}
  - {nbt}`compound` Fill type data
    - {nbt}`string` **type**: Block id to fill the region with.
    - {nbt}`string` {nbt}`list` **from**: Starting position as a valid position string or a list of 3 elements (x, y, z).
    - {nbt}`string` {nbt}`list` **to**: Ending position as a valid position string or a list of 3 elements (x, y, z).
    - {nbt}`int` **limit**: Limit how many blocks can be set in a single tick (default: 4096).
    - {nbt}`string` **mode**: Mode used to set blocks [destroy|keep|replace] (default: replace).
    - {nbt}`string` **on_finished**: Command executed at the end of the operation (at the location of the final block).
    - {nbt}`list` **masks**: Determine which blocks will be replaced.
      - {nbt}`compound` Block mask
        - {nbt}`string` **block**: Block acting as a filter.
        - {nbt}`bool` **negate**: Reverse the mask (default: false).
        - {nbt}`int` **x**: Mask filter x offset (default: 0).
        - {nbt}`int` **y**: Mask filter y offset (default: 0).
        - {nbt}`int` **z**: Mask filter z offset (default: 0).
  :::

:Outputs:
  **State**: Blocks are placed in the world.
```

*Replace oak stairs with spruce stairs while preserving states and use a say command when finished:*

```mcfunction
# Setup the input
data modify storage bs:in block.fill_type set value {type:"minecraft:spruce_stairs",from:[-16,100,0],to:[-1,103,15],on_finished:"say replaced the stairs",masks:[{block:"minecraft:oak_stairs"}]}

# Run the process
function #bs.block:fill_type
```
::::
::::{tab-item} Random

```{function} #bs.block:fill_random

Fill all or part of a region with random blocks or types.

:Inputs:
  **Storage `bs:in block.fill_random`**:
  :::{treeview}
  - {nbt}`compound` Fill random data
    - {nbt}`list` **entries**: List of entries to pick from randomly.
      - {nbt}`compound` Block or type entry
        - {nbt}`string` **block | type**: Block or type to fill the region with.
        - {nbt}`int` **weight**: Determine the likelihood of selecting the entry (default: 1).
    - {nbt}`string` {nbt}`list` **from**: Starting position as a valid position string or a list of 3 elements (x, y, z).
    - {nbt}`string` {nbt}`list` **to**: Ending position as a valid position string or a list of 3 elements (x, y, z).
    - {nbt}`int` **limit**: Limit how many blocks can be set in a single tick (default: 4096).
    - {nbt}`string` **mode**: Mode used to set blocks [destroy|keep|replace] (default: replace).
    - {nbt}`string` **on_finished**: Command executed at the end of the operation (at the location of the final block).
    - {nbt}`list` **masks**: Determine which blocks will be replaced.
      - {nbt}`compound` Block mask
        - {nbt}`string` **block**: Block acting as a filter.
        - {nbt}`bool` **negate**: Reverse the mask (default: false).
        - {nbt}`int` **x**: Mask filter x offset (default: 0).
        - {nbt}`int` **y**: Mask filter y offset (default: 0).
        - {nbt}`int` **z**: Mask filter z offset (default: 0).
  :::

:Outputs:
  **State**: Blocks are placed in the world.
```

*Randomly fill an area with stone or air and use a say command when finished:*

```mcfunction
# Setup the input
data modify storage bs:in block.fill_random set value {entries:[{block:"minecraft:stone"},{block:"minecraft:air"}],from:[-16,100,0],to:[-1,103,15],on_finished:"say randomly placed stone"}

# Run the process
function #bs.block:fill_random
```
::::
:::::

> **Credits**: Aksiome

---

### Get

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
    - {nbt}`string` **state**: Represent the state of a block (e.g., `[shape=straight]`).
    - {nbt}`compound` **nbt**: Data tags used by block entities or an empty string.
    - {nbt}`compound` **properties**: Block state as properties (used by entities like falling blocks).
    - {nbt}`compound` **sounds**: The sound list of a block.
      - {nbt}`string` **break**: The sound played when a player break the block.
      - {nbt}`string` **hit**: The sound played when a player hit the block.
      - {nbt}`string` **fall**: The sound played when a player fall on the block.
      - {nbt}`string` **place**: The sound played when a player place the block.
      - {nbt}`string` **step**: The sound played when a player step on the block.
  :::
```

*Get all data related to a block:*

```mcfunction
# Run the get function on a block
execute positioned ~ ~ ~ run function #bs.block:get_block

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
    - {nbt}`string` **state**: Represent the state of a block **[empty string]**.
    - {nbt}`compound` **nbt**: Data tags used by block entities **[empty string]**.
    - {nbt}`compound` **properties**: Block state as properties **[empty compound]**.
    - {nbt}`compound` **sounds**: The sound list of a block.
      - {nbt}`string` **break**: The sound played when a player break the block.
      - {nbt}`string` **hit**: The sound played when a player hit the block.
      - {nbt}`string` **fall**: The sound played when a player fall on the block.
      - {nbt}`string` **place**: The sound played when a player place the block.
      - {nbt}`string` **step**: The sound played when a player step on the block.
  :::
```

*Get only type data related to a block (no property value is selected):*

```mcfunction
# Run the get function on a block
execute positioned ~ ~ ~ run function #bs.block:get_type

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

### Manage State

:::::{tab-set}
::::{tab-item} Keep

```{function} #bs.block:keep_properties {properties:[]}

Filter properties to keep only the desired ones. This function acts on the [virtual block format](#get) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to keep.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `shape`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There’s no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Keep only the facing and shape properties:*

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

Merge state properties from the current location into the output. The merge occurs if the syntax is correct, regardless of logical coherence (e.g., using 'age' for different plants). This function acts on the [virtual block format](#get) stored in the block output.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Location of the block that act as input.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to merge.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `shape`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There’s no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Merge the facing of a block onto stairs:*

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

Filter properties by removing the undesired ones. This function acts on the [virtual block format](#get) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to remove.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `shape`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There’s no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Remove the facing and shape properties:*

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

Replace property values. Invalid values will not be replaced. This function acts on the [virtual block format](#get) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to replace.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `facing`).
        - {nbt}`string` **value**: Value of the property (e.g., `east`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There’s no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Replace the facing property value:*

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

Shift properties by any amount, allowing cycling through their values. This function acts on the [virtual block format](#get) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **properties**: List of properties to shift.
      - {nbt}`compound` Property data
        - {nbt}`string` **name**: Name of the property (e.g., `shape`).
        - {nbt}`string` **by**: Shift amount (defaults to 1).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There’s no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Shift the facing property value by 2:*

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

Replace the block type while trying to conserve the state. State is preserved only if the group of the output matches the input. This function acts on the [virtual block format](#get) stored in the block output.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There’s no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get).

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
```

*Replace oak stairs with spruce stairs, preserving the current state:*

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

This function operates on the [virtual block format](#get) stored in the block output. It replaces the type in the output with one that belongs to the same set and better matches the attributes of the inputted type.

For example, with the above mapping registry: if the input is `minecraft:red_wool` (attrs:["red"]), and the virtual block type is `minecraft:green_carpet` (set:"carpet"), the resulting block will be `minecraft:red_carpet` (set:"carpet",attrs:["red"]).

Bookshelf includes two predefined mapping registries (`bs.shapes` and `bs.colors`). If these are insufficient, you can [create your own](#custom-mapping-registry).

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
    - {nbt}`string` **mapping_registry**: A path to the mapping registry used for the replacement (e.g., `bs.shapes`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There’s no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get).

:Outputs:
  **Return**: Whether a type was found and the replacement occurred.

  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
`````

*Replace all oak-related blocks with spruce ones (the function replaces the oak stairs block with a spruce stairs block):*

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

This function operates on the [virtual block format](#get) stored in the block output. It replaces the type in the output with one that belongs to the same set and better matches the attributes of both the output and input types while prioritizing the input type.

For example, with the above mapping registry: if the input is `minecraft:bricks` (attrs:["brick"]), and the virtual block type is `minecraft:stone_stairs` (set:"stairs",attrs:["stone"]), the resulting block will be `minecraft:stone_brick_stairs` (set:"stairs",attrs:["stone","brick"]).

Bookshelf includes two predefined mapping registries (`bs.shapes` and `bs.colors`). If these are insufficient, you can [create your own](#custom-mapping-registry).

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **type**: String representation of the id (e.g., `minecraft:stone`).
    - {nbt}`string` **mapping_registry**: A path to the mapping registry used for the replacement (e.g., `bs.shapes`).
  :::

  **Storage `bs:out block`**: {nbt}`compound` There’s no need for manual specification; rather, employ the relevant functions, such as [`get_block`](#get).

:Outputs:
  **Return**: Whether a type was found and the replacement occurred.

  **Storage `bs:out block`**: {nbt}`compound` The `block`, `state` and `properties` are updated to reflect this change.
`````

*Mix a mossy cobblestone block with bricks resulting in a mossy stone bricks block:*

```mcfunction
# Once (on mossy_cobblestone)
execute positioned ~ ~ ~ run function #bs.block:get_block

# Replace type data
function #bs.block:mix_type { type: "minecraft:bricks", mapping_registry: "bs.shapes" }

# See the result
data get storage bs:out block.block
```

::::
::::{tab-item} Lookup Item

```{function} #bs.block:lookup_item {item:<value>}

Get block data from the given item string id.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **item**: Item string id associated to a block.
  :::

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` Equivalent to the [`#bs.block:get_type`](#get) function.
```

*Get block data for the stone item:*

```mcfunction
# Get block type data
function #bs.block:lookup_item {item:"minecraft:stone"}

# See the result
data get storage bs:out block.block
```

```{important}
Minecraft does not perfectly map between blocks and items. Some items may correspond to multiple blocks, and this function will only return one of them.
```

::::
::::{tab-item} Lookup Type

```{function} #bs.block:lookup_type {type:<value>}

Get block data from the given type string id.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **type**: Type string id associated to a block.
  :::

:Outputs:
  **Storage `bs:out block`**: {nbt}`compound` Equivalent to the [`#bs.block:get_type`](#get) function.
```

*Get block data for the stone type:*

```mcfunction
# Get block type data
function #bs.block:lookup_type {type:"minecraft:stone"}

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

*Check that the block at 0 0 0 matches the block at 0 1 0:*

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

### Set

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
    - {nbt}`string` **mode**: Mode used to set the block [destroy|keep|replace] (default: replace).
  :::

:Outputs:
  **State**: A block is placed in the world.
```

*Place a block of stone at 0 0 0 by destroying the existing one:*

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
    - {nbt}`string` **mode**: Mode used to set the block [destroy|keep|replace] (default: replace).
  :::

:Outputs:
  **State**: A block is placed in the world.
```

*Replace any stairs with oak stairs, preserving the current state:*

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

### Produce

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

*Summon a block display using the block at 0 0 0:*

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

*Summon a falling block using the block at 0 0 0:*

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

*Summon a block display with a hitbox using the block at 0 0 0:*

```mcfunction
# Get block data
execute positioned 0 0 0 run function #bs.block:get_block

# Setup the input
data modify storage bs:in block.spawn_solid_block_display set from storage bs:out block

# Summon the block display
function #bs.block:spawn_solid_block_display
```

::::
::::{tab-item} Block Particle

```{function} #bs.block:emit_block_particle

Emit block particle of the given block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position where the particle will be emitted.

  **Storage `bs:in block.emit_block_particle`**:
  :::{treeview}
  - {nbt}`compound` Block particle data
    - {nbt}`string` **type**: Block type (similar to block output).
    - {nbt}`compound` **properties**: Block properties (similar to block output).
    - {nbt}`string` **delta**: X Y Z coordinates, the motion value of the particle. Similar to the /particle command.
    - {nbt}`int` **speed**: Speed of the particle. Similar to the /particle command.
    - {nbt}`int` **count**: Number of particle. Similar to the /particle command.
  :::

:Outputs:
  **State**: The particle is emitted.
```

*Emit the particle of the block at 0 0 0:*

```mcfunction
# Get block data
execute positioned 0 0 0 run function #bs.block:get_block

# Setup the input
data modify storage bs:in block.emit_block_particle set from storage bs:out block
data modify storage bs:in block.emit_block_particle merge value { delta: "0 0 0", speed: 5, count: 30 }

# Emit the block particle
function #bs.block:emit_block_particle
```

::::
::::{tab-item} Block Sound

```{function} #bs.block:play_block_sound

Play a block sound of the given block.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position where the sound will be played.

  **Storage `bs:in block.play_block_sound`**:
  :::{treeview}
  - {nbt}`compound` Block sound data
    - {nbt}`string` **sound**: The sound to play. Usually took from the `sounds` property of the virtual block (cf get functions).
    - {nbt}`string` **source**: The source of the sound. Similar to the /playsound command.
    - {nbt}`string` **targets**: The targets of the sound. Similar to the /playsound command.
    - {nbt}`string` **pos**: X Y Z coordinates, the position of the sound. Similar to the /playsound command.
    - {nbt}`int` **volume**: Volume of the sound. Similar to the /playsound command.
    - {nbt}`int` **pitch**: Pitch of the sound. Similar to the /playsound command.
    - {nbt}`int` **min_volume**: Minimum volume of the sound. Similar to the /playsound command.
  :::

:Outputs:
  **State**: The sound is played.
```

*Play the sound of the block at 0 0 0:*

```mcfunction
# Get block data
execute positioned 0 0 0 run function #bs.block:get_block

# Setup the input
data modify storage bs:in block.play_block_sound set value { source: "block", targets: "@s", pos: "~ ~ ~", volume: 1, pitch: 1, min_volume: 0 }
data modify storage bs:in block.play_block_sound.sound set from storage bs:out block.sounds.break

# Play the block sound
function #bs.block:play_block_sound
```

::::
:::::

> **Credits**: Aksiome, theogiraudet

---

(custom-mapping-registry)=
## 🎓 Custom Mapping Registry

This module allows you to create a personalized mapping registry tailored to your specific needs.

---

To create a new registry, you need to define an array within the `bs:const block.mapping_registry` storage. Each new registry should be namespaced, and each element must include `set`, `attrs`, and `type`. Here’s how you can define a new mapping registry:

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
