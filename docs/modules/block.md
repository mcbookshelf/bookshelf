# 🧱 Block

**`#bs.block:help`**

Manipulate blocks with their states and NBT, and combine block properties.

```{admonition} Three shapes of a block
:class: info

Functions name the shape they take or give. An **id** is `minecraft:oak_stairs`. A **state** is the compound `{id, properties}`. A **block** is the argument `setblock` takes, `minecraft:oak_stairs[facing=east]`.
```

```{pull-quote}
"Architecture is the thoughtful making of space."

-- Louis Kahn
```

---

## Functions

The following functions are available in this module.

---

### Emit particle

```{feature} bs.block:emit_particle
```

*Example: emit the particle of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_id
data modify storage bs.block:emit_particle in set value {position:"~ ~.5 ~",speed:5,count:30}
data modify storage bs.block:emit_particle in.block set from storage bs.block:get_id out
execute positioned ~ ~-1 ~ run function #bs.block:emit_particle
```

---

### Fill block

``````{tab-set}
`````{tab-item} Block

```{feature} bs.block:fill_block
```

*Example: fill a cube of stone around you*

```mcfunction
# Once
data modify storage bs.block:fill_block in set value {block:"minecraft:stone",from:"~-3 ~-3 ~-3",to:"~3 ~3 ~3"}
function #bs.block:fill_block
```

`````
`````{tab-item} Id

```{feature} bs.block:fill_id
```

*Example: turn every oak stairs around you into spruce stairs, keeping their state*

```mcfunction
# Once
data modify storage bs.block:fill_id in set value {block:"minecraft:spruce_stairs",from:"~-3 ~-3 ~-3",to:"~3 ~3 ~3",filter:"minecraft:oak_stairs"}
function #bs.block:fill_id
```

`````
``````

---

### Get attributes

``````{tab-set}
`````{tab-item} Blast resistance

````{feature} bs.block:get_blast_resistance
```{dropdown} What is Blast Resistance?
:color: info
:icon: question
Blast resistance is a numeric value used by Minecraft to determine how well a block resists explosions. Higher values mean the block is harder to destroy by TNT, creepers, or other explosions.
```
````

*Example: get the blast resistance of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_blast_resistance

# See the result
data get storage bs.block:get_blast_resistance out
```

`````
`````{tab-item} Friction

````{feature} bs.block:get_friction
```{dropdown} What is Friction?
:color: info
:icon: question
Friction is a numeric value used by Minecraft to determine how slippery a block is. For example, normal blocks like stone have a friction of `0.6`, while ice has a higher friction of `0.98`.
```
````

*Example: get the friction of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_friction

# See the result
data get storage bs.block:get_friction out
```

`````
`````{tab-item} Hardness

````{feature} bs.block:get_hardness
```{dropdown} What is Hardness?
:color: info
:icon: question
Hardness is a numeric value used by Minecraft to determine how long it takes to break a block with a tool. For example, stone has a higher hardness than dirt, and obsidian has one of the highest hardness values in the game.
```
````

*Example: get the hardness of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_hardness

# See the result
data get storage bs.block:get_hardness out
```

`````
`````{tab-item} Instrument

```{feature} bs.block:get_instrument
```

*Example: get the note block instrument of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_instrument

# See the result
data get storage bs.block:get_instrument out
```

`````
`````{tab-item} Jump factor

```{feature} bs.block:get_jump_factor
```

*Example: get the jump factor of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_jump_factor

# See the result
data get storage bs.block:get_jump_factor out
```

`````
`````{tab-item} Luminance

````{feature} bs.block:get_luminance
```{note}
The luminance can depend on the block state: a `light` block emits as much light as its level says.
```
````

*Example: get the light level emitted by the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_luminance

# See the result
data get storage bs.block:get_luminance out
```

`````
`````{tab-item} Sounds

```{feature} bs.block:get_sounds
```

*Example: get the step sound of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_sounds

# See the result
data get storage bs.block:get_sounds out.step
```

`````
`````{tab-item} Speed factor

```{feature} bs.block:get_speed_factor
```

*Example: get the speed factor of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_speed_factor

# See the result
data get storage bs.block:get_speed_factor out
```

