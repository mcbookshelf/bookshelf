# 🎨 Color

**`#bs.color:help`**

Manipulate colors and convert them between formats.

```{image} /_imgs/modules/color.png
:width: 100%
:class: dark_light
```

```{pull-quote}
"Color helps to express light—not the physical phenomenon, but the only light that really exists, that in the artist's brain."

-- Henri Matisse
```

```{admonition} Minecraft Color Format
:class: info

The internal color format for Minecraft is decimal. This module facilitates the conversion between this integer (decimal) format and other commonly used formats.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Convert to Hexadecimal

:::::{tab-set}
::::{tab-item} RGB(A) to Hexadecimal

```{function} #bs.color:rgb_to_hex {color:[]}

Convert a color from RGB to hexadecimal.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **color**: Vector representing the RGB(A) color (example: [0,255,128] , [0,128,0,100]).
  :::

:Outputs:
  **Storage `bs:out color.rgb_to_hex`**: {nbt}`string` Color as a hexadecimal string.
```

*Example: Convert an RGB color to hexadecimal:*

```mcfunction
# Get the RGB color
function #bs.color:rgb_to_hex {color:[0,255,128]}

# Show the result
data get storage bs:out color.rgb_to_hex
```

::::
::::{tab-item} Integer to Hexadecimal

```{function} #bs.color:int_to_hex {color:<value>}

Convert a color from integer to hexadecimal.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **color**: Color as an integer.
  :::

:Outputs:
  **Storage `bs:out color.int_to_hex`**: {nbt}`string` Color as a hexadecimal string.
```

*Example: Get the hexadecimal color of the nearest zombie's leather helmet:*

```mcfunction
# Get the hexadecimal color
data modify storage macro color set from entity @n[type=minecraft:zombie] equipment.head.components."minecraft:dyed_color"
function #bs.color:int_to_hex with storage macro

# Show the result
data get storage bs:out color.int_to_hex
```

::::
::::{tab-item} RGBA Integer to Hexadecimal

```{function} #bs.color:int_to_hex_rgba {color:<value>}

Convert a rgba color from integer to hexadecimal.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **color**: Color as an rgba integer.
  :::

:Outputs:
  **Storage `bs:out color.int_to_hex_rgba`**: {nbt}`string` Color as a hexadecimal string.
```
*Example: Get the hexadecimal color of the nearest text display background:*

```mcfunction
# Get the hexadecimal color
data modify storage macro color set from entity @n[type=text_display] background
function #bs.color:int_to_hex_rgba with storage macro

# Show the result
data get storage bs:out color.int_to_hex_rgba
```
::::
:::::

> **Credits**: Aksiome, theogiraudet, RacoonJohn

---

### Convert to Integer

:::::{tab-set}
::::{tab-item} Hexadecimal to Integer

```{function} #bs.color:hex_to_int {color:<value>}

Convert a color from RGB(A) hexadecimal to integer.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **color**: Color as a RGBA(A) hexadecimal string (example: #ffffff #00ff00a0).
  :::

:Outputs:
  **Return | Score `$color.hex_to_int bs.out`**: Color as an integer.

  **Storage `bs:out color.hex_to_int`**: {nbt}`int` Color as an integer.
```

*Example: Change the color of the nearest zombie's leather helmet using the hexadecimal format:*

```mcfunction
# Summon a test subject
summon minecraft:zombie ~ ~ ~ {equipment:{chest:{id:"minecraft:leather_helmet",count:1}}}

# Set the helmet color
execute as @n[type=minecraft:zombie] store result entity @s equipment.head.components."minecraft:dyed_color" int 1 run function #bs.color:hex_to_int {color:"#ffffff"}
```

::::
::::{tab-item} RGB(A) to Integer

```{function} #bs.color:rgb_to_int {color:[]}

Convert a color from RGB(A) to integer.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **color**: Vector representing the RGB color (example: [0,255,128], [0,128,0,100]).
  :::

:Outputs:
  **Return | Score `$color.rgb_to_int bs.out`**: Color as an integer.

  **Storage `bs:out color.rgb_to_int`**: {nbt}`int` Color as an integer.
```

*Example: Change the color of the nearest zombie's leather helmet using the RGB format:*

```mcfunction
# Summon a test subject
summon minecraft:zombie ~ ~ ~ {equipment:{chest:{id:"minecraft:leather_helmet",count:1}}}

# Set the helmet color
execute as @n[type=minecraft:zombie] store result entity @s equipment.head.components."minecraft:dyed_color" int 1 run function #bs.color:rgb_to_int {color:[255,0,0]}
```

::::
:::::

> **Credits**: Aksiome, theogiraudet, RacoonJohn

---

### Convert to RGB

:::::{tab-set}
::::{tab-item} Hexadecimal to RGB(A)

```{function} #bs.color:hex_to_rgb {color:<value>}

Convert a color from hexadecimal to RGB(A).

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **color**: Color as a hexadecimal string (example: #ffffff, #00ff00a0).
  :::

:Outputs:
  **Storage `bs:out color.hex_to_rgb`**: {nbt}`list` Vector representing the RGB color.

  **Scores `$color.hex_to_rgb.[r,g,b] bs.out`**: Vector components representing the RGB color.
```

*Example: Convert a hexadecimal color to RGB:*

```mcfunction
# Get the RGB color
function #bs.color:hex_to_rgb {color:"#ffffff"}

# Show the result
data get storage bs:out color.hex_to_rgb
```

::::
::::{tab-item} Integer to RGB

```{function} #bs.color:int_to_rgb {color:<value>}

Convert a color from integer to RGB.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **color**: Color as an integer.
  :::

:Outputs:
  **Storage `bs:out color.int_to_rgb`**: {nbt}`list` Vector representing the RGB color.

  **Scores `$color.int_to_rgb.[r,g,b] bs.out`**: Vector components representing the RGB color.
```

*Example: Get the RGB color of the nearest zombie's leather helmet:*

```mcfunction
# Get the RGB color

data modify storage macro color set from entity @n[type=minecraft:zombie] equipment.head.components."minecraft:dyed_color"
function #bs.color:int_to_rgb with storage macro

# Show the result
data get storage bs:out color.int_to_rgb
```

::::

::::{tab-item} Integer to RGBA

```{function} #bs.color:int_to_rgba {color:<value>}

Convert a color from integer to RGBA.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **color**: Color as an rgba integer.
  :::

:Outputs:
  **Storage `bs:out color.int_to_rgba`**: {nbt}`list` Vector representing the RGBA color.
```

*Example: Get the RGBA color of the nearest text display background:*

```mcfunction
# Get the RGBA color
data modify storage macro color set from entity @n[type=text_display] background
function #bs.color:int_to_rgba with storage macro

# Show the result
data get storage bs:out color.int_to_rgba
```

::::
:::::

> **Credits**: Aksiome, theogiraudet, RacoonJohn

---

```{include} ../_templates/comments.md
```
