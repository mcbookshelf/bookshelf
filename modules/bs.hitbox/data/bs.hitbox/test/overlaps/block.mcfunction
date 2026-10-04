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

data modify storage bs.hitbox:overlaps/block in set value {blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized"}

# A cow is 0.9 wide and 1.4 high: in a full block when it sinks in, not when it stands on it
setblock ~ ~ ~ minecraft:stone strict
summon minecraft:cow ~.5 ~.5 ~.5 {Tags:["ward.hitbox.cow.sunk"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow.sunk] run assert result 1 run function #bs.hitbox:overlaps/block
execute as @n[tag=ward.hitbox.cow.sunk] run assert result 1 run function bs.hitbox:overlaps/block/cube/custom
summon minecraft:cow ~.5 ~1 ~.5 {Tags:["ward.hitbox.cow.standing"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow.standing] run assert result 0 run function #bs.hitbox:overlaps/block
execute as @n[tag=ward.hitbox.cow.standing] run assert result 0 run function bs.hitbox:overlaps/block/cube/custom
summon minecraft:cow ~1.5 ~.5 ~.5 {Tags:["ward.hitbox.cow.beside"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow.beside] run assert result 0 run function #bs.hitbox:overlaps/block
execute as @n[tag=ward.hitbox.cow.beside] run assert result 0 run function bs.hitbox:overlaps/block/cube/custom
summon minecraft:cow ~1.4 ~.5 ~.5 {Tags:["ward.hitbox.cow.edge"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow.edge] run assert result 1 run function #bs.hitbox:overlaps/block
execute as @n[tag=ward.hitbox.cow.edge] run assert result 1 run function bs.hitbox:overlaps/block/cube/custom
summon minecraft:cow ~.5 ~-1.4 ~.5 {Tags:["ward.hitbox.cow.below"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow.below] run assert result 0 run function #bs.hitbox:overlaps/block
execute as @n[tag=ward.hitbox.cow.below] run assert result 0 run function bs.hitbox:overlaps/block/cube/custom
kill @e[tag=ward.hitbox.cow.sunk]
kill @e[tag=ward.hitbox.cow.standing]
kill @e[tag=ward.hitbox.cow.beside]
kill @e[tag=ward.hitbox.cow.edge]
kill @e[tag=ward.hitbox.cow.below]

# A slab only holds its lower half
setblock ~ ~ ~ minecraft:stone_slab strict
summon minecraft:cow ~.5 ~.5 ~.5 {Tags:["ward.hitbox.cow.slab_on"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow.slab_on] run assert result 0 run function #bs.hitbox:overlaps/block
summon minecraft:cow ~.5 ~.4 ~.5 {Tags:["ward.hitbox.cow.slab_in"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow.slab_in] run assert result 1 run function #bs.hitbox:overlaps/block
kill @e[tag=ward.hitbox.cow.slab_on]
kill @e[tag=ward.hitbox.cow.slab_in]

# Flags come from the box the cow overlaps, and no block box means no overlap
setblock ~ ~ ~ minecraft:water strict
summon minecraft:cow ~.5 ~.5 ~.5 {Tags:["ward.hitbox.cow.water"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow.water] run assert result 0 run function #bs.hitbox:overlaps/block
data modify storage bs.hitbox:overlaps/block in.blocks set value "#bs.hitbox:get_block/collision_with_fluid"
execute as @n[tag=ward.hitbox.cow.water] run assert result 1 run function #bs.hitbox:overlaps/block
setblock ~ ~ ~ minecraft:air strict
execute as @n[tag=ward.hitbox.cow.water] run assert result 0 run function #bs.hitbox:overlaps/block

# Flags combine: a cow sunk in a waterlogged slab overlaps its solid part and its water, one on it only the water
setblock ~ ~ ~ minecraft:stone_slab[waterlogged=true] strict
summon minecraft:cow ~.5 ~.4 ~.5 {Tags:["ward.hitbox.cow.slab_water"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow.slab_water] run assert result 1 run function #bs.hitbox:overlaps/block
execute as @n[tag=ward.hitbox.cow.water] run assert result 1 run function #bs.hitbox:overlaps/block

# An entity provider giving no box leaves the entity out
setblock ~ ~ ~ minecraft:stone strict
data modify storage bs.hitbox:overlaps/block in.entities set value "#bs.hitbox:get_entity/solid"
execute as @n[tag=ward.hitbox.cow.water] run assert result 0 run function #bs.hitbox:overlaps/block
execute as @n[tag=ward.hitbox.cow.water] run assert result 0 run function bs.hitbox:overlaps/block/cube/custom

# Every box counts, up to 24 for the block and 8 for the entity
data modify storage bs.hitbox: rel set value [-.5d,-.5d,-.5d]
scoreboard players set #i bs.ctx 0
scoreboard players set #j bs.ctx 0
scoreboard players set #k bs.ctx 0
scoreboard players set #m bs.ctx 8
scoreboard players set #n bs.ctx 24
data modify storage bs.hitbox:get_entity out set value [[10f,10f,10f,11f,11f,11f],[10f,10f,10f,11f,11f,11f],[10f,10f,10f,11f,11f,11f],[10f,10f,10f,11f,11f,11f],[10f,10f,10f,11f,11f,11f],[10f,10f,10f,11f,11f,11f],[10f,10f,10f,11f,11f,11f],[-.25f,-.25f,-.25f,.25f,.25f,.25f]]
data modify storage bs.hitbox:get_block out set value [[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[0d,0d,0d,1d,1d,1d,1d]]
assert predicate bs.hitbox:_overlaps/overlap
assert predicate bs.hitbox:_overlaps/cube
data modify storage bs.hitbox:get_block out[23] set value [5d,5d,5d,6d,6d,6d,1d]
execute if predicate bs.hitbox:_overlaps/overlap run fail "no block box overlaps the entity"
data modify storage bs.hitbox:get_entity out[7] set value [10f,10f,10f,11f,11f,11f]
execute if predicate bs.hitbox:_overlaps/cube run fail "no entity box overlaps the full block"

# Boxes past the ones a provider gave are left out
data modify storage bs.hitbox:get_entity out set value [[10f,10f,10f,11f,11f,11f],[-.25f,-.25f,-.25f,.25f,.25f,.25f]]
data modify storage bs.hitbox:get_block out set value [[5d,5d,5d,6d,6d,6d,1d],[0d,0d,0d,1d,1d,1d,1d]]
scoreboard players set #m bs.ctx 1
scoreboard players set #n bs.ctx 2
execute if predicate bs.hitbox:_overlaps/overlap run fail "a box past the count of the entity is checked"
scoreboard players set #m bs.ctx 2
scoreboard players set #n bs.ctx 1
execute if predicate bs.hitbox:_overlaps/overlap run fail "a box past the count of the block is checked"

# An entity with no hitbox is in no block
data modify storage bs.hitbox:overlaps/block in set value {blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized"}
setblock ~ ~ ~ minecraft:stone strict
summon minecraft:armor_stand ~.5 ~.5 ~.5 {Tags:["ward.hitbox.armor_stand.marker"],Marker:1b}
execute as @n[tag=ward.hitbox.armor_stand.marker] run assert result 0 run function #bs.hitbox:overlaps/block
execute as @n[tag=ward.hitbox.armor_stand.marker] run assert result 0 run function bs.hitbox:overlaps/block/cube/custom
