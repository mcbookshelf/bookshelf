# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

# @dummy
# @skyaccess true

# Players
function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.3f,0f,-0.3f,0.3f,1.8f,0.3f,1f]
dummy @s sneak true
await delay 1t
function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.3f,0f,-0.3f,0.3f,1.5f,0.3f,1f]
dummy @s sneak false
await delay 1t

# Scaled by the scale attribute
attribute @s minecraft:scale base set 2
function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.6f,0f,-0.6f,0.6f,3.6f,0.6f,1f]

# Babies
summon minecraft:cow ~ ~ ~ {Tags:["ward.hitbox.cow.baby"],Age:-24000}
execute as @n[tag=ward.hitbox.cow.baby] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.225f,0f,-0.225f,0.225f,0.7f,0.225f,1f]

# Scale changes are seen right away
summon minecraft:creeper ~ ~ ~ {Tags:["ward.hitbox.creeper"],attributes:[{id:"minecraft:scale",base:0.5d}]}
execute as @n[tag=ward.hitbox.creeper] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.15f,0f,-0.15f,0.15f,0.85f,0.15f,1f]
attribute @n[tag=ward.hitbox.creeper] minecraft:scale base set 1
execute as @n[tag=ward.hitbox.creeper] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.3f,0f,-0.3f,0.3f,1.7f,0.3f,1f]

# Entities without attributes
execute summon minecraft:oak_boat run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.6875f,0f,-0.6875f,0.6875f,0.5625f,0.6875f,1f]

# Cubes by their size
summon minecraft:slime ~ ~ ~ {Tags:["ward.hitbox.slime"],Size:3}
execute as @n[tag=ward.hitbox.slime] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-1.04f,0f,-1.04f,1.04f,2.08f,1.04f,1f]

# Entities sharing a single side with a sleeping one are not asleep
summon minecraft:salmon ~ ~ ~ {Tags:["ward.hitbox.salmon.small"],type:"small"}
execute as @n[tag=ward.hitbox.salmon.small] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.175f,0f,-0.175f,0.175f,0.2f,0.175f,1f]

# Sleeping entities, whatever their scale
setblock ~ ~ ~3 minecraft:red_bed[part=head,facing=south]
summon minecraft:villager ~ ~ ~3 {Tags:["ward.hitbox.villager.sleeping"],NoAI:1b}
data modify storage bs.hitbox: pos set value [I;0,0,0]
execute store result storage bs.hitbox: pos[0] int 1 run data get entity @n[tag=ward.hitbox.villager.sleeping] Pos[0]
execute store result storage bs.hitbox: pos[1] int 1 run data get entity @n[tag=ward.hitbox.villager.sleeping] Pos[1]
execute store result storage bs.hitbox: pos[2] int 1 run data get entity @n[tag=ward.hitbox.villager.sleeping] Pos[2]
data modify entity @n[tag=ward.hitbox.villager.sleeping] sleeping_pos set from storage bs.hitbox: pos
attribute @n[tag=ward.hitbox.villager.sleeping] minecraft:scale base set 2
execute as @n[tag=ward.hitbox.villager.sleeping] run function #bs.hitbox:get_entity/sized
assert not run data modify storage bs.hitbox:get_entity out[0] set value [-0.1f,0f,-0.1f,0.1f,0.2f,0.1f,1f]

# Providers keep only the entities of their set: boats are solid, pushable and targetable
summon minecraft:oak_boat ~ ~ ~ {Tags:["ward.hitbox.oak_boat.set"]}
execute as @n[tag=ward.hitbox.oak_boat.set] run assert result 1 run function #bs.hitbox:get_entity/solid
execute as @n[tag=ward.hitbox.oak_boat.set] run assert result 1 run function #bs.hitbox:get_entity/pushable
execute as @n[tag=ward.hitbox.oak_boat.set] run assert result 1 run function #bs.hitbox:get_entity/targetable
execute as @n[tag=ward.hitbox.oak_boat.set] run assert result 0 run function #bs.hitbox:get_entity/living
execute as @n[tag=ward.hitbox.oak_boat.set] run assert not predicate bs.hitbox:get_entity/living

# Mobs are pushable and targetable, not solid
summon minecraft:cow ~ ~ ~ {Tags:["ward.hitbox.cow.set"]}
execute as @n[tag=ward.hitbox.cow.set] run assert result 0 run function #bs.hitbox:get_entity/solid
execute as @n[tag=ward.hitbox.cow.set] run assert result 1 run function #bs.hitbox:get_entity/pushable
execute as @n[tag=ward.hitbox.cow.set] run assert result 1 run function #bs.hitbox:get_entity/targetable
execute as @n[tag=ward.hitbox.cow.set] run assert predicate bs.hitbox:get_entity/targetable
execute as @n[tag=ward.hitbox.cow.set] run assert not predicate bs.hitbox:get_entity/solid
execute as @n[tag=ward.hitbox.cow.set] run assert result 1 run function #bs.hitbox:get_entity/living
execute as @n[tag=ward.hitbox.cow.set] run assert predicate bs.hitbox:get_entity/living

# Adult happy ghasts are solid, babies are not
summon minecraft:happy_ghast ~ ~ ~ {Tags:["ward.hitbox.happy_ghast.set"]}
execute as @n[tag=ward.hitbox.happy_ghast.set] run assert result 1 run function #bs.hitbox:get_entity/solid
execute as @n[tag=ward.hitbox.happy_ghast.set] run assert predicate bs.hitbox:get_entity/solid
summon minecraft:happy_ghast ~ ~ ~ {Tags:["ward.hitbox.happy_ghast.baby"],Age:-24000}
execute as @n[tag=ward.hitbox.happy_ghast.baby] run assert result 0 run function #bs.hitbox:get_entity/solid
execute as @n[tag=ward.hitbox.happy_ghast.baby] run assert not predicate bs.hitbox:get_entity/solid

# Hanging entities are only targetable
summon minecraft:item_frame ~ ~ ~ {Tags:["ward.hitbox.item_frame.set"],Facing:1b}
execute as @n[tag=ward.hitbox.item_frame.set] run assert result 0 run function #bs.hitbox:get_entity/pushable
execute as @n[tag=ward.hitbox.item_frame.set] run assert result 1 run function #bs.hitbox:get_entity/targetable

# Marker armor stands have an empty box
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.hitbox.armor_stand.set"],Marker:1b}
execute as @n[tag=ward.hitbox.armor_stand.set] run assert result 0 run function #bs.hitbox:get_entity/sized
execute as @n[tag=ward.hitbox.armor_stand.set] run assert result 0 run function #bs.hitbox:get_entity/targetable

# Clouds are none of them, but still have a box
summon minecraft:area_effect_cloud ~ ~ ~ {Tags:["ward.hitbox.area_effect_cloud.set"]}
execute as @n[tag=ward.hitbox.area_effect_cloud.set] run assert result 0 run function #bs.hitbox:get_entity/targetable

# Spectators have an empty box
gamemode spectator @s
assert result 0 run function #bs.hitbox:get_entity/sized
assert result 0 run function #bs.hitbox:get_entity/targetable
assert result 0 run function #bs.hitbox:get_entity/pushable
assert result 0 run function #bs.hitbox:get_entity/living
assert not predicate bs.hitbox:get_entity/sized
assert not predicate bs.hitbox:get_entity/targetable
assert not predicate bs.hitbox:get_entity/pushable
assert not predicate bs.hitbox:get_entity/living
