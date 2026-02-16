# 🔦 Raycast

**`#bs.raycast:help`**

Cast rays and detect collisions with blocks or entities.

```{pull-quote}
"Reality only reveals itself when it is illuminated by a ray of poetry."

-- Georges Braque
```

```{note}
This module implements a **DDA** algorithm, also known as [voxel traversal](http://www.cse.yorku.ca/~amana/research/grid.pdf).

Instead of checking points at fixed intervals (which can miss thin shapes), the ray steps from one block boundary to the next. This ensures:
1. **Perfect Precision**: Every single block along the path is checked.
2. **Performance**: No redundant checks within the same block.
3. **Flexibility**: Works seamlessly with the `bs.hitbox` module to support complex shapes.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Run

```{function} #bs.raycast:run {with:{}}

Cast a ray from the execution position and check if it hits something. Lambda scores and storage are only available during callback execution (`on_*`).

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z> rotated <rot>`**: Origin of the ray.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`compound` **with**: Ray input data.
      - {nbt}`bool` {nbt}`string` **blocks**: Whether the ray stops on blocks (default: true).  
      *Can be a [hitbox provider](hitbox.md#available-providers) (e.g. `function #bs.hitbox:callback/get_block_collision`).*
      - {nbt}`bool` {nbt}`string` **entities**: Whether the ray stops on entities (default: false).  
      *Can be a selector tag (typically assigned via `/tag`), which is preferred for performance.*
      - {nbt}`string` **ignored_blocks**: Blocks to ignore (default: `#bs.hitbox:intangible`).
      - {nbt}`string` **ignored_entities**: Entity type to ignore (default: `#bs.hitbox:intangible`).  
      *Does not apply to entities with custom hitboxes.*
      - {nbt}`number` **max_distance**: Maximum ray travel distance (default: 16.0).
      - {nbt}`string` **on_targeted_block**: Command to run `at` the block hit by the ray (aligned).
      - {nbt}`string` **on_targeted_entity**: Command to run `as` and `at` the entity hit by the ray.
      - {nbt}`string` **on_hit_point**: Command to run `at` the exact point where the ray makes contact.  
      *May run multiple times per block when multiple shapes are intersected.*
      - {nbt}`int` {nbt}`compound` **piercing**: Number of blocks or entities the ray can pass through (default: `0`).
        - {nbt}`int` **blocks**: Number of blocks to track independently from entities (default: `0`).
        - {nbt}`int` **entities**: Number of entities to track independently from blocks (default: `0`).
  :::

:Lambdas:
  **Score `$raycast.distance bs.lambda`**: The distance from origin (scaled ×1000).

  **Score `$raycast.hit_face bs.lambda`**: The face of the bounding box that was hit: 5 is east, 4 is west, 3 is south, 2 is north, 1 is top, and 0 is bottom.

  **Score `$raycast.hit_flag bs.lambda`**: The flag of the intersected bounding box, `-1` for entities.

  **Score `$raycast.piercing bs.lambda`**: The remaining number of blocks or entities the ray can pass through.

  **Score `$raycast.pierce_distance bs.lambda`**: The distance from previous hit point (scaled ×1000).

  **Storage `bs:lambda raycast`**:
  :::{treeview}
  - {nbt}`compound` Ray lambda data (deprecated will be removed in v4.0)
    - {nbt}`double` **distance**: The distance from the ray's origin to the impact point.
    - {nbt}`list` **hit_point**: The coordinates of the impact point.
    - {nbt}`list` **hit_normal**: The normal of the surface the ray hits.
    - {nbt}`list` **targeted_block**: The coordinates of the block that was hit.
    - {nbt}`list` **targeted_entity**: The UUID array of the entity that was hit.
  :::

:Outputs:
  **Return**: Whether the ray collides with a hitbox or not (1 or 0).

  **Storage `bs:out raycast`**:
  :::{treeview}
  - {nbt}`compound` Ray output data (deprecated will be removed in v4.0)
    - {nbt}`double` **distance**: The distance from the ray's origin to the impact point.
    - {nbt}`list` **hit_point**: The coordinates of the impact point.
    - {nbt}`list` **hit_normal**: The normal of the surface the ray hit.
    - {nbt}`list` **targeted_block**: The coordinates of the block that was hit.
    - {nbt}`list` **targeted_entity**: The UUID array of the entity that was hit.
  :::
```

```{dropdown} What is a Bounding Box?
:color: info
:icon: question

A bounding box is a simple rectangular box that surrounds an object—or part of it—to help the game figure out where it is and what it touches. For example, a set of stairs in Minecraft uses two bounding boxes: one for the lower step and one for the upper step.
```

```{admonition} Callback Order
:class: info
Callbacks `on_targeted_block` and `on_targeted_entity` are always run before `on_hit_point` to guarantee block/entity information is available before processing hit-point data.
```

```{admonition} Custom Hitboxes
:class: hint
Bookshelf supports multiple [hitbox types](hitbox.md#hitbox-types) for precise control. Blocks can use custom [hitbox providers](hitbox.md#available-providers). Entities support three types: `dynamic`, `baked`, and `custom`.
```

*Example: Cast a ray from your eyes and detect any collisions:*

```mcfunction
# Once (returns 0 if no collision occurred)
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{}}

# If a collision occurred, see the collision point
data get storage bs:out raycast.hit_point
```

*Example: Piercing multi-layer block and fluid handling:*

```mcfunction
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{blocks:"function #bs.hitbox:callback/get_block_shape_with_fluid",ignored_blocks:"#air",piercing:1,on_hit_point:"particle minecraft:flame ~ ~ ~ 0 0 0 0 1 force"}}
```

1. Callback `on_targeted_block` runs once with a `$raycast.hit_flag bs.lambda` score of `1` (solid), `2` (liquid), or `3` (both). Each unique flag is a power of 2 The `hit_flag` is the bitwise OR of all intersected shape flags ("both" being solid and liquid, `1` OR `2` = `3`).
2. Callback `on_hit_point` may run multiple times with a `$raycast.hit_flag bs.lambda` score of `1` (solid) or `2` (liquid) depending on the hit shape.
3. Piercing decremented only once per block.

> **Credits**: Aksiome

---

```{include} ../_templates/comments.md
```