`````
``````

---

### Get block

``````{tab-set}
`````{tab-item} Block

```{feature} bs.block:get_block
```

*Example: get the block below your feet as a block argument, ready for a setblock*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_block

# See the result
data get storage bs.block:get_block out
```

`````
`````{tab-item} Id

```{feature} bs.block:get_id
```

*Example: get the id of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_id

# See the result
data get storage bs.block:get_id out
```

`````
`````{tab-item} State

```{feature} bs.block:get_state
```

*Example: get the id and every property of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_state

# See the result
data get storage bs.block:get_state out
```

`````
``````

---

### Is touching power

``````{tab-set}
`````{tab-item} Any

```{feature} bs.block:is_touching_power
```

*Example: check whether the current position should activate a redstone mechanism*

```mcfunction
# Once
execute if function #bs.block:is_touching_power run say ACTIVATE
```

`````
`````{tab-item} Strong

```{feature} bs.block:is_touching_strong_power
```

*Example: check whether the current position is next to a strongly powered block*

```mcfunction
# Once
execute if function #bs.block:is_touching_strong_power run say STRONG
```

`````
`````{tab-item} Weak

````{feature} bs.block:is_touching_weak_power
```{admonition} Unsupported Redstone Components
:class: warning

The `trapped_chest` block is not supported by these functions. They rely on block states to determine power, and `trapped_chest` blocks do not update their block state when opened.
```
````

*Example: check whether the current position is next to a weakly powered block*

```mcfunction
# Once
execute if function #bs.block:is_touching_weak_power run say WEAK
```

`````
``````

---

### Load virtual block

``````{tab-set}
`````{tab-item} Block

```{feature} bs.block:load_block
```

*Example: load the block below your feet, then read it as a block argument*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:load_block
function #bs.block:read_block

# See the result
data get storage bs.block:read_block out
```

`````
`````{tab-item} Id

```{feature} bs.block:load_id
```

*Example: load the block below your feet with default properties*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:load_id
function #bs.block:read_block

# See the result
data get storage bs.block:read_block out
```

`````
`````{tab-item} From state

```{feature} bs.block:load_from_state
```

*Example: load oak stairs facing east*

```mcfunction
# Once
data modify storage bs.block:load_from_state in set value {block:{id:"minecraft:oak_stairs",properties:{facing:"east"}}}
function #bs.block:load_from_state
function #bs.block:read_block

# See the result
data get storage bs.block:read_block out
```

`````
`````{tab-item} From item

````{feature} bs.block:load_from_item
```{important}
Minecraft does not map items and blocks one to one. When several blocks drop the same item, this function loads one of them.
```
````

*Example: load the block dropped as a bookshelf item*

```mcfunction
# Once
data modify storage bs.block:load_from_item in set value {item:"minecraft:bookshelf"}
function #bs.block:load_from_item
function #bs.block:read_id

# See the result
data get storage bs.block:read_id out
```

`````
``````

---

### Lookup attributes

``````{tab-set}
`````{tab-item} Blast resistance

```{feature} bs.block:lookup_blast_resistance
```

*Example: get the blast resistance of obsidian*

```mcfunction
# Once
data modify storage bs.block:lookup_blast_resistance in set value {block:"minecraft:obsidian"}
function #bs.block:lookup_blast_resistance

# See the result
data get storage bs.block:lookup_blast_resistance out
```

`````
`````{tab-item} Friction

```{feature} bs.block:lookup_friction
```

*Example: get the friction of ice*

```mcfunction
# Once
data modify storage bs.block:lookup_friction in set value {block:"minecraft:ice"}
function #bs.block:lookup_friction

# See the result
data get storage bs.block:lookup_friction out
```

`````
`````{tab-item} Hardness

```{feature} bs.block:lookup_hardness
```

*Example: get the hardness of obsidian*

```mcfunction
# Once
data modify storage bs.block:lookup_hardness in set value {block:"minecraft:obsidian"}
function #bs.block:lookup_hardness

