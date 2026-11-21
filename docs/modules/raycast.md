# 🔦 Raycast

**`#bs.raycast:help`**

Cast rays to detect block and entity hits, with voxel-accurate collisions.

```{pull-quote}
"Reality only reveals itself when it is illuminated by a ray of poetry."

-- Georges Braque
```

---

## Functions

The following functions are available in this module.

---

### Cast

```{feature} bs.raycast:cast
```

```{tip}
A ray never hits an entity tagged `bs.raycast.omit`, such as the entity that casts it: run `tag @s add bs.raycast.omit` on it once.
```

*Example: check if there is a block within 10 blocks in front of you*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ if function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:10}} run say I see a block
```

*Example: turn the block you look at into gold*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/outline",max_distance:6,on_block:"setblock ~ ~ ~ minecraft:gold_block"}}
```

---

### Pierce

```{feature} bs.raycast:pierce
```

```{tip}
The ray stops at a command unless it returns a non-zero value: a function must end with `return 1` to keep piercing. A command that fails, such as `execute if block` on another block, stops it, which makes a condition a single command.
```

*Example: break the glass in front of you, up to the first other block*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:10,on_block:"execute if block ~ ~ ~ #minecraft:impermeable run setblock ~ ~ ~ minecraft:air destroy"}}
```

*Example: show where the ray enters and leaves each block, through up to 16 blocks*

```mcfunction
# In the function my_pack:entry
particle minecraft:flame ~ ~ ~
return 1

# In the function my_pack:exit
particle minecraft:soul_fire_flame ~ ~ ~
return 1
```

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",on_entry:"function my_pack:entry",on_exit:"function my_pack:exit"}}
```

---

## Predicates

The following predicates are available in this module. Use them in a [command of the ray](#commands).

---

### Hit face

:::::{tab-set}
::::{tab-item} Bottom

```{feature} bs.raycast:face/bottom
```

::::
::::{tab-item} East

```{feature} bs.raycast:face/east
```

::::
::::{tab-item} North

```{feature} bs.raycast:face/north
```

::::
::::{tab-item} South

```{feature} bs.raycast:face/south
```

::::
::::{tab-item} Top

```{feature} bs.raycast:face/top
```

::::
::::{tab-item} West

```{feature} bs.raycast:face/west
```

::::
:::::

*Example: place a torch on the top of the block you look at*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/outline",max_distance:6,on_block:"execute if predicate bs.raycast:face/top run setblock ~ ~1 ~ minecraft:torch keep"}}
```

---

### Hit flag

:::::{tab-set}
::::{tab-item} 1

```{feature} bs.raycast:flag/1
```

::::
::::{tab-item} 2

```{feature} bs.raycast:flag/2
```

::::
::::{tab-item} 4

```{feature} bs.raycast:flag/4
```

::::
::::{tab-item} 8

```{feature} bs.raycast:flag/8
```

::::
:::::

*Example: say when the ray enters water, with a provider that gives the fluid of a block the flag `2`*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision_with_fluid",on_entry:"execute if predicate bs.raycast:flag/2 run say Splash"}}
```

---

## Float providers

The following float providers are available in this module. Use them in a [command of the ray](#commands): the entry ones in any command, where `on_block` and `on_entity` get the nearest entry and `on_entry` and `on_exit` the entry of their shape, and the exit ones in `on_exit`. The points are relative to the block the ray hits, or to the feet of the entity.

---

### Hit entry

:::::{tab-set}
::::{tab-item} Distance

```{feature} bs.raycast:entry/distance
```

::::
::::{tab-item} X

```{feature} bs.raycast:entry/x
```

::::
::::{tab-item} Y

```{feature} bs.raycast:entry/y
```

::::
::::{tab-item} Z

```{feature} bs.raycast:entry/z
```

::::
:::::

*Example: keep the distance to the block you look at*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage my_pack: distance set compute default float bs.raycast:entry/distance"}}

# See the result
data get storage my_pack: distance
```

*Example: keep where the ray enters the block you look at, relative to that block*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage my_pack: y set compute default float bs.raycast:entry/y"}}

# See the result
data get storage my_pack: y
```

---

### Hit exit

:::::{tab-set}
::::{tab-item} Distance

```{feature} bs.raycast:exit/distance
```

::::
::::{tab-item} X

```{feature} bs.raycast:exit/x
```

::::
::::{tab-item} Y

```{feature} bs.raycast:exit/y
```

::::
::::{tab-item} Z

```{feature} bs.raycast:exit/z
```

::::
:::::

*Example: keep how far the ray goes before it leaves the first block it pierces*

```mcfunction
# In the function my_pack:exit
data modify storage my_pack: exit set compute default float bs.raycast:exit/distance
return 0
```

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",on_exit:"function my_pack:exit"}}

# See the result
data get storage my_pack: exit
```

---

## Int providers

The following int providers are available in this module. Use them in a [command of the ray](#commands).

---

### Hit block

:::::{tab-set}
::::{tab-item} X

```{feature} bs.raycast:block/x
```

::::
::::{tab-item} Y

```{feature} bs.raycast:block/y
```

::::
::::{tab-item} Z

```{feature} bs.raycast:block/z
```

::::
:::::

*Example: keep the coordinates of the block you look at*

```mcfunction
# Once
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"execute store result score #x my_pack run compute default integer bs.raycast:block/x"}}

# See the result
scoreboard players get #x my_pack
```

---

(commands)=
## Commands

A ray runs commands where it hits something. `#bs.raycast:cast` runs them at the nearest block or entity it hits, then stops. `#bs.raycast:pierce` runs them at every block and entity it goes through, nearest first.

---

In a block or an entity it hits, the ray groups the boxes of the provider into shapes: boxes with the same flag that touch or overlap are one shape. Its commands then run in this order:

:::{list-table}
*   - **`on_block`**
    - Once for the block, aligned to the grid, before the commands of its shapes.
*   - **`on_entity`**
    - Once for the entity, as and at it, before the commands of its shapes.
*   - **`on_entry`**
    - At the point where the ray enters a shape, nearest shape first.
*   - **`on_exit`**
    - At the point where the ray leaves that shape, right after its `on_entry`. Only in `#bs.raycast:pierce`.
:::

With `#bs.raycast:cast`, the [predicates](#predicates) and [providers](#float-providers) give the nearest box the ray hits, and `on_entry` runs once, for that box.

With `#bs.raycast:pierce`, `on_block` and `on_entity` get the nearest entry and every flag of the shapes the ray goes through, and the ray enters and leaves each shape. A ray that leaves a shape and enters it again, such as through the two walls of a cauldron, gives an entry and an exit each time. The ray stops at a command unless it returns a non-zero value.

*Example: a waterlogged stairs pierced with `#bs.hitbox:get_block/collision_with_fluid`, which gives the stairs the flag `1` and the water the flag `2`*

:::{list-table}
*   - **`on_block`**
    - Runs once: `flag/1` and `flag/2` both pass
*   - **`on_entry`** and **`on_exit`**
    - Run for the stairs, where `flag/1` passes, then for the water, where `flag/2` passes, in the order the ray enters them
:::

---

```{include} ../_templates/comments.md
```
