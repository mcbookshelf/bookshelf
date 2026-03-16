# 🔦 Raycast

**`#bs.raycast:help`**

Cast rays and detect collisions with blocks or entities.

```{pull-quote}
"Reality only reveals itself when it is illuminated by a ray of poetry."

-- Georges Braque
```

```{admonition} Looking for simple use cases?
:class: tip

If you just want to detect what an entity is looking at (aimed block, aimed entity, hit point), the [View module](view.md) provides simplified wrappers that handle the common cases for you.
```

```{dropdown} How does it work?
:color: info
:icon: info

This module uses a [voxel traversal](http://www.cse.yorku.ca/~amana/research/grid.pdf) algorithm. Instead of checking points at fixed intervals, the ray steps from one block boundary to the next, ensuring every block is checked without redundant operations.
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Run

```{function} #bs.raycast:run {with:{}}

Cast a ray from the execution position and check if it hits something.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z> rotated <rot>`**: origin of the ray

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` arguments
    - {nbt}`compound` **with**: ray input data
      - {nbt}`string` {nbt}`bool` **blocks**: whether the ray stops on blocks (default: true)

        *Can be a [hitbox provider](hitbox.md#available-providers) (e.g. `function #bs.hitbox:callback/get_block_collision`).*
      - {nbt}`string` {nbt}`bool` **entities**: whether the ray stops on entities (default: false)

        *Can be a selector tag (typically assigned via `/tag`), which is preferred for performance.*
      - {nbt}`string` **ignored_blocks**: blocks to ignore (default: `#bs.hitbox:intangible`)
      - {nbt}`string` **ignored_entities**: entity types to ignore (default: `#bs.hitbox:intangible`)

        *Does not apply to entities with custom hitboxes.*
      - {nbt}`number` **max_distance**: maximum ray travel distance (default: 16.0)
      - {nbt}`string` **on_targeted_block**: callback to run `at` the targeted block (aligned)
      - {nbt}`string` **on_targeted_entity**: callback to run `as` and `at` the targeted entity
      - {nbt}`string` **on_entry_point**: callback to run `at` the point where the ray enters a shape

        *May run multiple times per block with complex shapes and piercing.*
      - {nbt}`string` **on_exit_point**: callback to run `at` the point where the ray exits a shape

        *May run multiple times per block with complex shapes and piercing.*
      - {nbt}`int` {nbt}`compound` **piercing**: blocks or entities the ray can pass through (default: `0`)
        - {nbt}`int` **blocks**: blocks to track independently from entities (default: `0`)
        - {nbt}`int` **entities**: entities to track independently from blocks (default: `0`)
  :::

:Lambdas:
  **Score `$raycast.entry_distance bs.lambda`**: distance from origin to the entry point (×1000)

  **Score `$raycast.exit_distance bs.lambda`**: distance from origin to the exit point (×1000)

  **Score `$raycast.prev_entry_distance bs.lambda`**: entry distance from the previous iteration (×1000)

  **Score `$raycast.prev_exit_distance bs.lambda`**: exit distance from the previous iteration (×1000)

  **Score `$raycast.hit_face bs.lambda`**: entry face of the bounding box, `5` is east, `4` is west, `3` is south, `2` is north, `1` is top, and `0` is bottom

  **Score `$raycast.hit_flag bs.lambda`**: flag of the intersected bounding box, `-1` for entities

  **Score `$raycast.piercing bs.lambda`**: remaining number of blocks or entities the ray can pass through

  **Scores `$raycast.entry_point.[x,y,z] bs.lambda`**: entry point relative to the block or entity (×1000)

  **Scores `$raycast.exit_point.[x,y,z] bs.lambda`**: exit point relative to the block or entity (×1000)

  **Scores `$raycast.targeted_block.[x,y,z] bs.lambda`**: coordinates of the targeted block

:Outputs:
  **Return**: whether the ray collides with a hitbox or not (1 or 0)
```

```{dropdown} What is a bounding box?
:color: info
:icon: question

A bounding box is a rectangular box that surrounds an object—or part of it—to detect where it is and what it touches. For example, stairs use two bounding boxes: one for the lower step and one for the upper step.
```

```{admonition} Custom hitboxes
:class: hint

Bookshelf supports multiple [hitbox types](hitbox.md#hitbox-types) for precise control. Blocks can use custom [hitbox providers](hitbox.md#available-providers). Entities support `dynamic`, `baked`, and `custom` types.
```

> **Credits**: Aksiome

---

## 🎓 How to use

### Basic raycast

At its simplest, a raycast checks if something is in front of you and returns `1` (hit) or `0` (miss):

```mcfunction
# Check if there's a block within 10 blocks in front of you
execute anchored eyes positioned ^ ^ ^ store result score #hit bs.data run function #bs.raycast:run {with:{max_distance:10}}
```

By default, rays detect blocks but not entities. The return value tells you if a collision occurred.

---

### Using callbacks

Callbacks let you run commands when the ray hits something. There are four callback types:

| Callback | Runs at | Use case |
|----------|---------|----------|
| `on_targeted_block` | Aligned block position | Place/break blocks, check block type |
| `on_targeted_entity` | Entity position (as & at) | Damage, tag, or interact with entity |
| `on_entry_point` | Exact point where ray enters | Spawn particles, precise hit effects |
| `on_exit_point` | Exact point where ray exits | Through-hit effects, exit wounds |

*Example: spawn a particle exactly where your ray hits a block*

```mcfunction
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{on_entry_point:"particle minecraft:flame ~ ~ ~"}}
```

---

### Configuring detection

By default, rays detect blocks but not entities. You can change this with the `blocks` and `entities` parameters.

**Blocks** accepts `true` (default), `false`, or a [hitbox provider](hitbox.md#available-providers).

```mcfunction
# Ignore blocks entirely
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{blocks:false,entities:true,on_targeted_entity:"say Hit!"}}
```

**Entities** accepts `true`, `false` (default), or an entity tag to filter which entities can be hit.

```mcfunction
# Detect all entities
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{entities:true,on_targeted_entity:"say I was hit!"}}

