# 🏗️ Generation

**`#bs.generation:help`**

Iterate over the world in various shapes, executing callbacks at each position. Processes can spread across multiple ticks to avoid lag.

```{image} /_imgs/modules/generation-light.png
:width: 100%
:class: only-light
```

```{image} /_imgs/modules/generation-dark.png
:width: 100%
:class: only-dark
```

```{pull-quote}
"Nature's beauty is a reflection of the harmony of numbers and patterns."

-- Anonymous
```

```{button-link} https://youtu.be/uDenmF9l8a4
:color: primary
:align: center
:shadow:

{octicon}`device-camera-video` Watch a demo
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### On cuboid

```{function} #bs.generation:on_cuboid

Iterate over a 3D cuboid, executing a callback at each position.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: origin of the shape

  **Storage `bs:in generation.on_cuboid`**:
  :::{treeview}
  - {nbt}`compound` iteration data
    - {nbt}`string` **run**: callback to execute at each step
    - {nbt}`string` **direction**: 3-letter string defining axis iteration order and direction

      `e`/`w` for east/west, `s`/`n` for south/north, and `u`/`d` for up/down (default: `eus`, +x, +y, +z)
    - {nbt}`string` **on_finished**: command executed at the end of the process, at the final block position
    - {nbt}`int` **width**: size along the x axis (default: 1)
    - {nbt}`int` **height**: size along the y axis (default: 1)
    - {nbt}`int` **depth**: size along the z axis (default: 1)
    - {nbt}`int` **spacing**: distance between positions (default: 1)
    - {nbt}`int` **limit**: maximum steps per tick (default: 256)
  :::

:Lambdas:
  **Score `$generation.i bs.lambda`**: first dimension index (0 to size-1, tied to 1st direction letter)

  **Score `$generation.j bs.lambda`**: second dimension index (0 to size-1, tied to 2nd direction letter)

  **Score `$generation.k bs.lambda`**: third dimension index (0 to size-1, tied to 3rd direction letter)

:Outputs:
  **State**: the callback is executed at each position
```

*Example: replace spruce stairs with oak stairs using the [`set_block_type`](#block-callbacks) callback*

```mcfunction
data modify storage bs:in generation.on_cuboid set value { \
  width:5, height:5, depth:5, \
  run:'function #bs.generation:callback/set_block_type {type:"minecraft:oak_stairs",with:{masks:[{block:"minecraft:spruce_stairs"}]}}' \
}
function #bs.generation:on_cuboid
```

> **Credits**: Aksiome

---

### On rectangle

```{function} #bs.generation:on_rectangle

Iterate over a 2D rectangle, executing a callback at each position.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: origin of the shape

  **Storage `bs:in generation.on_rectangle`**:
  :::{treeview}
  - {nbt}`compound` iteration data
    - {nbt}`string` **run**: callback to execute at each step
    - {nbt}`string` **direction**: 2-letter string defining axis iteration order and direction

      `e`/`w` for east/west, `s`/`n` for south/north, and `u`/`d` for up/down (default: `es`, +x, +z).
    - {nbt}`string` **on_finished**: command executed at the end of the process, at the final block position
    - {nbt}`int` **width**: size along the x axis (default: 1)
    - {nbt}`int` **height**: size along the y axis (default: 1)
    - {nbt}`int` **depth**: size along the z axis (default: 1)
    - {nbt}`int` **spacing**: distance between positions (default: 1)
    - {nbt}`int` **limit**: maximum steps per tick (default: 256)
  :::

:Lambdas:
  **Score `$generation.i bs.lambda`**: first dimension index (0 to size-1, tied to 1st direction letter)

  **Score `$generation.j bs.lambda`**: second dimension index (0 to size-1, tied to 2nd direction letter)

:Outputs:
  **State**: the callback is executed at each position
```

*Example: generate terrain using fractal noise*

```{code-block} mcfunction
:force:
# Once
data modify storage bs:in generation.on_rectangle set value { \
  width:64, depth:64, limit: 64, \
  run:'function #bs.generation:callback/fractal_noise_2d {run:"function mypack:generate",with:{}}' \
}
function #bs.generation:on_rectangle

# mypack:generate
execute store result storage bs:ctx y int .01 run scoreboard players add $generation.noise bs.lambda 1000
function mypack:fill with storage bs:ctx

# mypack:fill
$fill ~ ~ ~ ~ ~$(y) ~ stone
```

> **Credits**: Aksiome

---

## ↩️ Callbacks

You can find below all callbacks available in this module.

---

```{admonition} Implementation note
:class: tip

These are not simple callbacks. They hook into internals to inject optimized sub-callbacks. Heavy initialization runs once, then lightweight callbacks handle the actual iteration.
```

### Block callbacks

```{admonition} Dependency
:class: warning

The `set_block_type` and `set_random_block` callbacks require the **bs.block** module to be installed.
```

:::::{tab-set}
::::{tab-item} Set block

```{function} #bs.generation:callback/set_block {block:<value>,with:{}}

