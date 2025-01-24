# 🏗️ Generate

**`#bs.generate:help`**

Generate diverse terrains and landscapes, incorporating natural features.

```{image} /_imgs/modules/generate-light.png
:align: center
:class: only-light
```

```{image} /_imgs/modules/generate-dark.png
:align: center
:class: only-dark
```

```{epigraph}
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

### Shape 2D

:::::{tab-set}
::::{tab-item} Shape 2D

```{function} #bs.generate:shape_2d

Generate a shape in 2D space at the specified origin, with the callback executed at each step, allowing the user to handle the X and Y coordinates directly.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z> rotated <rot>`**: Origin of the shape.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **run**: Callback to run at each step. For each step, the following scores can be used:
      - **`$generate.x bs.data`**: The X coordinate of the current step.
      - **`$generate.y bs.data`**: The Y coordinate of the current step.
    - {nbt}`int` **width**: Width of the shape to generate.
    - {nbt}`int` **height**: Height of the shape to generate.
    - {nbt}`compound` **with**: Shape settings.
      - {nbt}`string` **direction**: Plane used to generate the shape (`xz`, `xy`, or `zy`, default: `xz`).
      - {nbt}`int` **spacing**: Distance between blocks in the generated shape (default: 1).
      - {nbt}`int` **limit**: Limit how many steps are executed in a single tick (default: 256).
  :::

:Outputs:
  **State**: The callback gets executed at the appropriate coordinates in the world.
```

::::
::::{tab-item} Simplex Shape 2D

```{function} #bs.generate:simplex_shape_2d

Generate a shape in 2D space using a Simplex noise algorithm. The shape is generated at the specified origin, with the callback executed at each step to facilitate custom behavior during the generation process.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z> rotated <rot>`**: Origin of the shape.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **run**: Callback to run at each step. For each step, the following scores can be used:
      - **`$random.simplex_noise_2d bs.out`**: The noise value in the range [-1000, 1000].
      - **`$generate.x bs.data`**: The X coordinate of the current step.
      - **`$generate.y bs.data`**: The Y coordinate of the current step.
    - {nbt}`int` **width**: Width of the shape to generate.
    - {nbt}`int` **height**: Height of the shape to generate.
    - {nbt}`compound` **with**: Shape settings.
      - {nbt}`string` **direction**: Plane used to generate the shape (`xz`, `xy` or `zy`, default: `xz`).
      - {nbt}`int` **spacing**: Distance between blocks in the generated shape (default: 1).
      - {nbt}`int` **limit**: Limit how many steps are executed in a single tick (default: 256).
      - {nbt}`int` **size**: Granularity of the noise. Lower values increase detail (default: 32).
      - {nbt}`int` **seed**:  Seed for the noise generation, allowing for reproducibility (default: random).
  :::

:Outputs:
  **State**: The callback gets executed at the appropriate coordinates in the world.
```

::::
::::{tab-item} Fractal Shape 2D

```{function} #bs.generate:fractal_shape_2d

Generate a shape in 2D space using a Fractal noise algorithm. The shape is generated at the specified origin, with the callback executed at each step to facilitate custom behavior during the generation process.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z> rotated <rot>`**: Origin of the shape.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **run**: Callback to run at each step. For each step, the following scores can be used:
      - **`$random.fractal_noise_2d bs.out`**: The noise value in the range [-1000, 1000].
      - **`$generate.x bs.data`**: The X coordinate of the current step.
      - **`$generate.y bs.data`**: The Y coordinate of the current step.
    - {nbt}`int` **width**: Width of the shape to generate.
    - {nbt}`int` **height**: Height of the shape to generate.
    - {nbt}`compound` **with**: Shape settings.
      - {nbt}`string` **direction**: Plane used to generate the shape (`xz`, `xy` or `zy`, default: `xz`).
      - {nbt}`int` **spacing**: Distance between blocks in the generated shape (default: 1).
      - {nbt}`int` **limit**: Limit how many steps are executed in a single tick (default: 256).
      - {nbt}`int` **size**: Granularity of the noise. Lower values increase detail (default: 32).
      - {nbt}`int` **seed**:  Seed for the noise generation, allowing for reproducibility (default: random).
      - {nbt}`int` **octaves**: Number of noise layers; more octaves enhance detail (default: 2).
      - {nbt}`double` **persistence**: Contribution of each octave. Higher means more detail (default: 0.5).
      - {nbt}`double` **lacunarity**: Frequency increase for each octave. Higher means more rapid frequency increase (default: 2.0).
  :::

:Outputs:
  **State**: The callback gets executed at the appropriate coordinates in the world.
```

::::
:::::

*Generate a 3D terrain using a heightmap. This function employs a linear approach; for more interesting terrain, consider scaling the noise values differently according to various ranges. Check out [this video](https://www.youtube.com/watch?v=CSa5O6knuwI) for more insights on terrain generation:*

```{code-block} mcfunction
:force:
# Once
function #bs.generate:fractal_shape_2d {width:64,height:64,run:"function mypack:generate",with:{}}

# mypack:generate
execute store result storage bs:ctx y int .01 run scoreboard players add $random.fractal_noise_2d bs.out 1000
function mypack:fill with storage bs:ctx

# mypack:fill
$fill ~ ~ ~ ~ ~$(y) ~ stone
```

> **Credits**: Aksiome

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
