# 🧭 Position

**`#bs.position:help`**

Manage entity positions and rotations using scores.

```{image} /_imgs/modules/position.png
:align: center
:class: dark_light p-2
```

```{pull-quote}
"The excitement lies in the exploration of the world around us."

-- Jim Peebles
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Add Position and Rotation

:::::{tab-set}
::::{tab-item} x,y,z

```{function} #bs.position:add_pos {scale:<scaling>}

Add position scores to the entity's coordinates.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Scores `@s bs.pos.[x,y,z]`**: Coordinates to add.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported based on position scores.
```

*Example: Teleport to ~48.85 ~ ~2.29:*

```mcfunction
# Once
scoreboard players set @s bs.pos.x 4885
scoreboard players set @s bs.pos.y 0
scoreboard players set @s bs.pos.z 229
function #bs.position:add_pos {scale:0.001}
```

::::
::::{tab-item} x only

```{function} #bs.position:add_pos_x {scale:<scaling>}

Add the x axis position score to the entity's coordinates.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.pos.x`**: Coordinate x to add.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported based on the x axis position score.
```

*Example: Teleport to ~70 ~ ~:*

```mcfunction
# Once
scoreboard players set @s bs.pos.x 70
function #bs.position:add_pos_x {scale:1}
```

::::
::::{tab-item} y only

```{function} #bs.position:add_pos_y {scale:<scaling>}

Add the y axis position score to the entity's coordinates.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.pos.y`**: Coordinate y to add.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported based on the y axis position score.
```

*Example: Teleport to ~ ~82 ~:*

```mcfunction
# Once
scoreboard players set @s bs.pos.y 82
function #bs.position:add_pos_y {scale:1}
```
::::
::::{tab-item} z only


```{function} #bs.position:add_pos_z {scale:<scaling>}

Add the z axis position score to the entity's coordinates.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.pos.z`**: Coordinate z to add.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported based on the z axis position score.
```

*Example: Teleport to ~ ~ ~65:*

```mcfunction
# Once
scoreboard players set @s bs.pos.z 65
function #bs.position:add_pos_z {scale:1}
```
::::
::::{tab-item} h,v

```{function} #bs.position:add_rot {scale:<scaling>}

Rotate an entity according to its scores.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Scores `@s bs.rot.[h,v]`**: Rotation to add.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported by the rotation indicated by the scores.
```

::::
::::{tab-item} h only


```{function} #bs.position:add_rot_h {scale:<scaling>}

Rotate an entity according to its horizontal rotation score.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.rot.h`**: Rotation to add.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported by the rotation indicated by the horizontal score.
```

::::
::::{tab-item} v only

```{function} #bs.position:add_rot_v {scale:<scaling>}

Rotate an entity according to its vertical rotation score.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.rot.v`**: Rotation to add.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported by the rotation indicated by the vertical score.
```

::::
::::{tab-item} x,y,z,h,v

```{function} #bs.position:add_pos_and_rot {scale:<scaling>}

Add position scores to the entity's coordinates and rotate it according to its rotation score.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport and rotate.

  **Scores `@s bs.pos.[x,y,z]`**: Coordinates to add.

  **Scores `@s bs.rot.[h,v]`**: Rotation to add.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported at the position indicated by the position scores, and rotated according to the rotation scores.
```

::::

:::::


> **Credits**: Aksiome, Leirof


---

### Canonical to Local

```{function} #bs.position:canonical_to_local

Convert a canonical position (using the relative reference frame) into a local position (using the local reference frame).

:Inputs:
  **Execution `rotated as <entity>` or `rotated <h> <v>`**: Rotation used for the conversion.

  **Scores `@s bs.pos.[x,y,z]`**: Position to convert.

:Outputs:
  **Scores `@s bs.pos.[x,y,z]`**: Converted position.
```

```{dropdown} What is a Local Position?
:color: info
:icon: question

Unlike relative position (canonical), this reference frame considers the entity's rotation. Therefore, when the parent entity rotates, the child entity rotates around it. For those familiar with Minecraft commands, local coordinates are available through the `^` symbol.
```

> **Credits**: Aksiome

---

### Get Distance

:::::{tab-set}
::::{tab-item} Normal

```{function} #bs.position:get_distance_ata {scale:<scaling>}

Compute the distance between the source entity and the execution position of the function.

:Inputs:
  **Execution `as <entities>`**: Entity positioned at the reference point.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get the distance from.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Return | Score `$position.get_distance_ata bs.out`**: Distance between the two positions.
