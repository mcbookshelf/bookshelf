# 🏗️ Generation

**`#bs.generation:help`**

Run a command over every position in a shaped region, spread across ticks.

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

---

## Functions

The following functions are available in this module.

---

```{admonition} Command limit
:class: warning

By default, a tick that runs more than 65536 commands is stopped, and its generations are lost. If that happens, lower `batch` or raise the `max_command_sequence_length` gamerule.
```

### On cuboid

:::::{tab-set}
::::{tab-item} XYZ

```{feature} bs.generation:on_cuboid/xyz
```

*Example: fill a cube of 5 blocks with stone, along x, then y, then z*

```mcfunction
# Once
function #bs.generation:on_cuboid/xyz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[5,5,5],with:{}}
```

::::
::::{tab-item} XZY

```{feature} bs.generation:on_cuboid/xzy
```

*Example: fill a cube of 5 blocks with stone, along x, then z, then y*

```mcfunction
# Once
function #bs.generation:on_cuboid/xzy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[5,5,5],with:{}}
```

::::
::::{tab-item} YXZ

```{feature} bs.generation:on_cuboid/yxz
```

*Example: fill a cube of 5 blocks with stone, along y, then x, then z*

```mcfunction
# Once
function #bs.generation:on_cuboid/yxz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[5,5,5],with:{}}
```

::::
::::{tab-item} YZX

```{feature} bs.generation:on_cuboid/yzx
```

*Example: fill a cube of 5 blocks with stone, along y, then z, then x*

```mcfunction
# Once
function #bs.generation:on_cuboid/yzx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[5,5,5],with:{}}
```

::::
::::{tab-item} ZXY

```{feature} bs.generation:on_cuboid/zxy
```

*Example: fill a cube of 5 blocks with stone, along z, then x, then y*

```mcfunction
# Once
function #bs.generation:on_cuboid/zxy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[5,5,5],with:{}}
```

::::
::::{tab-item} ZYX

```{feature} bs.generation:on_cuboid/zyx
```

*Example: fill a cube of 5 blocks with stone, along z, then y, then x*

```mcfunction
# Once
function #bs.generation:on_cuboid/zyx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[5,5,5],with:{}}
```

::::
:::::

---

### On cuboid outline

:::::{tab-set}
::::{tab-item} XYZ

````{feature} bs.generation:on_cuboid_outline/xyz
```{admonition} Layer by layer along z
:class: note

All the positions with the same z are done before the next z. Among them, the order is not set.
```
````

*Example: build the walls, the floor and the roof of a glass cube of 5 blocks, layer by layer along z*

```mcfunction
# Once
function #bs.generation:on_cuboid_outline/xyz.in {run:"setblock ~ ~ ~ minecraft:glass",size:[5,5,5],with:{}}
```

::::
::::{tab-item} XZY

````{feature} bs.generation:on_cuboid_outline/xzy
```{admonition} Layer by layer along y
:class: note

All the positions with the same y are done before the next y. Among them, the order is not set.
```
````

*Example: build the walls, the floor and the roof of a glass cube of 5 blocks, layer by layer along y*

```mcfunction
# Once
function #bs.generation:on_cuboid_outline/xzy.in {run:"setblock ~ ~ ~ minecraft:glass",size:[5,5,5],with:{}}
```

::::
::::{tab-item} YXZ

````{feature} bs.generation:on_cuboid_outline/yxz
```{admonition} Layer by layer along z
:class: note

All the positions with the same z are done before the next z. Among them, the order is not set.
```
````

*Example: build the walls, the floor and the roof of a glass cube of 5 blocks, layer by layer along z*

```mcfunction
# Once
function #bs.generation:on_cuboid_outline/yxz.in {run:"setblock ~ ~ ~ minecraft:glass",size:[5,5,5],with:{}}
```

::::
::::{tab-item} YZX

````{feature} bs.generation:on_cuboid_outline/yzx
```{admonition} Layer by layer along x
:class: note

All the positions with the same x are done before the next x. Among them, the order is not set.
```
````

*Example: build the walls, the floor and the roof of a glass cube of 5 blocks, layer by layer along x*

```mcfunction
# Once
function #bs.generation:on_cuboid_outline/yzx.in {run:"setblock ~ ~ ~ minecraft:glass",size:[5,5,5],with:{}}
```

::::
::::{tab-item} ZXY

````{feature} bs.generation:on_cuboid_outline/zxy
```{admonition} Layer by layer along y
:class: note

All the positions with the same y are done before the next y. Among them, the order is not set.
```
````

