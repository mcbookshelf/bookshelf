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

```{admonition} Colors with an alpha
:class: note

An integer that holds an alpha is an ARGB integer, as the game uses for the background of a text display: the alpha is its highest byte. A hexadecimal color holds its alpha last, as in `#rrggbbaa`, a form also called hexa, and an RGBA color too, as in `[r,g,b,a]`.
```

---

## Functions

The following functions are available in this module. A color must be valid: the result of a conversion is undefined otherwise.

---

### Convert to hexadecimal

:::::{tab-set}
::::{tab-item} RGB to hex

```{feature} bs.color:rgb_to_hex
```

*Example: convert an RGB color to a hexadecimal color*

```mcfunction
# Once
function #bs.color:rgb_to_hex.in {color:[0.0,1.0,0.5]}

# See the result
data get storage bs.color:rgb_to_hex out
```

::::
::::{tab-item} Int to hex

```{feature} bs.color:int_to_hex
```

*Example: get the hexadecimal color of the leather helmet of the nearest zombie*

```mcfunction
# Once
data modify storage bs.color:int_to_hex in.color set from entity @n[type=minecraft:zombie] equipment.head.components."minecraft:dyed_color"
function #bs.color:int_to_hex

# See the result
data get storage bs.color:int_to_hex out
```

::::
::::{tab-item} Int to hexa

```{feature} bs.color:int_to_hexa
```

*Example: get the hexadecimal color of the background of the nearest text display*

```mcfunction
# Once
data modify storage bs.color:int_to_hexa in.color set from entity @n[type=minecraft:text_display] background
function #bs.color:int_to_hexa

# See the result
data get storage bs.color:int_to_hexa out
```

::::
:::::

---

### Convert to integer

:::::{tab-set}
::::{tab-item} Hex to int

```{feature} bs.color:hex_to_int
```

*Example: dye the leather helmet of the nearest zombie with a hexadecimal color*

```mcfunction
# Once
summon minecraft:zombie ~ ~ ~ {equipment:{head:{id:"minecraft:leather_helmet",count:1}}}
execute as @n[type=minecraft:zombie] store result entity @s equipment.head.components."minecraft:dyed_color" int 1 run function #bs.color:hex_to_int.in {color:"#ff0000"}
```

::::
::::{tab-item} RGB to int

```{feature} bs.color:rgb_to_int
```

*Example: dye the leather helmet of the nearest zombie with an RGB color*

```mcfunction
# Once
summon minecraft:zombie ~ ~ ~ {equipment:{head:{id:"minecraft:leather_helmet",count:1}}}
execute as @n[type=minecraft:zombie] store result entity @s equipment.head.components."minecraft:dyed_color" int 1 run function #bs.color:rgb_to_int.in {color:[1.0,0.0,0.0]}
```

::::
:::::

---

### Convert to RGB

:::::{tab-set}
::::{tab-item} Hex to RGB

```{feature} bs.color:hex_to_rgb
```

*Example: convert a hexadecimal color to an RGB color*

```mcfunction
# Once
function #bs.color:hex_to_rgb.in {color:"#00ff80"}

# See the result
data get storage bs.color:hex_to_rgb out
```

::::
::::{tab-item} Int to RGB

```{feature} bs.color:int_to_rgb
```

*Example: get the RGB color of the leather helmet of the nearest zombie*

```mcfunction
# Once
data modify storage bs.color:int_to_rgb in.color set from entity @n[type=minecraft:zombie] equipment.head.components."minecraft:dyed_color"
function #bs.color:int_to_rgb

# See the result
data get storage bs.color:int_to_rgb out
```

::::
::::{tab-item} Int to RGBA

```{feature} bs.color:int_to_rgba
```

*Example: get the RGBA color of the background of the nearest text display*

```mcfunction
# Once
data modify storage bs.color:int_to_rgba in.color set from entity @n[type=minecraft:text_display] background
function #bs.color:int_to_rgba

# See the result
data get storage bs.color:int_to_rgba out
```

::::
:::::

---

## Integer providers

The following integer providers are available in this module.

---

### Mix

```{feature} bs.color:mix
```

*Example: get the color halfway between red and blue*

```mcfunction
# Once
data modify storage bs.color:mix in set value {from:16711680,to:255,ratio:0.5f}
data modify storage bs.color:mix out set compute default integer bs.color:mix

# See the result
data get storage bs.color:mix out
```

---

### Mix Oklab

````{feature} bs.color:mix_oklab
```{admonition} Heavier than the simple mix
:class: warning

This provider costs more than `bs.color:mix`. Use it only when you need a better-looking gradient.
```
````

*Example: get the color halfway between red and blue, as the eye sees it*

```mcfunction
# Once
data modify storage bs.color:mix_oklab in set value {from:16711680,to:255,ratio:0.5f}
data modify storage bs.color:mix_oklab out set compute default integer bs.color:mix_oklab

# See the result
data get storage bs.color:mix_oklab out
```

---

```{include} ../_templates/comments.md
```