# See the result
data get storage bs.block:lookup_hardness out
```

`````
`````{tab-item} Instrument

```{feature} bs.block:lookup_instrument
```

*Example: get the note block instrument of gold blocks*

```mcfunction
# Once
data modify storage bs.block:lookup_instrument in set value {block:"minecraft:gold_block"}
function #bs.block:lookup_instrument

# See the result
data get storage bs.block:lookup_instrument out
```

`````
`````{tab-item} Jump factor

```{feature} bs.block:lookup_jump_factor
```

*Example: get the jump factor of honey blocks*

```mcfunction
# Once
data modify storage bs.block:lookup_jump_factor in set value {block:"minecraft:honey_block"}
function #bs.block:lookup_jump_factor

# See the result
data get storage bs.block:lookup_jump_factor out
```

`````
`````{tab-item} Luminance

```{feature} bs.block:lookup_luminance
```

*Example: get the light level emitted by a light block at level 7*

```mcfunction
# Once
data modify storage bs.block:lookup_luminance in set value {block:{id:"minecraft:light",properties:{level:"7"}}}
function #bs.block:lookup_luminance

# See the result
data get storage bs.block:lookup_luminance out
```

`````
`````{tab-item} Sounds

```{feature} bs.block:lookup_sounds
```

*Example: get the break sound of glass*

```mcfunction
# Once
data modify storage bs.block:lookup_sounds in set value {block:"minecraft:glass"}
function #bs.block:lookup_sounds

# See the result
data get storage bs.block:lookup_sounds out.break
```

`````
`````{tab-item} Speed factor

```{feature} bs.block:lookup_speed_factor
```

*Example: get the speed factor of soul sand*

```mcfunction
# Once
data modify storage bs.block:lookup_speed_factor in set value {block:"minecraft:soul_sand"}
function #bs.block:lookup_speed_factor

# See the result
data get storage bs.block:lookup_speed_factor out
```

`````
``````

---

### Match

```{feature} bs.block:match
```

*Example: check whether the block at 0 1 0 is oak stairs facing east, whatever their shape*

```mcfunction
# Once
data modify storage bs.block:match in set value {block:"minecraft:oak_stairs[facing=east]"}
execute positioned 0 1 0 if function #bs.block:match run say It's a match
```

---

### Modify id

``````{tab-set}
`````{tab-item} Replace

```{feature} bs.block:replace_id
```

*Example: turn oak stairs into spruce stairs, keeping their state*

```mcfunction
# Once (on oak stairs)
function #bs.block:load_block
data modify storage bs.block:replace_id in set value {block:"minecraft:spruce_stairs"}
function #bs.block:replace_id

# See the result
function #bs.block:read_block
data get storage bs.block:read_block out
```

`````
`````{tab-item} Map

```{feature} bs.block:map_id
```

*Example: turn any oak block into its spruce counterpart*

```mcfunction
# Once (on oak stairs, an oak slab, an oak fence...)
function #bs.block:load_block
data modify storage bs.block:map_id in set value {block:"minecraft:spruce_planks"}
function #bs.block:map_id

# See the result
function #bs.block:read_block
data get storage bs.block:read_block out
```

`````
`````{tab-item} Mix

````{feature} bs.block:mix_id
```{admonition} Experimental
:class: warning

Block traits are handcrafted and cannot be exhaustive: this function may behave unpredictably on blocks whose relationships are ambiguous.
```
````

*Example: mix mossy cobblestone with bricks into mossy stone bricks*

```mcfunction
# Once (on mossy cobblestone)
function #bs.block:load_block
data modify storage bs.block:mix_id in set value {block:"minecraft:bricks"}
function #bs.block:mix_id

# See the result
function #bs.block:read_block
data get storage bs.block:read_block out
```

`````
``````

---

### Modify properties

``````{tab-set}
`````{tab-item} Replace

```{feature} bs.block:replace_properties
```

*Example: make the loaded block face east*

```mcfunction
# Once (on stairs)
function #bs.block:load_block
data modify storage bs.block:replace_properties in set value {properties:{facing:"east"}}
function #bs.block:replace_properties

# See the result
function #bs.block:read_block
data get storage bs.block:read_block out
```

`````
`````{tab-item} Reset

```{feature} bs.block:reset_properties
```

*Example: reset the facing and shape of the loaded block*

```mcfunction
# Once (on stairs)
function #bs.block:load_block
data modify storage bs.block:reset_properties in set value {properties:["facing","shape"]}
function #bs.block:reset_properties

