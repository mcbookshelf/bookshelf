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

data modify storage bs.hitbox:overlaps in set value {blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized"}

# A cow is 0.9 wide and 1.4 high: it reaches the blocks around its own, touching faces left out
# Each check runs both ways: from the real hitbox, then from the boxes of the provider
fill ~-2 ~-1 ~-2 ~2 ~3 ~2 minecraft:air strict
summon minecraft:cow ~.5 ~ ~.5 {Tags:["ward.hitbox.cow"],NoAI:1b,NoGravity:1b}
execute as @n[tag=ward.hitbox.cow] run assert result 0 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 0 run function bs.hitbox:overlaps/blocks/custom
setblock ~ ~-1 ~ minecraft:stone strict
setblock ~1 ~ ~ minecraft:stone strict
setblock ~ ~2 ~ minecraft:stone strict
execute as @n[tag=ward.hitbox.cow] run assert result 0 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 0 run function bs.hitbox:overlaps/blocks/custom
setblock ~ ~1 ~ minecraft:stone strict
execute as @n[tag=ward.hitbox.cow] run assert result 1 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 1 run function bs.hitbox:overlaps/blocks/custom
setblock ~ ~1 ~ minecraft:air strict
tp @n[tag=ward.hitbox.cow] ~.6 ~ ~.5
execute as @n[tag=ward.hitbox.cow] run assert result 1 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 1 run function bs.hitbox:overlaps/blocks/custom
tp @n[tag=ward.hitbox.cow] ~.5 ~ ~-.4
execute as @n[tag=ward.hitbox.cow] run assert result 0 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 0 run function bs.hitbox:overlaps/blocks/custom
setblock ~1 ~1 ~-1 minecraft:stone strict
execute as @n[tag=ward.hitbox.cow] run assert result 0 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 0 run function bs.hitbox:overlaps/blocks/custom
setblock ~ ~1 ~-1 minecraft:stone strict
execute as @n[tag=ward.hitbox.cow] run assert result 1 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 1 run function bs.hitbox:overlaps/blocks/custom

# A slab only holds its lower half
fill ~-2 ~-1 ~-2 ~2 ~3 ~2 minecraft:air strict
tp @n[tag=ward.hitbox.cow] ~.5 ~.5 ~.5
setblock ~ ~ ~ minecraft:stone_slab strict
execute as @n[tag=ward.hitbox.cow] run assert result 0 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 0 run function bs.hitbox:overlaps/blocks/custom
setblock ~ ~1 ~ minecraft:stone_slab strict
execute as @n[tag=ward.hitbox.cow] run assert result 1 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 1 run function bs.hitbox:overlaps/blocks/custom

# A block with a shape offset the cow reaches without touching it leaves the next cells right
fill ~-2 ~-1 ~-2 ~2 ~3 ~2 minecraft:air strict
tp @n[tag=ward.hitbox.cow] ~1.4 ~.5 ~.5
setblock ~ ~ ~ minecraft:bamboo strict
setblock ~1 ~ ~ minecraft:stone_slab strict
execute as @n[tag=ward.hitbox.cow] run assert result 0 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 0 run function bs.hitbox:overlaps/blocks/custom
setblock ~1 ~1 ~ minecraft:stone_slab strict
execute as @n[tag=ward.hitbox.cow] run assert result 1 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 1 run function bs.hitbox:overlaps/blocks/custom
tp @n[tag=ward.hitbox.cow] ~.5 ~.5 ~.5

# The fluid counts with a provider that gives it, and an entity provider giving no box leaves the entity out
fill ~-2 ~-1 ~-2 ~2 ~3 ~2 minecraft:air strict
setblock ~ ~1 ~ minecraft:water strict
execute as @n[tag=ward.hitbox.cow] run assert result 0 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 0 run function bs.hitbox:overlaps/blocks/custom
data modify storage bs.hitbox:overlaps in.blocks set value "#bs.hitbox:get_block/collision_with_fluid"
execute as @n[tag=ward.hitbox.cow] run assert result 1 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 1 run function bs.hitbox:overlaps/blocks/custom
data modify storage bs.hitbox:overlaps in.entities set value "#bs.hitbox:get_entity/solid"
execute as @n[tag=ward.hitbox.cow] run assert result 0 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.cow] at @s run assert result 0 run function bs.hitbox:overlaps/blocks/custom
data modify storage bs.hitbox:overlaps in set value {blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized"}

# The cells to check enclose every box of the entity, counted from its own cell
data modify storage bs.hitbox: rel set value [-.5d,-.5d,-.5d]
data modify storage bs.hitbox:get_entity out set value [[-.25f,0f,-.25f,.25f,.5f,.25f,1f],[-.25f,2.2f,-1.25f,.25f,2.7f,.25f,1f]]
scoreboard players set #m bs.ctx 2
assert result 0 run compute default integer bs.hitbox:_overlaps/blocks/min_x
assert result 0 run compute default integer bs.hitbox:_overlaps/blocks/min_y
assert result -1 run compute default integer bs.hitbox:_overlaps/blocks/min_z
assert result 0 run compute default integer bs.hitbox:_overlaps/blocks/max_x
assert result 3 run compute default integer bs.hitbox:_overlaps/blocks/max_y
assert result 0 run compute default integer bs.hitbox:_overlaps/blocks/max_z

# A full block in a cell only counts when a box of the entity reaches the cell
data modify storage bs.hitbox:get_block out set value 1
scoreboard players set #i bs.ctx 0
scoreboard players set #j bs.ctx 3
scoreboard players set #k bs.ctx 0
assert result 1 run function bs.hitbox:overlaps/blocks/custom/block
scoreboard players set #j bs.ctx 1
assert result 0 run function bs.hitbox:overlaps/blocks/custom/block

# A shape is checked in its cell, up to 24 boxes
scoreboard players set #i bs.ctx 1
scoreboard players set #j bs.ctx 0
scoreboard players set #m bs.ctx 1
data modify storage bs.hitbox:get_entity out set value [[1.25f,.25f,.25f,1.75f,.75f,.75f,1f]]
data modify storage bs.hitbox:get_block out set value [[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[5d,5d,5d,6d,6d,6d,1d],[0d,0d,0d,1d,1d,1d,1d]]
assert result 1 run function bs.hitbox:overlaps/blocks/custom/block
assert result 1 run function bs.hitbox:overlaps/blocks/hitbox/block
scoreboard players set #i bs.ctx 0
assert result 0 run function bs.hitbox:overlaps/blocks/custom/block
assert result 0 run function bs.hitbox:overlaps/blocks/hitbox/block

# An entity with no hitbox is in no block
data modify storage bs.hitbox:overlaps in set value {blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized"}
setblock ~ ~ ~ minecraft:stone strict
summon minecraft:armor_stand ~.5 ~.5 ~.5 {Tags:["ward.hitbox.armor_stand.marker"],Marker:1b}
execute as @n[tag=ward.hitbox.armor_stand.marker] run assert result 0 run function #bs.hitbox:overlaps/blocks
execute as @n[tag=ward.hitbox.armor_stand.marker] at @s run assert result 0 run function bs.hitbox:overlaps/blocks/custom