# Detect only entities with a specific tag (better performance)
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{entities:"my_tag",on_targeted_entity:"say I was hit!"}}
```

```{tip}
Using a tag selector (`entities:"my_tag"`) is more performant than `entities:true` because it narrows down which entities to check.
```

---

### Filtering targets

Use `ignored_blocks` and `ignored_entities` to specify which targets the ray should skip:

```mcfunction
# Ignore glass blocks
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{ignored_blocks:"#c:glass_blocks",on_targeted_block:"setblock ~ ~ ~ stone"}}

# Ignore specific entity types
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{entities:true,ignored_entities:"#bs.hitbox:intangible",on_targeted_entity:"say Hit!"}}
```

Defaults:
- `ignored_blocks`: `#bs.hitbox:intangible` (air and other non-solid blocks)
- `ignored_entities`: `#bs.hitbox:intangible` (markers, area effect clouds, etc.)

---

### Piercing

By default, rays stop at the first collision. Use `piercing` to let rays pass through multiple targets:

```mcfunction
# Pass through up to 3 blocks before stopping
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{piercing:3,on_entry_point:"particle minecraft:flame ~ ~ ~"}}
```

You can also track blocks and entities separately:

```mcfunction
# Pass through 2 blocks but stop at first entity
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{entities:true,piercing:{blocks:2,entities:0},on_entry_point:"particle minecraft:flame ~ ~ ~"}}
```

---

### Lambda scores

Lambda scores provide detailed information about the collision, available only inside callbacks. See the function reference above for the full list.

Common use cases:
- `$raycast.entry_distance` - how far the hit is from the ray origin
- `$raycast.entry_point.[x,y,z]` - exact hit position relative to the target
- `$raycast.hit_face` - which face was hit (`0`=bottom, `1`=top, `2`=north, `3`=south, `4`=west, `5`=east)
- `$raycast.hit_flag` - which hitbox shape was hit (provider-dependent, `-1` for entities)

```{important}
Position scores (`entry_point`, `exit_point`) have different reference points:
- **Blocks**: relative to the aligned block position
- **Entities**: relative to the entity's position
```

---

### Hitbox providers

Hitbox providers control which block shapes the ray detects. The default only detects solid collision shapes, but you can use other providers to detect additional shapes like fluids.

```mcfunction
# Detect both solid blocks and fluids
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{blocks:"function #bs.hitbox:callback/get_block_shape_with_fluid",ignored_blocks:"#air"}}
```

Providers can define multiple shapes with different flags. When this happens:
- `on_targeted_block` runs once per block, with `$raycast.hit_flag` combining all intersected shapes
- `on_entry_point` and `on_exit_point` run once per shape, with `$raycast.hit_flag` set to that shape's flag

For example, the fluid provider uses `1` for solid and `2` for fluid. A waterlogged block could trigger entry/exit callbacks twice (with flag `1` and `2`), and `on_targeted_block` once with flag `3`.

---

```{include} ../_templates/comments.md
```
