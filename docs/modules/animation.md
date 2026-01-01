# 🎬 Animation

**`#bs.animation:help`**

Animation system based on keyframes and splines.

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

Precompute data on the storage for faster use later.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `uses`: storage containing animation data, for example `foo:bar my_anim`
  :::

:Outputs:
  **Storage**: storage is updated with baked animation data
```

*Example: bake the animation stored in `storage foo:bar my_anim`*

```mcfunction
function #bs.animation:bake {uses:"foo:bar my_anim"}
```

> **Credits**: Aksiome

---

### Create

```{function} #bs.animation:create {id:<string>,uses:<string>}

Create and attach a new animation to an entity. Automatically bakes it if required.

:Inputs:
  **Execution `as <entities>`**: entity affected by the function

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier for the animation
    - {nbt}`string` `uses`: storage containing animation data, for example `foo:bar my_anim`
  :::

:Outputs:
  **State**: animation is added to the entity
```

```{note}
An animation `id` belongs to an entity and is not shared.
The same `id` can exist on multiple entities with different animations.

For example, two entities can both have a `walk` animation, but each animation is different.
```

*Example: create a new animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:create {id:"walk",uses:"foo:bar linear_walk"}
```

> **Credits**: Aksiome

---

### Delete

```{function} #bs.animation:delete {id:<string>}

Remove an animation from an entity.

:Inputs:
  **Execution `as <entities>`**: entity affected by the function

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to remove
  :::

:Outputs:
  **State**: animation is removed from the entity
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
  **Execution `as <entities>`**: entity affected by the function

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to pause
  :::

:Outputs:
  **State**: animation is paused if it was running
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
  **Execution `as <entities>`**: entity affected by the function

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to play
    - {nbt}`compound` `with`: optional arguments
      - {nbt}`int` `interval`: tick refresh rate; defaults to `1`
      - {nbt}`number` `step`: amount to advance per interval; defaults to the value of `interval`
  :::

:Outputs:
  **State**: animation is running
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

Stop an animation and reset it to its initial state.

:Inputs:
  **Execution `as <entities>`**: entity affected by the function

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to reset
  :::

:Outputs:
  **State**: animation is stopped at time `0`
```

*Example: reset an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:reset {id:"walk"}
```

> **Credits**: Aksiome

---

### Resume

```{function} #bs.animation:resume {id:<string>}

Resume an animation that was paused.

:Inputs:
  **Execution `as <entities>`**: entity affected by the function

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to resume
  :::

:Outputs:
  **State**: animation is resumed if it was paused
```

*Example: resume an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:resume {id:"walk"}
```

> **Credits**: Aksiome

---

### Rewind

```{function} #bs.animation:rewind {id:<string>}

Set the animation playback time back to the start without changing its state.

:Inputs:
  **Execution `as <entities>`**: entity affected by the function

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to reset
  :::

:Outputs:
  **State**: animation is rewinded at time `0`
```

*Example: rewind an animation on the nearest Armor Stand*

```mcfunction
execute as @n[type=armor_stand] run function #bs.animation:rewind {id:"walk"}
```

> **Credits**: Aksiome

---

### Step

```{function} #bs.animation:step {id:<string>,with:{}}

Step an animation forward.

:Inputs:
  **Execution `as <entities>`**: entity affected by the function

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`string` `id`: unique identifier of the animation to step
    - {nbt}`compound` `with`: optional arguments
      - {nbt}`number` `step`: amount to advance; defaults to `1`
  :::

:Outputs:
  **State**: animation advances by the given step
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

## Lifecycle

You’ll find below the general lifecycle and state transitions for animations.

---

### States

Animations have three possible states:

:::{list-table}
*   - **Running**
    - The animation is actively advancing via ticks.
*   - **Paused**
    - The animation is temporarily halted but can resume from its current time.
*   - **Stopped**
    - The animation is not scheduled for execution. Time may be at `0`, mid-animation, or at the end.
:::

---

### Transitions

Functions can be called in any state, except `#bs:animation:pause`, which requires the animation to be **Running** and `#bs:animation:resume`, which requires it to be **Paused**.

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
