# 🎬 Animation

**`#bs.animation:help`**

A keyframe-based animation system with spline support.
Use it to animate entity parts over time with precise control.

```{pull-quote}
"Animation is not the art of drawings that move but the art of movements that are drawn."

-- Norman McLaren
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Bake

```{function} #bs.animation:bake {uses:<string>}

Precompute animation data and store the result for faster use later.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `uses`: storage that contains the [animation definition](#animation-definition)
  :::

:Outputs:
  **Storage**: the storage is updated with baked animation data
```

*Example: bake the animation stored in `storage foo:bar my_anim`*

```mcfunction
function #bs.animation:bake {uses:"foo:bar my_anim"}
```

> **Credits**: Aksiome

---

### Create

```{function} #bs.animation:create {id:<string>,uses:<string>}

Create and attach a new animation to an entity. If the animation is not baked, it is baked automatically.

:Inputs:
  **Execution `as <entities>`**: entity affected

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique animation identifier for the entity
    - {nbt}`string` `uses`: storage that contains the [animation definition](#animation-definition)
  :::

:Outputs:
  **State**: the animation is added to the entity
```

```{note}
An animation `id` belongs to an entity.

Multiple entities can use the same `id`, but each animation instance is independent.
For example, several entities can have an animation named `walk`, each with different data.
```

*Example: create an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:create {id:"walk",uses:"foo:bar walk_definition"}
```

> **Credits**: Aksiome

---

### Delete

```{function} #bs.animation:delete {id:<string>}

Remove an animation from an entity.

:Inputs:
  **Execution `as <entities>`**: entity affected

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to remove
  :::

:Outputs:
  **State**: the animation is removed from the entity
```

*Example: remove an animation from the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:delete {id:"walk"}
```

> **Credits**: Aksiome

---

### Pause

```{function} #bs.animation:pause {id:<string>}

Pause a running animation.

:Inputs:
  **Execution `as <entities>`**: entity affected

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to pause
  :::

:Outputs:
  **State**: the animation is paused if it was running
```

*Example: pause an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:pause {id:"walk"}
```

> **Credits**: Aksiome

---

### Play

```{function} #bs.animation:play {id:<string>,with:{}}

Start or resume an animation.

:Inputs:
  **Execution `as <entities>`**: entity affected

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to play
    - {nbt}`compound` `with`: optional arguments
      - {nbt}`int` `interval`: tick interval between updates; defaults to `1`
      - {nbt}`number` `step`: amount to advance per interval; defaults to the value of `interval`
  :::

:Outputs:
  **State**: the animation starts running
```

```{tip}
Set `step` to a negative value to reverse the animation.
```

*Example: play an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:play {id:"walk",with:{}}
```

> **Credits**: Aksiome

---

### Reset

```{function} #bs.animation:reset {id:<string>}

Stop an animation and reset its time to `0`.

:Inputs:
  **Execution `as <entities>`**: entity affected

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to reset
  :::

:Outputs:
  **State**: the animation is stopped at time `0`
```

*Example: reset an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:reset {id:"walk"}
```

> **Credits**: Aksiome

---

### Resume

```{function} #bs.animation:resume {id:<string>}

Resume a paused animation.

:Inputs:
  **Execution `as <entities>`**: entity affected

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to resume
  :::

:Outputs:
  **State**: the animation resumes if it was paused
```

*Example: resume an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:resume {id:"walk"}
```

> **Credits**: Aksiome

---

### Rewind

```{function} #bs.animation:rewind {id:<string>}

Move the animation time back to `0` without changing its state.

:Inputs:
  **Execution `as <entities>`**: entity affected

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to rewind
  :::

:Outputs:
  **State**: the animation time is set to `0`
```

*Example: rewind an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:rewind {id:"walk"}
```

> **Credits**: Aksiome

---

### Step

```{function} #bs.animation:step {id:<string>,with:{}}

Advance an animation by a fixed amount.

:Inputs:
  **Execution `as <entities>`**: entity affected

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to step
    - {nbt}`compound` `with`: optional arguments
      - {nbt}`number` `step`: amount of time to advance; defaults to `1`
  :::

:Outputs:
  **State**: the animation advances by the given step
```

```{tip}
Set `step` to a negative value to go backward.
```

*Example: step an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:step {id:"walk",with:{}}
```

> **Credits**: Aksiome

---

## 📝 Animation Definition

An animation can affect multiple parts of an entity.
Supported fields are shown below.

```json
{
  "position": { <3D> },
  "rotation": { <2D> },
  // Armor Stand
  "pose": { 
    "body": { <3D> },
    "head": { <3D> },
    "left_arm": { <3D> },
    "left_leg": { <3D> },
    "right_arm": { <3D> },
    "right_leg": { <3D> },
  },
  // Display Entities
  "transformation": { 
    "left_rotation": { <3D> },
    "right_rotation": { <3D> },
    "translation": { <3D> },
    "scale": { <3D> },
  },
}
```

---

### Keyframes

Keyframes define fixed points along a timeline.

```json
{
  "interpolation": "linear|smooth|step",
  "duration": [<segment>, <segment>],
  "points": [
    [<x>, <y>, <z>],
    [<x>, <y>, <z>],
    [<x>, <y>, <z>],
  ]
}
```

| Field | Description |
|-------|-------------|
| interpolation | Interpolation type between points |
| duration | Ticks per segment, or a single total duration |
| points | 1D, 2D, or 3D keyframe values |

---

### Spline

Splines generate smooth motion using control points.

```json
{
  "basis": "bezier|bspline|catmull_rom|hermite",
  "duration": <total>,
  "points": [
    [<x>, <y>, <z>],
    [<x>, <y>, <z>],
    [<x>, <y>, <z>],
    [<x>, <y>, <z>],
  ]
}
```

| Field | Description |
|-------|-------------|
| basis | Spline type |
| duration | Total duration or per-segment durations |
| points | Control points; at least 4 points required |

```{note}
Splines use control points.
The animation may not pass through every point.
The exact behavior depends on the chosen spline basis.
```

---

### Example

We will create a camera using a `block_display` entity. The camera can then be used by a player by riding or spectating the entity.

For this example, the path will have two segments. We choose an arbitrary `teleport_duration` of 3 and use the same value for the animation `interval` to reduce the number of commands executed each tick. Camera movement is sensitive to abrupt acceleration changes, so we must choose the right spline to ensure smooth motion.

We use a single duration as well as a `bspline`, the only C² continuous spline, to guarantee smooth acceleration along the path.

```mcfunction
# Summon the camera entity
summon minecraft:block_display ~ ~ ~ {teleport_duration:3}

# Setup the animation data for the camera
data modify storage foo:bar camera set value { \
  position: { \
    basis: "bspline", \
    duration:100, \
    points: [ \
      [13.0,-15.0,1.0], \
      [12.0,-15.0,-4.0], \
      [9.0,-14.0,-10.0], \
      [2.0,-12.0,-10.0], \
      [-1.0,-9.0,-14.0], \
    ], \
  }, \
}

# Attach the animation to the entity
execute as @n[type=block_display] run function #bs.animation:create {id:"camera",uses:"foo:bar camera"}

# Play the animation
execute as @n[type=block_display] run function #bs.animation:play {id:"camera",with:{interval:3}}
```

```{note}
A B-spline is shaped by control points rather than passing directly through them. The curve follows a smooth path influenced by these points, and the number of segments is always the number of points minus three.

To see how each spline type behaves, see the [Spline](spline.md#about-splines) section.
```

---

## 🔄 Animation Lifecycle

Animations move through defined states based on function calls.

---

### States

Animations have three possible states:

:::{list-table}
*   - **Running**
    - The animation is actively advancing over time.
*   - **Paused**
    - The animation is temporarily halted but can resume from its current time.
*   - **Stopped**
    - The animation is not scheduled for execution. Time may be at `0`, mid-animation, or at the end.
:::

---

### Transitions

Most functions can be called in any state with a few exceptions:

- `#bs:animation:pause` requires **Running**
- `#bs:animation:resume` requires **Paused**

```{mermaid}
%%{ init: { 'flowchart': {'defaultRenderer': 'elk' } } }%%
flowchart BT
  Running -->|play/rewind/step|Running
  Running -->|reset|Stopped
  Running -->|pause|Paused

  Paused -->|rewind/step|Paused
  Paused -->|play/resume|Running
  Paused -->|reset|Stopped

  Stopped -->|reset/rewind/step|Stopped
  Stopped -->|play|Running
```

---

```{include} ../_templates/comments.md
```