Place a specific block at each position.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **block**: block to place (e.g., `minecraft:stone`)
    - {nbt}`compound` **with**: additional settings
      - {nbt}`string` **mode**: placement mode [destroy|keep|replace] (default: `replace`)
      - {nbt}`list` **masks**: list of masks to filter positions (combine as AND)
        - {nbt}`compound` mask entry
          - {nbt}`string` **block**: block to check (e.g., `minecraft:stone`, `#minecraft:logs`)
          - {nbt}`bool` **negate**: invert the condition (default: false)
          - {nbt}`int` **x**: x offset (default: 0)
          - {nbt}`int` **y**: y offset (default: 0)
          - {nbt}`int` **z**: z offset (default: 0)
  :::
```

*Example: fill with stone, replacing only air*

```mcfunction
run:'function #bs.generation:callback/set_block {block:"minecraft:stone",with:{masks:[{block:"minecraft:air"}]}}'
```

::::
::::{tab-item} Set block type

```{function} #bs.generation:callback/set_block_type {type:<value>,with:{}}

Replace block types while preserving states and NBT data.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **type**: block type ID (e.g., `minecraft:oak_stairs`)
    - {nbt}`compound` **with**: additional settings
      - {nbt}`string` **mode**: placement mode [destroy|keep|replace] (default: `replace`)
      - {nbt}`list` **masks**: list of masks to filter positions (combine as AND)
        - {nbt}`compound` mask entry
          - {nbt}`string` **block**: block to check (e.g., `minecraft:stone`, `#minecraft:logs`)
          - {nbt}`bool` **negate**: invert the condition (default: false)
          - {nbt}`int` **x**: x offset (default: 0)
          - {nbt}`int` **y**: y offset (default: 0)
          - {nbt}`int` **z**: z offset (default: 0)
  :::
```

*Example: convert spruce stairs to oak, preserving orientation*

```mcfunction
run:'function #bs.generation:callback/set_block_type {type:"minecraft:oak_stairs",with:{masks:[{block:"minecraft:spruce_stairs"}]}}'
```

::::
::::{tab-item} Set random block

```{function} #bs.generation:callback/set_random_block {blocks:[],with:{}}

Place a randomly selected block from a weighted list.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`list` **blocks**: weighted block list
      - {nbt}`compound` block entry
        - {nbt}`string` **block** | **type**: full block string or type that preserves states
        - {nbt}`int` **weight**: selection weight (default: 1)
    - {nbt}`compound` **with**: additional settings
      - {nbt}`string` **mode**: placement mode [destroy|keep|replace] (default: `replace`)
      - {nbt}`list` **masks**: list of masks to filter positions (combine as AND)
        - {nbt}`compound` mask entry
          - {nbt}`string` **block**: block to check (e.g., `minecraft:stone`, `#minecraft:logs`)
          - {nbt}`bool` **negate**: invert the condition (default: false)
          - {nbt}`int` **x**: x offset (default: 0)
          - {nbt}`int` **y**: y offset (default: 0)
          - {nbt}`int` **z**: z offset (default: 0)
  :::
```

*Example: create a mixed ore vein*

```mcfunction
run:'function #bs.generation:callback/set_random_block { \
  blocks:[{block:"minecraft:stone",weight:10},{block:"minecraft:coal_ore",weight:5},{block:"minecraft:iron_ore",weight:2}], \
  with:{masks:[{block:"minecraft:air",negate:1b}]} \
}'
```

::::
:::::

> **Credits**: Aksiome

---

### Noise callbacks

```{admonition} Dependency
:class: warning

Noise callbacks require the **bs.random** module to be installed.
```

:::::{tab-set}
::::{tab-item} Fractal noise 2D

```{function} #bs.generation:callback/fractal_noise_2d {run:<value>,with:{}}

Compute fractal noise and execute a callback with the noise value. Combines multiple octaves of simplex noise for natural patterns.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: callback to execute with the noise value
    - {nbt}`compound` **with**: noise settings
      - {nbt}`int` **size**: noise granularity, lower = more detail (default: 32)
      - {nbt}`int` **seed**: seed for reproducibility (default: random)
      - {nbt}`int` **octaves**: number of noise layers (default: 2)
      - {nbt}`double` **persistence**: amplitude multiplier per octave (default: 0.5)
      - {nbt}`double` **lacunarity**: frequency multiplier per octave (default: 2.0)
  :::

:Lambdas:
  **Score `$generation.noise bs.lambda`**: noise value in range [-1000, 1000]

  **Score `$generation.i bs.lambda`**: first dimension index (inherited from iterator)

  **Score `$generation.j bs.lambda`**: second dimension index (inherited from iterator)
```

::::
::::{tab-item} Simplex noise 2D

```{function} #bs.generation:callback/simplex_noise_2d {run:<value>,with:{}}

Compute simplex noise and execute a callback with the noise value.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **run**: callback to execute with the noise value
    - {nbt}`compound` **with**: noise settings
      - {nbt}`int` **size**: noise granularity, lower = more detail (default: 32)
      - {nbt}`int` **seed**: seed for reproducibility (default: random)
  :::

:Lambdas:
  **Score `$generation.noise bs.lambda`**: noise value in range [-1000, 1000]

  **Score `$generation.i bs.lambda`**: first dimension index (inherited from iterator)

  **Score `$generation.j bs.lambda`**: second dimension index (inherited from iterator)
```

::::
:::::

> **Credits**: Aksiome

---

```{include} ../_templates/comments.md
```