# See the result
function #bs.block:read_block
data get storage bs.block:read_block out
```

`````
`````{tab-item} Shift

```{feature} bs.block:shift_properties
```

*Example: rotate the loaded block twice*

```mcfunction
# Once (on stairs)
function #bs.block:load_block
data modify storage bs.block:shift_properties in set value {properties:[{name:"facing",by:2}]}
function #bs.block:shift_properties

# See the result
function #bs.block:read_block
data get storage bs.block:read_block out
```

`````
`````{tab-item} Merge

```{feature} bs.block:merge_properties
```

*Example: give the loaded stairs the facing of the block below your feet*

```mcfunction
# Once (on stairs)
function #bs.block:load_block
data modify storage bs.block:merge_properties in set value {properties:["facing"]}
execute positioned ~ ~-1 ~ run function #bs.block:merge_properties

# See the result
function #bs.block:read_block
data get storage bs.block:read_block out
```

`````
``````

---

### Play sound

``````{tab-set}
`````{tab-item} Break

```{feature} bs.block:play_break_sound
```

*Example: play the break sound of the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_id
data modify storage bs.block:play_break_sound in set value {source:"block"}
data modify storage bs.block:play_break_sound in.block set from storage bs.block:get_id out
function #bs.block:play_break_sound
```

`````
`````{tab-item} Fall

```{feature} bs.block:play_fall_sound
```

*Example: play the fall sound of glass*

```mcfunction
# Once
data modify storage bs.block:play_fall_sound in set value {block:"minecraft:glass",source:"block"}
function #bs.block:play_fall_sound
```

`````
`````{tab-item} Hit

```{feature} bs.block:play_hit_sound
```

*Example: play the hit sound of glass*

```mcfunction
# Once
data modify storage bs.block:play_hit_sound in set value {block:"minecraft:glass",source:"block"}
function #bs.block:play_hit_sound
```

`````
`````{tab-item} Place

```{feature} bs.block:play_place_sound
```

*Example: play the place sound of glass*

```mcfunction
# Once
data modify storage bs.block:play_place_sound in set value {block:"minecraft:glass",source:"block"}
function #bs.block:play_place_sound
```

`````
`````{tab-item} Step

```{feature} bs.block:play_step_sound
```

*Example: play the step sound of the block below your feet, at your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ run function #bs.block:get_id
data modify storage bs.block:play_step_sound in set value {source:"block",position:"~ ~1 ~"}
data modify storage bs.block:play_step_sound in.block set from storage bs.block:get_id out
execute positioned ~ ~-1 ~ run function #bs.block:play_step_sound
```

`````
``````

---

### Read virtual block

``````{tab-set}
`````{tab-item} Block

```{feature} bs.block:read_block
```

*Example: get the loaded block as a block argument, ready for a setblock*

```mcfunction
# Once
function #bs.block:load_block
function #bs.block:read_block

# See the result
data get storage bs.block:read_block out
```

`````
`````{tab-item} Id

```{feature} bs.block:read_id
```

*Example: get the id of the loaded block*

```mcfunction
# Once
function #bs.block:load_block
function #bs.block:read_id

# See the result
data get storage bs.block:read_id out
```

`````
`````{tab-item} State

```{feature} bs.block:read_state
```

*Example: get the id and every property of the loaded block*

```mcfunction
# Once
function #bs.block:load_block
function #bs.block:read_state

# See the result
data get storage bs.block:read_state out
```

`````
`````{tab-item} Item

```{feature} bs.block:read_item
```

*Example: get the item dropped by the loaded block*

```mcfunction
# Once
function #bs.block:load_block
function #bs.block:read_item

# See the result
data get storage bs.block:read_item out
```

`````
``````

---

### Set block