```

*Calculate the distance between you and the nearest sheep (in blocks, without scaling):*

```Example: mcfunction
# Once
execute at @e[type=sheep,limit=1,sort=nearest] run function #bs.position:get_distance_ata {scale:1}

# See the result
tellraw @a [{"text": "Distance: ", "color": "dark_gray"},{"score":{"name":"$position.get_distance_ata", "objective": "bs.out"}, "color": "gold"}]
```

```{admonition} Performance Tip
:class: tip

For several applications such as comparing distances, using the squared distance instead of the "normal" distance is more efficient to compute.
```

::::
::::{tab-item} Squared

```{function} #bs.position:get_distance_squared_ata {scale:<scaling>}

Compute the squared distance between the source entity and the execution position of the function.

:Inputs:
  **Execution `as <entities>`**: Entity positioned at the reference point.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get the distance from.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Return | Score `$position.get_distance_squared_ata bs.out`**: Squared distance between the two positions.
```

*Example: Calculate the squared distance between you and the nearest sheep (in blocks, without scaling):*

```mcfunction
# Once
execute at @e[type=sheep,limit=1,sort=nearest] run function #bs.position:get_distance_squared_ata {scale:1}

# See the result
tellraw @a [{"text": "Distance^2: ", "color": "dark_gray"},{"score":{"name":"$position.get_distance_squared_ata", "objective": "bs.out"}, "color": "gold"}]
```

```{admonition} Score Limitation
:class: warning

Scores in Minecraft have a limited size similar to a signed integer variable. While this limit is substantial, it is not unlimited and can overflow. Since this function uses powers of 2 to calculate the result, prefer the "normal" version (which does not rely on powers) when working with large distances.
```

::::
:::::

> **Credits**: Aksiome, Leirof

---

### Get Position and Rotation

:::::{tab-set}
::::{tab-item} x,y,z

```{function} #bs.position:get_pos {scale:<scaling>}

Get the execution position of the function and store the coordinates in 3 scores.

:Inputs:
  **Execution `as <entities>`**: Entity to store the score to.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's outputs.
  :::

:Outputs:
  **Scores `@s bs.pos.[x,y,z]`**: Coordinates of the position.
```

*Example: Detect and display the position of the nearest spider (without scaling):*

```mcfunction
# Once
execute as @e[type=spider,limit=1,sort=nearest] run function #bs.position:get_pos {scale:1}

# See the results
tellraw @a [{"text": "X = ", "color": "dark_gray"},{"score":{"name":"@e[type=spider,limit=1,sort=nearest]", "objective": "bs.pos.x"}, "color": "gold"},{"text":", Y = ", "color": "dark_gray"},{"score":{"name":"@e[type=spider,limit=1,sort=nearest]", "objective": "bs.pos.y"}, "color": "gold"},{"text":", Z = ", "color": "dark_gray"},{"score":{"name":"@e[type=spider,limit=1,sort=nearest]", "objective": "bs.pos.z"}, "color": "gold"}]
```

::::
::::{tab-item} x only

```{function} #bs.position:get_pos_x {scale:<scaling>}

Get the execution x position of the function and store the coordinate in a score.

:Inputs:
  **Execution `as <entities>`**: Entity to store the score to.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Score `@s bs.pos.x`**: Coordinate of the position.
```

*Example: Detect and display the x position of the nearest spider (without scaling):*

```mcfunction
# Once
execute as @e[type=spider,limit=1,sort=nearest] run function #bs.position:get_pos_x {scale:1}

# See the resluts
tellraw @a [{"text": "X = ", "color": "dark_gray"},{"score":{"name":"@e[type=spider,limit=1,sort=nearest]", "objective": "bs.pos.x"}, "color": "gold"}]
```

::::
::::{tab-item} y only

```{function} #bs.position:get_pos_y {scale:<scaling>}

Get the execution y position of the function and store the coordinate in a score.

:Inputs:
  **Execution `as <entities>`**: Entity to store the score to.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Score `@s bs.pos.y`**: Coordinate of the position.
```

*Example: Detect and display the y position of the nearest spider (without scaling):*

```mcfunction
# Once
execute as @e[type=spider,limit=1,sort=nearest] run function #bs.position:get_pos_y {scale:1}

# See the resluts
tellraw @a [{"text": "Y = ", "color": "dark_gray"},{"score":{"name":"@e[type=spider,limit=1,sort=nearest]", "objective": "bs.pos.y"}, "color": "gold"}]
```

::::
::::{tab-item} z only

```{function} #bs.position:get_pos_z {scale:<scaling>}

