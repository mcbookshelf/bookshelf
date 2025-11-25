# 🏃 Move

**`#bs.move:help`**

Make your entity move exactly the way you want it to!

```{image} /_imgs/modules/move.png
:align: center
:class: dark_light
```

```{pull-quote}
"There is nothing permanent except change."

-- Heraclitus
```

```{button-link} https://youtu.be/V6NxxpN_hhc
:color: primary
:align: center
:shadow:

{octicon}`device-camera-video` Watch a demo
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Apply Velocity

:::::{tab-set}
::::{tab-item} Canonical

```{function} #bs.move:apply_vel {scale:<scaling>,with:{}}

Teleport an entity by its velocity scores while handling collisions. Lambda scores are only available during callback execution (`on_*`).

:Inputs:
  **Execution `as <entities>`**: Entity to move.

  **Scores `@s bs.vel.[x,y,z]`**: Canonical velocity vector.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
    - {nbt}`compound` **with**: Collision settings.
      - {nbt}`bool` {nbt}`string` **blocks**: Whether the entity should collide with blocks (default: true).  
      *Can be a [hitbox provider](hitbox.md#available-providers) (e.g. `function #bs.hitbox:callback/get_block_collision`).*
      - {nbt}`bool` {nbt}`string` **entities**: Whether the entity should collide with entities (default: false).  
      *Can be a selector tag (typically assigned via `/tag`), which is preferred for performance.*
      - {nbt}`string` **ignored_blocks**: Blocks to ignore (default: `#bs.hitbox:can_pass_through`).
      - {nbt}`string` **ignored_entities**: Entity type to ignore (default: `#bs.hitbox:intangible`).  
      *Does not apply to entities with custom hitboxes.*
      - {nbt}`string` **on_collision**: Command to run when a collision occurs.  
      *Used to resolve the collision (default: `function #bs.move:callback/bounce`).*
  :::

:Lambdas:
  **Score `$move.hit_face bs.lambda`**: The face of the bounding box that was hit: 5 is east, 4 is west, 3 is south, 2 is north, 1 is top, and 0 is bottom.

  **Score `$move.hit_flag bs.lambda`**: The flag of the intersected bounding box, `-1` for entities.

  **Scores `$move.vel.[x,y,z] bs.lambda`**: The remaining velocity in canonical coordinates after collision adjustments.

:Outputs:
  **State**: Entity is teleported according to its velocity scores.
```

::::
::::{tab-item} Local

`````{function} #bs.move:apply_local_vel {scale:<scaling>,with:{}}

```{admonition} Experimental
:class: warning

Always prefer the canonical version. Constant conversion between bases can lead to loss of accuracy, sometimes causing unpredictable behavior.

If you need to "shoot" an entity in a direction, you can still set velocity as a local vector and run `#bs.move:canonical_to_local` before using `#bs.move:apply_vel`.
```

Teleport an entity by its velocity scores, using the local reference frame, while handling collisions. Lambda scores are only available during callback execution (`on_*`).

:Inputs:
  **Execution `as <entities>`**: Entity to move.

  **Scores `@s bs.vel.[x,y,z]`**: Local velocity vector.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
    - {nbt}`compound` **with**: Collision settings.
      - {nbt}`bool` {nbt}`string` **blocks**: Whether the entity should collide with blocks (default: true).  
      *Can be a [hitbox provider](hitbox.md#available-providers) (e.g. `function #bs.hitbox:callback/get_block_collision`).*
      - {nbt}`bool` {nbt}`string` **entities**: Whether the entity should collide with entities (default: false).  
      *Can be a selector tag (typically assigned via `/tag`), which is preferred for performance.*
      - {nbt}`string` **ignored_blocks**: Blocks to ignore (default: `#bs.hitbox:can_pass_through`).
      - {nbt}`string` **ignored_entities**: Entity type to ignore (default: `#bs.hitbox:intangible`).  
      *Does not apply to entities with custom hitboxes.*
      - {nbt}`string` **on_collision**: Command to run when a collision occurs, used to resolve the collision (default: `function #bs.move:callback/bounce`).
  :::

:Lambdas:
  **Score `$move.hit_face bs.lambda`**: The face of the bounding box that was hit.

  **Score `$move.hit_flag bs.lambda`**: The flag of the intersected bounding box, `-1` for entities.

  **Scores `$move.vel.[x,y,z] bs.lambda`**: The remaining velocity in canonical coordinates after collision adjustments.

:Outputs:
  **State**: Entity is teleported according to its local velocity scores.
`````

::::
:::::

```{dropdown} What is a Bounding Box?
:color: info
:icon: question

A bounding box is a simple rectangular box that surrounds an object—or part of it—to help the game figure out where it is and what it touches. For example, a set of stairs in Minecraft uses two bounding boxes: one for the lower step and one for the upper step.
```

```{admonition} Custom Hitboxes
:class: hint
Bookshelf supports multiple [hitbox types](hitbox.md#types) for precise control. Blocks can use custom [hitbox providers](hitbox.md#available-providers). Entities support three types: `dynamic`, `baked`, and `custom`.
```

*Example: Move a cube (block_display) by its velocity scores (uses an interaction as the hitbox):*

```mcfunction
# Once
summon minecraft:block_display ~ ~ ~ {block_state:{Name:"stone"},teleport_duration:3,transformation:[1f,0f,0f,-0.5f,0f,1f,0f,0f,0f,0f,1f,-0.5f,0f,0f,0f,1f],Passengers:[{id:"minecraft:interaction",width:1f,height:1f}]}
scoreboard players set @e[type=minecraft:block_display] bs.vel.x 100
scoreboard players set @e[type=minecraft:block_display] bs.vel.y 20
scoreboard players set @e[type=minecraft:block_display] bs.vel.z 50

# In a loop
execute as @e[type=minecraft:block_display] run function #bs.move:apply_vel {scale:0.001,with:{}}

# Choose between multiple collision behaviors
execute as @e[type=minecraft:block_display] run function #bs.move:apply_vel {scale:0.001,with:{on_collision:"function #bs.move:callback/bounce"}}
execute as @e[type=minecraft:block_display] run function #bs.move:apply_vel {scale:0.001,with:{on_collision:"function #bs.move:callback/damped_bounce"}}
execute as @e[type=minecraft:block_display] run function #bs.move:apply_vel {scale:0.001,with:{on_collision:"function #bs.move:callback/slide"}}
execute as @e[type=minecraft:block_display] run function #bs.move:apply_vel {scale:0.001,with:{on_collision:"function #bs.move:callback/stick"}}
```

```{admonition} Performance Tip
:class: tip

Although this system doesn't set specific limits, it's important to note that performance is influenced by both the speed and size of the entity.
```

> **Credits**: Aksiome

---

### Canonical to Local

```{function} #bs.move:canonical_to_local

Convert a canonical velocity (using the relative reference frame) into a local velocity (using the local reference frame).

:Inputs:
  **Execution `rotated as <entity>` or `rotated <h> <v>`**: Rotation used for the conversion.

  **Scores `@s bs.vel.[x,y,z]`**: Velocity to convert.

:Outputs:
  **Scores `@s bs.vel.[x,y,z]`**: Converted velocity.
```

```{dropdown} What is a Local Velocity?
:color: info
:icon: question

Unlike relative velocity (canonical), this reference frame considers the entity's rotation. Therefore, when the parent entity rotates, the child entity rotates around it. For those familiar with Minecraft commands, local coordinates are available through the `^` symbol.
```

> **Credits**: Aksiome

---

### Local to Canonical

```{function} #bs.move:local_to_canonical

Convert a local velocity (using the local reference frame) into a canonical velocity (using the relative reference frame).

:Inputs:
  **Execution `rotated as <entity>` or `rotated <h> <v>`**: Rotation used for the conversion.

  **Scores `@s bs.vel.[x,y,z]`**: Velocity to convert.

:Outputs:
  **Scores `@s bs.vel.[x,y,z]`**: Converted velocity.
```

```{dropdown} What is a Local Velocity?
:color: info
:icon: question

Unlike relative velocity (canonical), this reference frame considers the entity's rotation. Therefore, when the parent entity rotates, the child entity rotates around it. For those familiar with Minecraft commands, local coordinates are available through the `^` symbol.
```

> **Credits**: Aksiome

---

### Set Motion

```{function} #bs.move:set_motion {scale:<scaling>}

Set the motion NBT of an entity using velocity scores.

:Inputs:
  **Execution `as <entities>`**: Entity to move.

  **Scores `@s bs.vel.[x,y,z]`**: Velocity vector.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar applied to the output.
  :::

:Outputs:
  **State**: Motion is applied to the given entity.
```

*Example: Move a pig by its velocity scores:*

```mcfunction
# Once
summon minecraft:pig ~ ~ ~
scoreboard players set @e[type=minecraft:pig] bs.vel.x 50
scoreboard players set @e[type=minecraft:pig] bs.vel.y 25
scoreboard players set @e[type=minecraft:pig] bs.vel.z 0

# In a loop
execute as @e[type=minecraft:pig] run function #bs.move:set_motion {scale:0.001}
```

> **Credits**: Aksiome

---

## 👁️ Predicates

You can find below all predicates available in this module.

---

### Has Velocity?

**`bs.move:has_vel`**

Determine if an entity has a nonzero velocity score.

> **Credits**: Aksiome

---

## 🎓 Custom Collisions

This module allows you to customize collision behaviors according to your specific needs.

---

By modifying the `on_collision` input argument, you have the freedom to specify the function that triggers upon collision. However, managing the resolution yourself can be quite challenging. This is why Bookshelf provides several predefined functions:

:::{list-table}
  *   - `#bs.move:callback/bounce`
      - The entity will bounce on the collision surface.
  *   - `#bs.move:callback/damped_bounce`
      - The entity speed is reduced by 2 on each bounce.
  *   - `#bs.move:callback/slide`
      - The entity will stick and slide along the collision surface.
  *   - `#bs.move:callback/stick`
      - The entity will stop and stick to the collision surface.
:::

### How It Works

When a collision occurs, the system tracks which bounding box was hit using the velocity and the flag of that bounding box. You can modify:

- `@s bs.vel.[x,y,z]`: the velocity that will be applied on the next tick.  
- `$move.vel.[x,y,z] bs.lambda`: the remaining velocity after rolling back to the time of impact.

To simplify the creation of custom behaviors, there's no need to handle a local velocity directly. The vector is automatically converted before and after the collision resolution.

```{admonition} Velocity Scaling
:class: warning
Remaining velocity scores are stored as scaled integers, but the scaling factor may change without breaking compatibility.

To ensure stability, always manipulate these values independently of the scaling factor.
```

The simplest collision resolution is to stop the movement.

*`#bs.move:callback/stick`*
```mcfunction
# set all components to 0 to cancel the movement
execute store result score $move.vel.x bs.lambda run scoreboard players set @s bs.vel.x 0
execute store result score $move.vel.y bs.lambda run scoreboard players set @s bs.vel.y 0
execute store result score $move.vel.z bs.lambda run scoreboard players set @s bs.vel.z 0
```

For sliding, we need to cancel the velocity on the axis that was hit and continue traveling the remaining distance.

*`#bs.move:callback/slide`*
```mcfunction
# set a component to 0 depending on the surface that was hit.
execute if score $move.hit_face bs.lambda matches 4..5 store result score $move.vel.x bs.lambda run scoreboard players set @s bs.vel.x 0
execute if score $move.hit_face bs.lambda matches 0..1 store result score $move.vel.y bs.lambda run scoreboard players set @s bs.vel.y 0
execute if score $move.hit_face bs.lambda matches 2..3 store result score $move.vel.z bs.lambda run scoreboard players set @s bs.vel.z 0
```

### Flags and Tags

Flags and tags let you control how entities interact with multiple overlapping bounding boxes, for example, allowing movement through fluid shapes while stopping at solid shapes.

- Each bounding box has a numeric `flag` (`1`, `2`, `4`, or `8`).  
- When an entity enters a bounding box, it receives a tag `bs.move.flag.<flag>`, which prevents repeated collisions while inside bounding boxes with the same flag. The tag is removed once the entity is no longer inside any bounding box with the same flag.

Flags are particularly useful when using a [hitbox provider](hitbox.md#available-providers) that handles fluids. For example, here's how a waterlogged stairs could respond:

1. The stairs have two types of bounding boxes:  
   - **Fluid** (water) with flag `2`  
   - **Solid** (stairs themselves) with flag `1`  

2. The entity enters the water:  
   - `on_collision` is triggered.  
   - We can choose to preserve the velocity along the axis of collision.  
   - The entity receives `bs.move.flag.2`.  
   - While this tag is active, collisions with other water blocks or fluid shapes do nothing, so the entity keeps moving smoothly through fluids.

3. The entity hits the solid part of the stairs:  
   - `on_collision` is triggered again.  
   - This time we reverse the velocity (bounce).  
   - No tag is set, so collisions with other solid shapes are processed normally.  
   - The entity stops or bounces off as expected, like a normal solid collision.

If you need help with custom collisions, you can ask us on our [discord server](https://discord.gg/MkXytNjmBt)!

---

```{include} ../_templates/comments.md
```
