# 🎬 Animation

**`#bs.animation:help`**

Attach animations to entities and play them over time.

```{pull-quote}
"Animation is not the art of drawings that move but the art of movements that are drawn."

-- Norman McLaren
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Attach

```{function} #bs.animation:attach

Attach an animation to an entity. The animation does nothing until you play or step it.

:Inputs:
  **Execution `as <entities>`**: entities to animate

  **Storage `bs.animation:attach in`**:
  :::{treeview}
  - {nbt}`compound` animation definition
    - {nbt}`string` **id**: identifier of the animation (several animations can share an id to be controlled together)
    - {nbt}`string` **run**: command executed each time the animation advances, see [callbacks](#callbacks)
    - {nbt}`string` **type**: curve type [`step`|`linear`|`catmull_rom`|`bezier`|`bspline`|`hermite`]
    - {nbt}`list` **points**: points of the curve, each a list of 1 to 4 numbers, see [points](#points)
    - {nbt}`int` {nbt}`list` **duration**: duration in ticks, either a total or a list with one entry per segment
  :::

:Outputs:
  **Return**: whether the animation was attached (1 or 0)

  **State**: the animation is added to the entity
```

*Example: attach a linear path to the nearest armor stand*

```mcfunction
# Setup the input
data modify storage bs.animation:attach in set value { \
  id:"walk", \
  run:"function #bs.animation:apply/position", \
  type:"linear", \
  duration:[40,60], \
  points:[[0,64,0],[4,64,0],[4,64,6]], \
}

# Attach the animation
execute as @n[type=armor_stand] run function #bs.animation:attach
```

> **Credits**: Aksiome

---

### Detach

```{function} #bs.animation:detach

Remove every animation with the given id from an entity.

:Inputs:
  **Execution `as <entities>`**: entities to detach the animation from

  **Storage `bs.animation:detach in`**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **id**: identifier of the animation to remove
  :::

:Outputs:
  **Return**: whether an animation with this id was found (1 or 0)

  **State**: the animation is removed from the entity
```

*Example: detach the `walk` animation from the nearest armor stand*

```mcfunction
# Setup the input
data modify storage bs.animation:detach in set value {id:"walk"}

# Detach the animation
execute as @n[type=armor_stand] run function #bs.animation:detach
```

> **Credits**: Aksiome

---

### Pause

```{function} #bs.animation:pause

Stop advancing an animation while keeping its current time. Play resumes it from there.

:Inputs:
  **Execution `as <entities>`**: entities affected

  **Storage `bs.animation:pause in`**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **id**: identifier of the animation to pause
  :::

:Outputs:
  **Return**: whether a playing animation with this id was found (1 or 0)

  **State**: the animation is no longer scheduled
```

*Example: pause the `walk` animation on the nearest armor stand*

```mcfunction
# Setup the input
data modify storage bs.animation:pause in set value {id:"walk"}

# Pause the animation
execute as @n[type=armor_stand] run function #bs.animation:pause
```

> **Credits**: Aksiome

---

### Play

```{function} #bs.animation:play

Start or resume an animation. The callback runs right away for the current frame, then once every interval.

:Inputs:
  **Execution `as <entities>`**: entities affected

  **Storage `bs.animation:play in`**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **id**: identifier of the animation to play
    - {nbt}`number` **step**: playback speed, as a multiplier of real time (default: 1)
    - {nbt}`int` **interval**: game ticks between two updates (default: 1)
    - {nbt}`bool` **loop**: whether the animation wraps around at either end (default: unchanged, false on first play)
  :::

:Outputs:
  **Return**: whether an animation with this id was found (1 or 0)

  **State**: the animation is scheduled
```

```{note}
The animation remembers `step`, `interval` and `loop`. Omitting one keeps its previous value, so playing again after a pause resumes with the same settings.

An animation that reached its end stays there. Rewind or reset it before playing it again.
```

*Example: play the `walk` animation in a loop, updated every second tick*

```mcfunction
# Setup the input
data modify storage bs.animation:play in set value {id:"walk",loop:true,interval:2}

# Play the animation
execute as @n[type=armor_stand] run function #bs.animation:play
```

> **Credits**: Aksiome

---

### Reset

```{function} #bs.animation:reset

Stop an animation and put it back at its first frame. Play settings are forgotten.

:Inputs:
  **Execution `as <entities>`**: entities affected

  **Storage `bs.animation:reset in`**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **id**: identifier of the animation to reset
  :::

:Outputs:
  **Return**: whether an animation with this id was found (1 or 0)

  **State**: the animation is stopped at time 0
```

*Example: reset the `walk` animation on the nearest armor stand*

```mcfunction
# Setup the input
data modify storage bs.animation:reset in set value {id:"walk"}

# Reset the animation
execute as @n[type=armor_stand] run function #bs.animation:reset
```

> **Credits**: Aksiome

---

### Rewind

```{function} #bs.animation:rewind

Put an animation back at its first frame without changing anything else. A playing animation keeps playing. A paused one stays paused.

:Inputs:
  **Execution `as <entities>`**: entities affected

  **Storage `bs.animation:rewind in`**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **id**: identifier of the animation to rewind
  :::

:Outputs:
  **Return**: whether an animation with this id was found (1 or 0)

  **State**: the animation time is set to 0
```

*Example: rewind the `walk` animation on the nearest armor stand*

```mcfunction
# Setup the input
data modify storage bs.animation:rewind in set value {id:"walk"}

# Rewind the animation
execute as @n[type=armor_stand] run function #bs.animation:rewind
```

> **Credits**: Aksiome

---

### Step

```{function} #bs.animation:step

Advance an animation by hand and run its callback once. Works whether the animation is playing, paused, or never played.

:Inputs:
  **Execution `as <entities>`**: entities affected

  **Storage `bs.animation:step in`**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` **id**: identifier of the animation to step
    - {nbt}`number` **step**: number of ticks to move along the animation, negative to go backward (default: 1)
  :::

:Outputs:
  **Return**: whether an animation with this id was found (1 or 0)

  **State**: the animation time is advanced
```

```{tip}
Stepping doesn't change the speed set by play.
```

*Example: move the `walk` animation half a tick backward*

```mcfunction
# Setup the input
data modify storage bs.animation:step in set value {id:"walk",step:-0.5}

# Step the animation
execute as @n[type=armor_stand] run function #bs.animation:step
```

> **Credits**: Aksiome

---

## 📝 Animation definition

An animation has three parts: a curve through a list of points, a duration, and a callback that turns the current point into something visible.

### Callbacks

The `run` command executes as the animated entity each time the animation advances. Inside it, the number providers `bs.animation:eval/[0-3]` give the current value of each component:

```mcfunction
data modify storage foo:bar value set compute default float bs.animation:eval/0
```

The module ships callbacks for the common cases. Use them as the `run` value.

:::{list-table}
:header-rows: 1
*   - Callback
    - Points
    - Effect
*   - `function #bs.animation:apply/position`
    - `[x,y,z]`
    - teleports the entity to the point, prefer `rel_position` far from the world origin
*   - `function #bs.animation:apply/rel_position`
    - `[x,y,z]`
    - teleports the entity to the point offset from an anchor, see below
*   - `function #bs.animation:apply/rotation`
    - `[yaw,pitch]`
    - sets the entity rotation
*   - `function #bs.animation:apply/pose/head`
    - `[x,y,z]`
    - armor stand head angles, in degrees
*   - `function #bs.animation:apply/pose/body`
    - `[x,y,z]`
    - armor stand body angles
*   - `function #bs.animation:apply/pose/left_arm`
    - `[x,y,z]`
    - armor stand left arm angles
*   - `function #bs.animation:apply/pose/right_arm`
    - `[x,y,z]`
    - armor stand right arm angles
*   - `function #bs.animation:apply/pose/left_leg`
    - `[x,y,z]`
    - armor stand left leg angles
*   - `function #bs.animation:apply/pose/right_leg`
    - `[x,y,z]`
    - armor stand right leg angles
:::

```{note}
`rel_position` treats the points as offsets from an anchor. The anchor is the entity position when the animation first runs. It's kept through pause, play, and rewind, so the entity always returns to the same path even if it was moved in between. Reset puts the entity back on the anchor and forgets it.
```

### Duration

Durations are in ticks. A single number is the total duration, spread evenly across the segments. A list gives one duration per segment. When the list is shorter than the number of segments, the animation ends after the last listed segment that has a valid duration.


### Points

Each point is a list of 1 to 4 numbers. Every point of an animation must have the same length. The callback decides what the numbers mean. A position uses 3, a yaw and pitch rotation uses 2, a scale uses 1.

How points are read depends on the curve type:

:::{list-table}
:header-rows: 1
*   - Type
    - Points
    - Segments
    - Passes through the points
*   - `step`
    - at least 2
    - points - 1
    - yes, jumps from one to the next
*   - `linear`
    - at least 2
    - points - 1
    - yes
*   - `catmull_rom`
    - at least 2
    - points - 1
    - yes, smooth
*   - `bspline`
    - at least 2
    - points + 1
    - only the first and last, smoothest
*   - `bezier`
    - at least 4 (3k + 1)
    - k
    - every third point, the others are handles
*   - `hermite`
    - at least 4 (2k)
    - k - 1
    - every other point, the others are tangents
:::

The module completes `catmull_rom` and `bspline` curves so they start on the first point and end on the last. Points beyond what a type can use are ignored, for example the 5th point of a `bezier` spline.

To better understand how each spline works, check out the spline module, where you can [visualize the curve](spline.md#about-splines)

---

## 🎥 Example

A camera on a `block_display` entity, ridden or spectated by a player. The path follows a B-spline through five control points. A B-spline is the smoothest curve, which matters for a camera because changes in acceleration are visible. Both `teleport_duration` on the entity and `interval` on the animation are set to 4, so the client interpolates between updates.

```mcfunction
# Summon the camera entity
summon minecraft:block_display ~ ~ ~ {teleport_duration:4,block_state:"bookshelf"}

# Attach the animation
data modify storage bs.animation:attach in set value { \
  id: "camera", \
  run: "function #bs.animation:apply/rel_position", \
  type: "bspline", \
  duration: 100, \
  points: [ \
    [0.0, 0.0, 0.0], \
    [-1.0, 0.0, -5.0], \
    [-4.0, 1.0, -11.0], \
    [-11.0, 3.0, -11.0], \
    [-14.0, 6.0, -15.0], \
  ], \
}
execute as @n[type=block_display] run function #bs.animation:attach

# Play it
data modify storage bs.animation:play in set value {id:"camera",interval:4}
execute as @n[type=block_display] run function #bs.animation:play
```

---

```{include} ../_templates/comments.md
```