Get the execution z position of the function and store the coordinate in a score.

:Inputs:
  **Execution `as <entities>`**: Entity to store the score to.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position to get.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Score `@s bs.pos.z`**: Coordinate of the position.
```

*Example: Detect and display the z position of the nearest spider (without scaling):*

```mcfunction
# Once
execute as @e[type=spider,limit=1,sort=nearest] run function #bs.position:get_pos_z {scale:1}

# See the resluts
tellraw @a [{"text": "Z = ", "color": "dark_gray"},{"score":{"name":"@e[type=spider,limit=1,sort=nearest]", "objective": "bs.pos.z"}, "color": "gold"}]
```

::::
::::{tab-item} h,v

```{function} #bs.position:get_rot {scale:<scaling>}

Get the execution rotation of the function and store it in 2 scores.

:Inputs:
  **Execution `as <entities>`**: Entity to store the score to.

  **Execution `at <entity>` or `rotated <h> <v>`**: Rotation to get.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's outputs.
  :::

:Outputs:
  **Scores `@s bs.rot.[h,v]`**: Rotation of the position.
```

::::
::::{tab-item} h only

```{function} #bs.position:get_rot_h {scale:<scaling>}

Get the execution horizontal rotation of the function.

:Inputs:
  **Execution `as <entities>`**: Entity to store the score to.

  **Execution `at <entity>` or `rotated <h> <v>`**: Rotation to get.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Score `@s bs.rot.h`**: Horizontal rotation of the position.
```

::::
::::{tab-item} v only

```{function} #bs.position:get_rot_v {scale:<scaling>}

Get the execution vertical rotation of the function.

:Inputs:
  **Execution `as <entities>`**: Entity to store the score to.

  **Execution `at <entity>` or `rotated <h> <v>`**: Rotation to get.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Score `@s bs.rot.v`**: Vertical rotation of the position.
```

::::
::::{tab-item} x,y,z,h,v

```{function} #bs.position:get_pos_and_rot {scale:<scaling>}

Get the execution position and rotation of the function and store the coordinates and rotation in 5 scores.

:Inputs:
  **Execution `as <entities>`**: Entity to store the score to.

  **Execution `at <entity>` or `positioned <x> <y> <z> rotated <h> <v>`**: Position and rotation to get.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Scores `@s bs.pos.[x,y,z]`**: Coordinates of the position.

  **Scores `@s bs.rot.[h,v]`**: Rotation of the position.
```

::::
:::::

> **Credits**: Aksiome, Leirof, theogiraudet

---

### Get Relative

:::::{tab-set}
::::{tab-item} As to at

```{function} #bs.position:get_relative_ata {scale:<scaling>}

Get the execution position of the function relatively to the position of the executing entity.

:Inputs:
  **Execution `as <entities>`**: Entity considered at the reference point.

  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position te get the relative position from.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's outputs.
  :::

:Outputs:
  **Scores `@s bs.pos.[x,y,z]`**: Relative coordinates.
```

*Example: Get your position relative to the nearest Creeper (without scaling):*

```mcfunction
# Once
execute as @s at @e[type=creeper,limit=1,sort=nearest] run function #bs.position:get_relative_ata {scale:1}

# See the result
tellraw @a [{"text": "Relative position : X=", "color": "dark_gray"},{"score":{"name":"@s", "objective": "bs.pos.x"}, "color": "gold"},{"text":", Y=", "color": "dark_gray"},{"score":{"name":"@s", "objective": "bs.pos.y"},"color":"gold"},{"text":", Z=","color":"dark_gray"},{"score":{"name":"@s","objective":"bs.pos.z"},"color":"gold"}]
```

::::
::::{tab-item} From Direction

```{function} #bs.position:get_relative_from_dir {scale:<scaling>}

Get a direction vector based on the execution position and rotation. Scale is used as the norm/length.

:Inputs:
  **Execution `as <entities>`**: Entity to store the score to.

  **Execution `at <entity>` or `positioned <x> <y> <z> rotated <h> <v>`**: Position and rotation to get the relative position from.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's outputs.
  :::

:Outputs:
  **Scores `@s bs.pos.[x,y,z]`**: Relative coordinates.
```

*Example: Get your position relative to the position that is 2 blocks in front of you (scaled by 1000):*

```mcfunction
# Once
execute at @s run function #bs.position:get_relative_from_dir {scale:2000}