*Example: build the walls, the floor and the roof of a glass cube of 5 blocks, layer by layer along y*

```mcfunction
# Once
function #bs.generation:on_cuboid_outline/zxy.in {run:"setblock ~ ~ ~ minecraft:glass",size:[5,5,5],with:{}}
```

::::
::::{tab-item} ZYX

````{feature} bs.generation:on_cuboid_outline/zyx
```{admonition} Layer by layer along x
:class: note

All the positions with the same x are done before the next x. Among them, the order is not set.
```
````

*Example: build the walls, the floor and the roof of a glass cube of 5 blocks, layer by layer along x*

```mcfunction
# Once
function #bs.generation:on_cuboid_outline/zyx.in {run:"setblock ~ ~ ~ minecraft:glass",size:[5,5,5],with:{}}
```

::::
:::::

---

### On ellipse

:::::{tab-set}
::::{tab-item} XY

```{feature} bs.generation:on_ellipse/xy
```

*Example: build a stone disc of 9 blocks, flat on x and y, along x, then y*

```mcfunction
# Once
function #bs.generation:on_ellipse/xy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} XZ

```{feature} bs.generation:on_ellipse/xz
```

*Example: build a stone disc of 9 blocks, flat on x and z, along x, then z*

```mcfunction
# Once
function #bs.generation:on_ellipse/xz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} YX

```{feature} bs.generation:on_ellipse/yx
```

*Example: build a stone disc of 9 blocks, flat on y and x, along y, then x*

```mcfunction
# Once
function #bs.generation:on_ellipse/yx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} YZ

```{feature} bs.generation:on_ellipse/yz
```

*Example: build a stone disc of 9 blocks, flat on y and z, along y, then z*

```mcfunction
# Once
function #bs.generation:on_ellipse/yz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} ZX

```{feature} bs.generation:on_ellipse/zx
```

*Example: build a stone disc of 9 blocks, flat on z and x, along z, then x*

```mcfunction
# Once
function #bs.generation:on_ellipse/zx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} ZY

```{feature} bs.generation:on_ellipse/zy
```

*Example: build a stone disc of 9 blocks, flat on z and y, along z, then y*

```mcfunction
# Once
function #bs.generation:on_ellipse/zy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
:::::

---

### On ellipse outline

:::::{tab-set}
::::{tab-item} XY

```{feature} bs.generation:on_ellipse_outline/xy
```

*Example: build a stone ring of 9 blocks, flat on x and y, along x, then y*

```mcfunction
# Once
function #bs.generation:on_ellipse_outline/xy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} XZ

```{feature} bs.generation:on_ellipse_outline/xz
```

*Example: build a stone ring of 9 blocks, flat on x and z, along x, then z*

```mcfunction
# Once
function #bs.generation:on_ellipse_outline/xz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} YX

```{feature} bs.generation:on_ellipse_outline/yx
```

*Example: build a stone ring of 9 blocks, flat on y and x, along y, then x*

```mcfunction
# Once
function #bs.generation:on_ellipse_outline/yx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} YZ

```{feature} bs.generation:on_ellipse_outline/yz
```

*Example: build a stone ring of 9 blocks, flat on y and z, along y, then z*

```mcfunction
# Once
function #bs.generation:on_ellipse_outline/yz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} ZX

```{feature} bs.generation:on_ellipse_outline/zx
```

*Example: build a stone ring of 9 blocks, flat on z and x, along z, then x*

```mcfunction
# Once
function #bs.generation:on_ellipse_outline/zx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
::::{tab-item} ZY

```{feature} bs.generation:on_ellipse_outline/zy
```

*Example: build a stone ring of 9 blocks, flat on z and y, along z, then y*

```mcfunction
# Once
function #bs.generation:on_ellipse_outline/zy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9],with:{}}
```

::::
:::::

---

### On ellipsoid

:::::{tab-set}
::::{tab-item} XYZ

```{feature} bs.generation:on_ellipsoid/xyz
```

*Example: build a stone sphere of 9 blocks, along x, then y, then z*

```mcfunction
# Once
function #bs.generation:on_ellipsoid/xyz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} XZY

```{feature} bs.generation:on_ellipsoid/xzy
```

*Example: build a stone sphere of 9 blocks, along x, then z, then y*

