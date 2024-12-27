# ➡️ Vector

**`#bs.vector:help`**

Vectors are fundamental and incredibly powerful tools to manage motions, forces and.. well... do physics!

```{image} /_imgs/modules/vector-light.png
:align: center
:class: only-light
```

```{image} /_imgs/modules/vector-dark.png
:align: center
:class: only-dark
```


```{button-link} https://www.youtube.com/watch?v=IzASD7R80vQ
:color: primary
:shadow:
:align: center

{octicon}`device-camera-video` Watch a demo
```

```{epigraph}

"With vectors, physics has found a magnificent language."

-- Richard Feynman
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Absolute Max

```{function} #bs.vector:abs_max

Get the number furthest to zero, regardless of sign.

:Inputs:
  **Scores `$vector.abs_max.[0,1,2] bs.in`**: Vector components.

:Outputs:
  **Return | Score `$vector.abs_max bs.out`**: Component with the value furthest from 0.
```

I want to get the max component of the vector (1000, 2000, 3000):

```mcfunction
# Define the vector
scoreboard players set $vector.abs_max.0 bs.in 1000
scoreboard players set $vector.abs_max.1 bs.in 2000
scoreboard players set $vector.abs_max.2 bs.in 3000

# Get the max component
function #bs.vector:abs_max

# Display the result
tellraw @a [{"text":" Max component: ","color":"dark_gray"},{"score":{"name":"$vector.abs_max","objective":"bs.out"},"color":"gold"}]
```

> **Credits**: Aksiome, Leirof

---

### Absolute Min

```{function} #bs.vector:abs_min

Get the number closest to zero, regardless of sign.

:Inputs:
  **Scores `$vector.abs_min.[0,1,2] bs.in`**: Vector components.

:Outputs:
  **Return | Score `$vector.abs_min bs.out`**: Component with the value closest to 0.
```

I want to get the min component of the vector (1000, 2000, 3000):

```mcfunction
# Define the vector
scoreboard players set $vector.abs_min.0 bs.in 1000
scoreboard players set $vector.abs_min.1 bs.in 2000
scoreboard players set $vector.abs_min.2 bs.in 3000

# Get the min component
function #bs.vector:abs_min

# Display the result
tellraw @a [{"text":" Min component: ","color":"dark_gray"},{"score":{"name":"$vector.abs_min","objective":"bs.out"},"color":"gold"}]
```

> **Credits**: Aksiome

---

### Basis Rotation 3D

```{function} #bs.vector:basis_rot_3d {scaling:<value>}

Get the equivalent of the vector passed in parameter in a base with a different rotation. Useful to convert absolute/relative positions into local positions.

:Inputs:
  **Scores `$vector.basis_rot_3d.pos.[0,1,2] bs.in`**: Vector coordinates $=(X,Y,Z)$ in the starting base.

  **Scores `$vector.basis_rot_3d.rot.[0,1] bs.in`**: Horizontal angle $=\phi$ (along $=\hat{y}$) and vertical angle $=\theta$ (along $=\hat{\phi}$) rotation (in degree) from the starting base.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scaling**: Scalar for the function’s input and output.
  :::