``````{tab-set}
`````{tab-item} Block

```{feature} bs.block:set_block
```

*Example: place stone at 0 0 0, destroying the block there*

```mcfunction
# Once
data modify storage bs.block:set_block in set value {block:"minecraft:stone",mode:"destroy"}
execute positioned 0 0 0 run function #bs.block:set_block
```

`````
`````{tab-item} Id

```{feature} bs.block:set_id
```

*Example: turn the stairs at 0 0 0 into oak stairs, keeping their state*

```mcfunction
# Once
data modify storage bs.block:set_id in set value {block:"minecraft:oak_stairs"}
execute positioned 0 0 0 run function #bs.block:set_id
```

`````
``````

---

### Spawn entity

``````{tab-set}
`````{tab-item} Block display

```{feature} bs.block:spawn_block_display
```

*Example: spawn a block display of the block at 0 0 0*

```mcfunction
# Once
execute positioned 0 0 0 run function #bs.block:get_state
data modify storage bs.block:spawn_block_display in set value {}
data modify storage bs.block:spawn_block_display in.block set from storage bs.block:get_state out
function #bs.block:spawn_block_display
```

`````
`````{tab-item} Solid block display

```{feature} bs.block:spawn_solid_block_display
```

*Example: spawn a block display with a hitbox of the block at 0 0 0*

```mcfunction
# Once
execute positioned 0 0 0 run function #bs.block:get_state
data modify storage bs.block:spawn_solid_block_display in set value {}
data modify storage bs.block:spawn_solid_block_display in.block set from storage bs.block:get_state out
function #bs.block:spawn_solid_block_display
```

`````
`````{tab-item} Falling block

```{feature} bs.block:spawn_falling_block
```

*Example: spawn a falling block of the block at 0 0 0, with no gravity*

```mcfunction
# Once
execute positioned 0 0 0 run function #bs.block:get_state
data modify storage bs.block:spawn_falling_block in set value {nbt:{NoGravity:1b}}
data modify storage bs.block:spawn_falling_block in.block set from storage bs.block:get_state out
function #bs.block:spawn_falling_block
```

`````
``````

## Predicates

The following predicates are available in this module.

---

### Is conductive

````{feature} predicate bs.block:is_conductive
```{note}
The conductivity can depend on the block state: a slab is conductive only when it is a double slab.
```
````

*Example: check whether the block below your feet conducts redstone*

```mcfunction
# Once
execute positioned ~ ~-1 ~ if predicate bs.block:is_conductive run say CONDUCTIVE
```

---

### Is powered

``````{tab-set}
`````{tab-item} Any

```{feature} predicate bs.block:is_powered
```

*Example: check whether the block below your feet is powered*

```mcfunction
# Once
execute positioned ~ ~-1 ~ if predicate bs.block:is_powered run say POWERED
```

`````
`````{tab-item} Strongly

````{feature} predicate bs.block:is_strongly_powered
```{dropdown} What is Strongly Powered?
:color: info
:icon: question
A block is strongly powered when it can power adjacent redstone dust (including redstone dust on and beneath the block), in addition to activating adjacent mechanism component, and powering redstone repeaters and redstone comparators facing away from the block.

A block becomes strongly powered by being powered by a redstone power component, a powered redstone repeater, or a powered redstone comparator.
```
````

`````
`````{tab-item} Weakly

````{feature} predicate bs.block:is_weakly_powered
```{dropdown} What is Weakly Powered?
:color: info
:icon: question
A block that is weakly powered cannot power adjacent redstone dust, but can still activate adjacent redstone mechanisms, and power redstone repeaters and redstone comparators facing away from the block.

A block becomes weakly powered when it is powered only by redstone dust.
```
````

`````
``````

---

### Is spawnable

````{feature} predicate bs.block:is_spawnable
```{note}
This does not consider the light level. The result can depend on the block state: a slab is spawnable only when it is not a bottom slab.
```
````

*Example: check whether a mob could spawn on the block below your feet*

```mcfunction
# Once
execute positioned ~ ~-1 ~ if predicate bs.block:is_spawnable run say SPAWNABLE
```

---

## Tags

The following tags are available in this module.

---

### Can occlude

```{feature} block_tag bs.block:can_occlude
```

---

### Has state

```{feature} block_tag bs.block:has_state
```

---

### Ignited by lava

```{feature} block_tag bs.block:ignited_by_lava
```

---

```{include} ../_templates/comments.md
```