```mcfunction
# Once
function #bs.generation:on_ellipsoid/xzy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} YXZ

```{feature} bs.generation:on_ellipsoid/yxz
```

*Example: build a stone sphere of 9 blocks, along y, then x, then z*

```mcfunction
# Once
function #bs.generation:on_ellipsoid/yxz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} YZX

```{feature} bs.generation:on_ellipsoid/yzx
```

*Example: build a stone sphere of 9 blocks, along y, then z, then x*

```mcfunction
# Once
function #bs.generation:on_ellipsoid/yzx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} ZXY

```{feature} bs.generation:on_ellipsoid/zxy
```

*Example: build a stone sphere of 9 blocks, along z, then x, then y*

```mcfunction
# Once
function #bs.generation:on_ellipsoid/zxy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} ZYX

```{feature} bs.generation:on_ellipsoid/zyx
```

*Example: build a stone sphere of 9 blocks, along z, then y, then x*

```mcfunction
# Once
function #bs.generation:on_ellipsoid/zyx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
:::::

---

### On ellipsoid outline

:::::{tab-set}
::::{tab-item} XYZ

```{feature} bs.generation:on_ellipsoid_outline/xyz
```

*Example: build a hollow stone sphere of 9 blocks, along x, then y, then z*

```mcfunction
# Once
function #bs.generation:on_ellipsoid_outline/xyz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} XZY

```{feature} bs.generation:on_ellipsoid_outline/xzy
```

*Example: build a hollow stone sphere of 9 blocks, along x, then z, then y*

```mcfunction
# Once
function #bs.generation:on_ellipsoid_outline/xzy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} YXZ

```{feature} bs.generation:on_ellipsoid_outline/yxz
```

*Example: build a hollow stone sphere of 9 blocks, along y, then x, then z*

```mcfunction
# Once
function #bs.generation:on_ellipsoid_outline/yxz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} YZX

```{feature} bs.generation:on_ellipsoid_outline/yzx
```

*Example: build a hollow stone sphere of 9 blocks, along y, then z, then x*

```mcfunction
# Once
function #bs.generation:on_ellipsoid_outline/yzx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} ZXY

```{feature} bs.generation:on_ellipsoid_outline/zxy
```

*Example: build a hollow stone sphere of 9 blocks, along z, then x, then y*

```mcfunction
# Once
function #bs.generation:on_ellipsoid_outline/zxy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
::::{tab-item} ZYX

```{feature} bs.generation:on_ellipsoid_outline/zyx
```

*Example: build a hollow stone sphere of 9 blocks, along z, then y, then x*

```mcfunction
# Once
function #bs.generation:on_ellipsoid_outline/zyx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[9,9,9],with:{}}
```

::::
:::::

---

### On rectangle

:::::{tab-set}
::::{tab-item} XY

```{feature} bs.generation:on_rectangle/xy
```

*Example: fill a rectangle of 8 blocks on x and 4 on y with stone, along x, then y*

```mcfunction
# Once
function #bs.generation:on_rectangle/xy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[8,4],with:{}}
```

::::
::::{tab-item} XZ

```{feature} bs.generation:on_rectangle/xz
```

*Example: fill a rectangle of 8 blocks on x and 4 on z with stone, along x, then z*

```mcfunction
# Once
function #bs.generation:on_rectangle/xz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[8,4],with:{}}
```

::::
::::{tab-item} YX

```{feature} bs.generation:on_rectangle/yx
```

*Example: fill a rectangle of 8 blocks on y and 4 on x with stone, along y, then x*

```mcfunction
# Once
function #bs.generation:on_rectangle/yx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[8,4],with:{}}
```

::::
::::{tab-item} YZ

```{feature} bs.generation:on_rectangle/yz
```

*Example: fill a rectangle of 8 blocks on y and 4 on z with stone, along y, then z*

```mcfunction
# Once
function #bs.generation:on_rectangle/yz.in {run:"setblock ~ ~ ~ minecraft:stone",size:[8,4],with:{}}
```

::::
::::{tab-item} ZX

```{feature} bs.generation:on_rectangle/zx
```

*Example: fill a rectangle of 8 blocks on z and 4 on x with stone, along z, then x*

```mcfunction
# Once
function #bs.generation:on_rectangle/zx.in {run:"setblock ~ ~ ~ minecraft:stone",size:[8,4],with:{}}
```

::::
::::{tab-item} ZY

```{feature} bs.generation:on_rectangle/zy
```

*Example: fill a rectangle of 8 blocks on z and 4 on y with stone, along z, then y*