:Outputs:
  **Scores `$vector.basis_rot_3d.[0,1,2] bs.out`**: Vector coordinates $=(X',Y',Z')$ in the target base.
```

```{admonition} Basis System
:class: info

This system uses the Minecraft coordinate system. Thus:
- $\hat{y}$ is the vertical axis.
- $\phi=0$ (starting point of the horizontal angle) is along the $\hat{z}$ axis.
- $\theta=0$ (starting point of the vertical angle) is on the horizontal plane.
```

*A block is in ~2 ~5 ~10 from me, I want to have this position in local coordinate (^? ^? ^?):*

```mcfunction
# One time

# Relative coordinates (we multiply by 1000 to have more precision on the result, which will also be multiplied by 1000)
scoreboard players set $vector.basis_rot_3d.pos.0 bs.in 2000
scoreboard players set $vector.basis_rot_3d.pos.1 bs.in 5000
scoreboard players set $vector.basis_rot_3d.pos.2 bs.in 10000

# Difference between my rotation (= that of the coondata grid ^X ^Y ^Z) and the rotation of the Minecraft blocks grid (~X ~Y ~Z)
function #bs.position:get_rot {scale:1000}
scoreboard players operation $vector.basis_rot_3d.rot.0 bs.in = @s bs.rot.h
scoreboard players operation $vector.basis_rot_3d.rot.1 bs.in = @s bs.rot.v

# Perform the basic rotation
function #bs.vector:basis_rot_3d {scaling:1000}

# See the result
tellraw @a [{"text": "X = ", "color": "dark_gray"},{"score":{"name":"$vector.basis_rot_3d.0", "objective": "bs.out"}, "color": "gold"},{"text":", Y = ", "color": "dark_gray"},{"score":{"name":"$vector.basis_rot_3d.1", "objective": "bs.out"},"color":"gold"},{"text":", Z = ","color":"dark_gray"},{"score":{"name":"$vector.basis_rot_3d.2","objective":"bs.out"},"color":"gold"}]
```

*I want to have a vector pointing to where I'm looking at, but in relative coordinates ~X ~Y ~Z:*

```mcfunction
# Once

# Retrieve a vector ^ ^ ^1 corresponding to a vector directed according to the orientation of the entity (we multiply by 1000 to have more precision on the result, which will also be multiplied by 1000)
scoreboard players set $vector.basis_rot_3d.pos.0 bs.in 0
scoreboard players set $vector.basis_rot_3d.pos.1 bs.in 0
scoreboard players set $vector.basis_rot_3d.pos.2 bs.in 1000

# Get the orientation
function #bs.position:get_rot {scale:1000}
scoreboard players operation $vector.basis_rot_3d.rot.0 bs.in = @s bs.rot.h
scoreboard players operation $vector.basis_rot_3d.rot.1 bs.in = @s bs.rot.v

# Reversal of the orientation since we want to have the relative orientation of the game grid compared to the orientation of the player (unlike the previous example)
scoreboard players operation $vector.basis_rot_3d.rot.0 bs.in *= -1 bs.const
scoreboard players operation $vector.basis_rot_3d.rot.1 bs.in *= -1 bs.const

# Perform the basic rotation
function #bs.vector:basis_rot_3d {scaling:1000}

# See the result
tellraw @a [{"text": "X = ", "color": "dark_gray"},{"score":{"name":"$vector.basis_rot_3d.0", "objective": "bs.out"}, "color": "gold"},{"text":", Y = ", "color": "dark_gray"},{"score":{"name":"$vector.basis_rot_3d.1", "objective": "bs.out"},"color":"gold"},{"text":", Z = ","color":"dark_gray"},{"score":{"name":"$vector.basis_rot_3d.2","objective":"bs.out"},"color":"gold"}]
```

> **Credits**: Aksiome, Leirof

---

### Cartesian to Spherical

```{function} #bs.vector:cartesian_to_spherical {scaling:<value>}

Convert cartesian coordinates to spherical coordinates.

:Inputs:
  **Scores `$vector.cartesian_to_spherical.[0,1,2] bs.in`**: Vector representing the cartesian coordinates $=(X,Y,Z)$.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scaling**: Scalar for the function’s input and output.
  :::

:Outputs:
  **Scores `$vector.cartesian_to_spherical.[0,1,2] bs.out`**: Vector representing the spherical coordinates $=(H,V,R)$.
```

```{admonition} Spherical Coordinates
:class: warning

This system returns non conventional [spherical coordinates](https://en.wikipedia.org/wiki/Spherical_coordinate_system).
- $H$ (horizontal angle) is along the $\hat{z}$ axis.
- $V$ (vertical angle) is on the horizontal plane.
- $R$ is the radial distance.
```

I want to convert the vector (1000, 2000, 3000) to spherical coordinates:

```mcfunction
# Define the vector
scoreboard players set $vector.cartesian_to_spherical.0 bs.in 1000
scoreboard players set $vector.cartesian_to_spherical.1 bs.in 2000
scoreboard players set $vector.cartesian_to_spherical.2 bs.in 3000

# Perform the conversion
function #bs.vector:cartesian_to_spherical {scaling:1000}

# Display the result
tellraw @a [{"text":"Spherical coordinates: ","color":"dark_gray"},{"score":{"name":"$vector.cartesian_to_spherical.0","objective":"bs.out"},"color":"gold"},{"text":"°, ","color":"gold"},{"score":{"name":"$vector.cartesian_to_spherical.1","objective":"bs.out"},"color":"gold"},{"text":"°, ","color":"gold"},{"score":{"name":"$vector.cartesian_to_spherical.2","objective":"bs.out"},"color":"gold"}]
```

> **Credits**: Aksiome

---

### Cross Product

```{function} #bs.vector:cross_product {scaling:<value>}

Compute the vector product between $u$ and $v$.

:Inputs:
  **Scores `$vector.cross_product.u.[0,1,2] bs.in`**: First vector components.

  **Scores `$vector.cross_product.v.[0,1,2] bs.in`**: Second vector components.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scaling**: Scalar for the function’s input and output.
  :::

:Outputs:
  **Scores `$vector.cross_product.[0,1,2] bs.out`**: Result of the operation $=u \times v$.
```

I want to perform $u \times v$ with $u=(1,2,3)$ and $v=(4,5,6)$:

```mcfunction
# Define the vectors
scoreboard players set $vector.cross_product.u.0 bs.in 100
scoreboard players set $vector.cross_product.u.1 bs.in 200
scoreboard players set $vector.cross_product.u.2 bs.in 300

scoreboard players set $vector.cross_product.v.0 bs.in 400
scoreboard players set $vector.cross_product.v.1 bs.in 500
scoreboard players set $vector.cross_product.v.2 bs.in 600

# Perform the operation
function #bs.vector:cross_product {scaling:100}

# Display the result
tellraw @a [{"text":"Cross product: ","color":"dark_gray"},{"score":{"name":"$vector.cross_product.0","objective":"bs.out"},"color":"gold"},{"text":", ","color":"gold"},{"score":{"name":"$vector.cross_product.1","objective":"bs.out"},"color":"gold"},{"text":", ","color":"gold"},{"score":{"name":"$vector.cross_product.2","objective":"bs.out"},"color":"gold"}]
```

> **Credits**: Aksiome, Majoras16

---

### Dot Product

```{function} #bs.vector:dot_product {scaling:<value>}

Compute the scalar product between $u$ and $v$.

:Inputs:
  **Scores `$vector.dot_product.u.[0,1,2] bs.in`**: First vector components.

  **Scores `$vector.dot_product.v.[0,1,2] bs.in`**: Second vector components.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scaling**: Scalar for the function’s input and output.
  :::

:Outputs:
  **Scores `$vector.dot_product bs.out`**: Result of the operation $=u · v$.
```

I want to perform $u \cdot v$ with $u=(1,2,3)$ and $v=(4,5,6)$:

```mcfunction
# Define the vectors
scoreboard players set $vector.dot_product.u.0 bs.in 100
scoreboard players set $vector.dot_product.u.1 bs.in 200
scoreboard players set $vector.dot_product.u.2 bs.in 300

scoreboard players set $vector.dot_product.v.0 bs.in 400
scoreboard players set $vector.dot_product.v.1 bs.in 500
scoreboard players set $vector.dot_product.v.2 bs.in 600

# Perform the operation
function #bs.vector:dot_product {scaling:100}

# Display the result
tellraw @a [{"text":"Dot product: ","color":"dark_gray"},{"score":{"name":"$vector.dot_product","objective":"bs.out"},"color":"gold"}]
```

> **Credits**: Aksiome, Majoras16

---

### Length

:::::{tab-set}
::::{tab-item} Length

```{function} #bs.vector:length

Compute the norm of the vector.

:Inputs:
  **Scores `$vector.length.[0,1,2] bs.in`**: Vector components.

:Outputs:
  **Return | Score `$vector.length bs.out`**: Vector length.
```

*Compute the length of a vector:*

```mcfunction
scoreboard players set $vector.length.0 bs.in 1000
scoreboard players set $vector.length.1 bs.in 2000
scoreboard players set $vector.length.2 bs.in 3000

function #bs.vector:length

# Display the result
tellraw @a [{"text":" Vector length: ","color":"dark_gray"},{"score":{"name":"$vector.length","objective":"bs.out"}}]
```

```{admonition} Performance Tip
:class: tip

If you want to minimize the performance impact, we recomande you to use the `length_squared` function instead of this one when it's possible. In fact, computing the length of a vector requires to perform square root operation which is not a simple task for a computer, especially in Minecraft.

`length_squared` can often be used in the following cases:
- You want to compare the length with a given one, then compute manually the square of the given value and compare it with the result of `length_squared`, which is faster than computing the real length.
- You want to compare a vector length with another one, then you can compare the result of `length_squared` instead of computing the real length of both vectors.
```

::::
::::{tab-item} Length Squared

```{function} #bs.vector:length_squared {scaling:<value>}

Compute the squared norm of the vector.

:Inputs:
  **Scores `$vector.length_squared.[0,1,2] bs.in`**: Vector components.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scaling**: Scalar for the function’s input and output.
  :::

:Outputs:
  **Return | Score `$vector.length_squared bs.out`**: Vector length squared.
```

*Compute the squared length of a vector:*

```mcfunction
scoreboard players set $vector.length_squared.0 bs.in 1000
scoreboard players set $vector.length_squared.1 bs.in 2000
scoreboard players set $vector.length_squared.2 bs.in 3000

function #bs.vector:length_squared

# Display the result
tellraw @a [{"text":" Vector length squared: ","color":"dark_gray"},{"score":{"name":"$vector.length_squared","objective":"bs.out"}}]
```

::::
:::::

> **Credits**: Aksiome, Leirof

---

### Normalize

:::::{tab-set}
::::{tab-item} Norm

```{function} #bs.vector:normalize {scale:<scaling>}

Normalize the vector by putting the length at the given scale while keeping proportions.

:Inputs:
  **Scores `$vector.normalize.[0,1,2] bs.in`**: Vector components.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Scores `$vector.normalize.[0,1,2] bs.out`**: Normalized vector components.
```

```{admonition} Performance Tip
:class: tip

A vector doesn’t always need to be normalized by its length. Often, the `normalize_max_component` function can be used instead. While this method doesn’t normalize the length, it simplifies some operations and enhances performance.
```

*Normalize the vector (1000, 2000, 3000) with a scale of 1000:*

```mcfunction
# Define the vector
scoreboard players set $vector.normalize.0 bs.in 1000
scoreboard players set $vector.normalize.1 bs.in 2000
scoreboard players set $vector.normalize.2 bs.in 3000

# Perform the normalization
function #bs.vector:normalize {scale:1000}

# Display the result
tellraw @a [{"text":"Normalized vector: ","color":"dark_gray"},{"score":{"name":"$vector.normalize.0","objective":"bs.out"},"color":"gold"},{"text":", ","color":"gold"},{"score":{"name":"$vector.normalize.1","objective":"bs.out"},"color":"gold"},{"text":", ","color":"gold"},{"score":{"name":"$vector.normalize.2","objective":"bs.out"},"color":"gold"}]
```

::::
::::{tab-item} Max Component

```{function} #bs.vector:normalize_max_component {scale:<scaling>}

Normalize the vector by placing the largest component at the given scale while keeping proportions.

:Inputs:
  **Scores `$vector.normalize_max_component.[0,1,2] bs.in`**: Vector components.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Scores `$vector.normalize_max_component.[0,1,2] bs.out`**: Normalized vector components.

  **Score `$vector.normalize_max_component.factor bs.out`**: Normalization factor.
```

*Fast normalize the vector (1000, 2000, 3000) with a scale of 1000:*

```mcfunction
# Define the vector
scoreboard players set $vector.fast_normalize.0 bs.in 1000
scoreboard players set $vector.fast_normalize.1 bs.in 2000
scoreboard players set $vector.fast_normalize.2 bs.in 3000

# Perform the fast normalization
function #bs.vector:fast_normalize {scale:1000}

# Display the result
tellraw @a [{"text":"Normalized vector: ","color":"dark_gray"},{"score":{"name":"$vector.fast_normalize.0","objective":"bs.out"},"color":"gold"},{"text":", ","color":"gold"},{"score":{"name":"$vector.fast_normalize.1","objective":"bs.out"},"color":"gold"},{"text":", ","color":"gold"},{"score":{"name":"$vector.fast_normalize.2","objective":"bs.out"},"color":"gold"}]
```

::::
:::::

> **Credits**: Aksiome, Leirof

---

### Spherical to Cartesian

```{function} #bs.vector:spherical_to_cartesian {scaling:<value>}

Convert spherical coordinates to cartesian coordinates.

:Inputs:
  **Scores `$vector.spherical_to_cartesian.[0,1,2] bs.in`**: Vector representing the spherical coordinates $=(H,V,R)$.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scaling**: Scalar for the function’s input and output.
  :::

:Outputs:
  **Scores `$vector.spherical_to_cartesian.[0,1,2] bs.out`**: Vector representing the cartesian coordinates $=(X,Y,Z)$.
```

```{admonition} Spherical Coordinates
:class: warning

This system uses non conventional [spherical coordinates](https://en.wikipedia.org/wiki/Spherical_coordinate_system).
- $H$ (horizontal angle) is along the $\hat{z}$ axis.
- $V$ (vertical angle) is on the horizontal plane.
- $R$ is the radial distance.
```

I want to convert the spherical coordinates $(45°, 30°, 1)$ to cartesian coordinates:

```mcfunction
# Define the spherical coordinates
scoreboard players set $vector.spherical_to_cartesian.0 bs.in 45000
scoreboard players set $vector.spherical_to_cartesian.1 bs.in 30000
scoreboard players set $vector.spherical_to_cartesian.2 bs.in 1000

# Perform the conversion
function #bs.vector:spherical_to_cartesian {scaling:1000}

# Display the result
tellraw @a [{"text":"Cartesian coordinates: ","color":"dark_gray"},{"score":{"name":"$vector.spherical_to_cartesian.0","objective":"bs.out"},"color":"gold"},{"text":", ","color":"gold"},{"score":{"name":"$vector.spherical_to_cartesian.1","objective":"bs.out"},"color":"gold"},{"text":", ","color":"gold"},{"score":{"name":"$vector.spherical_to_cartesian.2","objective":"bs.out"},"color":"gold"}]
```

> **Credits**: Aksiome

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
