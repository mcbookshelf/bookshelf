# 🎨 Color

**`#bs.color:help`**

Facilitate color conversion between various formats.

```{image} /_imgs/modules/color.png
:width: 100%
:class: dark_light
```

```{epigraph}
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
::::{tab-item} RGB to Hexadecimal

```{function} #bs.color:rgb_to_hex {color:[]}

Convert a color from RGB to hexadecimal.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **color**: Vector representing the RGB color (example: [0,255,128]).
  :::

:Outputs:
  **Storage `bs:out color.rgb_to_hex`**: {nbt}`string` Color as an hexadecimal string.
```

*Convert an RGB color to hexadecimal:*

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
  **Storage `bs:out color.int_to_hex`**: {nbt}`string` Color as an hexadecimal string.
```

*Get the hexadecimal color of the nearest zombie's leather helmet:*

```mcfunction
# Get the hexadecimal color
function #bs.color:int_to_hex with entity @e[type=minecraft:zombie,sort=nearest,limit=1] ArmorItems[3].tag.display

# Show the result
data get storage bs:out color.int_to_hex
```

::::
:::::

> **Credits**: Aksiome, theogiraudet

---

### Convert to Integer

:::::{tab-set}
::::{tab-item} Hexadecimal to Integer

```{function} #bs.color:hex_to_int {color:<value>}

Convert a color from hexadecimal to integer.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **color**: Color as an hexadecimal string (example: #ffffff).
  :::

:Outputs:
  **Return | Score `$color.hex_to_int bs.out`**: Color as an integer.

  **Storage `bs:out color.hex_to_int`**: {nbt}`int` Color as an integer.
```

*Change the color of the nearest zombie's leather helmet using the hexadecimal format:*

```mcfunction
# Summon a test subject
summon minecraft:zombie ~ ~ ~ {ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",Count:1b}]}

# Set the helmet color
execute as @e[type=minecraft:zombie,sort=nearest,limit=1] store result entity @s ArmorItems[3].tag.display.color int 1 run function #bs.color:hex_to_int {color:"#ffffff"}
```

::::
::::{tab-item} RGB to Integer

```{function} #bs.color:rgb_to_int {color:[]}

Convert a color from RGB to integer.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`list` **color**: Vector representing the RGB color (example: [0,255,128]).
  :::

:Outputs:
  **Return | Score `$color.rgb_to_int bs.out`**: Color as an integer.

  **Storage `bs:out color.rgb_to_int`**: {nbt}`int` Color as an integer.
```

*Change the color of the nearest zombie's leather helmet using the RGB format:*

```mcfunction
# Summon a test subject
summon minecraft:zombie ~ ~ ~ {ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",Count:1b}]}

# Set the helmet color
execute as @e[type=minecraft:zombie,sort=nearest,limit=1] store result entity @s ArmorItems[3].tag.display.color int 1 run function #bs.color:rgb_to_int {color:[255,0,0]}
```

::::
:::::

> **Credits**: Aksiome, theogiraudet

---

### Convert to RGB

:::::{tab-set}
::::{tab-item} Hexadecimal to RGB

```{function} #bs.color:hex_to_rgb {color:<value>}

Convert a color from hexadecimal to RGB.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **color**: Color as an hexadecimal string (example: #ffffff).
  :::

:Outputs:
  **Storage `bs:out color.hex_to_rgb`**: {nbt}`list` Vector representing the RGB color.

  **Scores `$color.hex_to_rgb.[r,g,b] bs.out`**: Vector components representing the RGB color.
```

*Convert an hexadecimal color to RGB:*

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

*Get the RGB color of the nearest zombie's leather helmet:*

```mcfunction
# Get the RGB color
function #bs.color:int_to_rgb with entity @e[type=minecraft:zombie,sort=nearest,limit=1] ArmorItems[3].tag.display

# Show the result
data get storage bs:out color.int_to_rgb
```

::::
:::::

> **Credits**: Aksiome, theogiraudet

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