```mcfunction
# Once
function #bs.generation:on_rectangle/zy.in {run:"setblock ~ ~ ~ minecraft:stone",size:[8,4],with:{}}
```

::::
:::::

---

### On rectangle outline

:::::{tab-set}
::::{tab-item} XY

````{feature} bs.generation:on_rectangle_outline/xy
```{admonition} No set order
:class: note

The order of the positions is not set: the name only tells which axis each number of `size` is for.
```
````

*Example: build the edge of a glass rectangle of 8 blocks on x and 4 on y*

```mcfunction
# Once
function #bs.generation:on_rectangle_outline/xy.in {run:"setblock ~ ~ ~ minecraft:glass",size:[8,4],with:{}}
```

::::
::::{tab-item} XZ

````{feature} bs.generation:on_rectangle_outline/xz
```{admonition} No set order
:class: note

The order of the positions is not set: the name only tells which axis each number of `size` is for.
```
````

*Example: build the edge of a glass rectangle of 8 blocks on x and 4 on z*

```mcfunction
# Once
function #bs.generation:on_rectangle_outline/xz.in {run:"setblock ~ ~ ~ minecraft:glass",size:[8,4],with:{}}
```

::::
::::{tab-item} YX

````{feature} bs.generation:on_rectangle_outline/yx
```{admonition} No set order
:class: note

The order of the positions is not set: the name only tells which axis each number of `size` is for.
```
````

*Example: build the edge of a glass rectangle of 8 blocks on y and 4 on x*

```mcfunction
# Once
function #bs.generation:on_rectangle_outline/yx.in {run:"setblock ~ ~ ~ minecraft:glass",size:[8,4],with:{}}
```

::::
::::{tab-item} YZ

````{feature} bs.generation:on_rectangle_outline/yz
```{admonition} No set order
:class: note

The order of the positions is not set: the name only tells which axis each number of `size` is for.
```
````

*Example: build the edge of a glass rectangle of 8 blocks on y and 4 on z*

```mcfunction
# Once
function #bs.generation:on_rectangle_outline/yz.in {run:"setblock ~ ~ ~ minecraft:glass",size:[8,4],with:{}}
```

::::
::::{tab-item} ZX

````{feature} bs.generation:on_rectangle_outline/zx
```{admonition} No set order
:class: note

The order of the positions is not set: the name only tells which axis each number of `size` is for.
```
````

*Example: build the edge of a glass rectangle of 8 blocks on z and 4 on x*

```mcfunction
# Once
function #bs.generation:on_rectangle_outline/zx.in {run:"setblock ~ ~ ~ minecraft:glass",size:[8,4],with:{}}
```

::::
::::{tab-item} ZY

````{feature} bs.generation:on_rectangle_outline/zy
```{admonition} No set order
:class: note

The order of the positions is not set: the name only tells which axis each number of `size` is for.
```
````

*Example: build the edge of a glass rectangle of 8 blocks on z and 4 on y*

```mcfunction
# Once
function #bs.generation:on_rectangle_outline/zy.in {run:"setblock ~ ~ ~ minecraft:glass",size:[8,4],with:{}}
```

::::
:::::

---

## Integer providers

The following integer providers are available in this module.

---

### Index

:::::{tab-set}
::::{tab-item} I

```{feature} bs.generation:i
```

*Example: only place the first block of each line*

```mcfunction
# Once
data modify storage bs.generation:on_cuboid in set value {run:'execute if predicate {type:"int_value_check",value:"bs.generation:i",test:0} run setblock ~ ~ ~ minecraft:stone',size:[5,5,5]}
function #bs.generation:on_cuboid/xyz
```

::::
::::{tab-item} J

```{feature} bs.generation:j
```

*Example: only place the first line of each layer*

```mcfunction
# Once
data modify storage bs.generation:on_cuboid in set value {run:'execute if predicate {type:"int_value_check",value:"bs.generation:j",test:0} run setblock ~ ~ ~ minecraft:stone',size:[5,5,5]}
function #bs.generation:on_cuboid/xyz
```

::::
::::{tab-item} K

```{feature} bs.generation:k
```

*Example: only place the first layer*

```mcfunction
# Once
data modify storage bs.generation:on_cuboid in set value {run:'execute if predicate {type:"int_value_check",value:"bs.generation:k",test:0} run setblock ~ ~ ~ minecraft:stone',size:[5,5,5]}
function #bs.generation:on_cuboid/xyz
```

::::
:::::

---

```{include} ../_templates/comments.md
```