# See the result
tellraw @a [{"text": "Relative position : X=", "color": "dark_gray"},{"score":{"name":"@s", "objective": "bs.pos.x"}, "color": "gold"},{"text":", Y=", "color": "dark_gray"},{"score":{"name":"@s", "objective": "bs.pos.y"},"color":"gold"},{"text":", Z=","color":"dark_gray"},{"score":{"name":"@s","objective":"bs.pos.z"},"color":"gold"}]
```

::::
:::::

> **Credits**: Aksiome, Leirof

---

### Local to Canonical

```{function} #bs.position:local_to_canonical

Convert a local position (using the local reference frame) into a canonical position (using the relative reference frame).

:Inputs:
  **Execution `rotated as <entity>` or `rotated <h> <v>`**: Rotation used for the conversion.

  **Scores `@s bs.pos.[x,y,z]`**: Position to convert.

:Outputs:
  **Scores `@s bs.pos.[x,y,z]`**: Converted position.
```

```{dropdown} What is a Local Position?
:color: info
:icon: question

Unlike relative position (canonical), this reference frame considers the entity's rotation. Therefore, when the parent entity rotates, the child entity rotates around it. For those familiar with Minecraft commands, local coordinates are available through the `^` symbol.
```

> **Credits**: Aksiome

---

### Set Position and Rotation

:::::{tab-set}
::::{tab-item} x,y,z

```{function} #bs.position:set_pos {scale:<scaling>}

Place an entity at coordinates given by scores.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Scores `@s bs.pos.[x,y,z]`**: Coordinates to teleport to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported to the coordinates indicated by the scores.
```

*Example: Teleport to 48.85 0 2.29:*

```mcfunction
# Once
scoreboard players set @s bs.pos.x 4885
scoreboard players set @s bs.pos.y 0
scoreboard players set @s bs.pos.z 229
function #bs.position:set_pos {scale:0.001}
```
::::
::::{tab-item} x only

```{function} #bs.position:set_pos_x {scale:<scaling>}

Place an entity at a precise x coordinate given by scores.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.pos.x`**: Coordinate x to teleport to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported to the x coordinate indicated by the score.
```

*Example: Teleport to 70 ~ ~:*

```mcfunction
# Once
scoreboard players set @s bs.pos.x 70
function #bs.position:set_pos_x {scale:1}
```

::::
::::{tab-item} y only

```{function} #bs.position:set_pos_y {scale:<scaling>}

Place an entity at a precise y coordinate given by scores.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.pos.y`**: Coordinate y to teleport to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported to the y coordinate indicated by the score.
```

*Example: Teleport to ~ 82 ~:*

```mcfunction
# Once
scoreboard players set @s bs.pos.y 82
function #bs.position:set_pos_y {scale:1}
```
::::
::::{tab-item} z only


```{function} #bs.position:set_pos_z {scale:<scaling>}

Place an entity at a precise z coordinate given by scores.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.pos.z`**: Coordinate z to teleport to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported to the z coordinate indicated by the score.
```

*Example: Teleport to ~ ~ 65:*

```mcfunction
# Once
scoreboard players set @s bs.pos.z 65
function #bs.position:set_pos_z {scale:1}
```
::::
::::{tab-item} h,v

```{function} #bs.position:set_rot {scale:<scaling>}

Rotate an entity according to its scores.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Scores `@s bs.rot.[h,v]`**: Rotation to teleport to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported to the rotation indicated by the scores.
```

::::
::::{tab-item} h only


```{function} #bs.position:set_rot_h {scale:<scaling>}

Rotate an entity according to its horizontal rotation score.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.rot.h`**: Rotation to teleport to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported to the rotation indicated by the horizontal score.
```

::::
::::{tab-item} v only

```{function} #bs.position:set_rot_v {scale:<scaling>}

Rotate an entity according to its vertical rotation score.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.

  **Score `@s bs.rot.v`**: Rotation to teleport to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported to the rotation indicated by the vertical score.
```

::::
::::{tab-item} x,y,z,h,v

```{function} #bs.position:set_pos_and_rot {scale:<scaling>}

Place and rotate an entity according to its position and rotation scores.

:Inputs:
  **Execution `as <entities>`**: Entity to teleport.
  **Scores `@s bs.pos.[x,y,z]`**: Coordinates to teleport to.
  **Scores `@s bs.rot.[h,v]`**: Rotation to teleport to.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Entity is teleported to the position indicated by the position scores and rotated according to the rotation scores.
```

::::
:::::

> **Credits**: Aksiome, Leirof, theogiraudet

---

```{include} ../_templates/comments.md
```
