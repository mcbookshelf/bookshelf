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

# @template ward:empty/9x9x9

# two armor stands in a column
summon minecraft:armor_stand ~4.5 ~2 ~4.5 {NoGravity:1b,Tags:["bs.raycast.test"]}
summon minecraft:armor_stand ~4.5 ~5 ~4.5 {NoGravity:1b,Tags:["bs.raycast.test"]}

# one after the other: on_entity, then the entry and the exit
data modify storage bs.raycast:test log set value []
assert not run execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",max_distance:8,on_entity:'data modify storage bs.raycast:test log append value "e"',on_entry:'data modify storage bs.raycast:test log append value "in"',on_exit:'data modify storage bs.raycast:test log append value "out"'}}
data modify storage bs.raycast:test x set value ["e","in","out","e","in","out"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log

# the first one is left at its top, 3.975 blocks away, 1.975 blocks above its feet
data modify storage bs.raycast:test d set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",max_distance:4,on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/distance"}}
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",max_distance:4,on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/y"}}
assert result 2 run data get storage bs.raycast:test d
assert result 3974..3976 run data get storage bs.raycast:test d[0] 1000
assert result 1974..1976 run data get storage bs.raycast:test d[1] 1000

# with a slab below each one, in order, then on_entity stops the ray at the first one
setblock ~4 ~1 ~4 minecraft:oak_slab
setblock ~4 ~4 ~4 minecraft:oak_slab
data modify storage bs.raycast:test log set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",max_distance:8,on_block:'data modify storage bs.raycast:test log append value "b"',on_entity:'data modify storage bs.raycast:test log append value "e"'}}
assert run execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",max_distance:8,on_block:'data modify storage bs.raycast:test log append value "b"',on_entity:"return 0"}}
data modify storage bs.raycast:test x set value ["b","e","b","e","b"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log
kill @e[type=minecraft:armor_stand,tag=bs.raycast.test]
fill ~4 ~ ~4 ~4 ~8 ~4 minecraft:air

# two armor stands found in the same block, behind a slab in that block: each entry in order
setblock ~4 ~2 ~4 minecraft:oak_slab
summon minecraft:armor_stand ~4.5 ~2.6 ~4.5 {NoGravity:1b,Tags:["bs.raycast.test"]}
summon minecraft:armor_stand ~4.5 ~2.8 ~4.5 {NoGravity:1b,Tags:["bs.raycast.test"]}
data modify storage bs.raycast:test d set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",max_distance:8,on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance"}}
assert result 3 run data get storage bs.raycast:test d
assert result 1999..2001 run data get storage bs.raycast:test d[0] 1000
assert result 2599..2601 run data get storage bs.raycast:test d[1] 1000
assert result 2799..2801 run data get storage bs.raycast:test d[2] 1000
kill @e[type=minecraft:armor_stand,tag=bs.raycast.test]
setblock ~4 ~2 ~4 minecraft:air

# entities of different sizes: each one keeps its own box
summon minecraft:armor_stand ~4.5 ~2 ~4.5 {NoGravity:1b,Tags:["bs.raycast.test"]}
summon minecraft:villager ~4.5 ~5 ~4.5 {NoAI:1b,Silent:1b,NoGravity:1b,Tags:["bs.raycast.test"]}
data modify storage bs.raycast:test d set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",max_distance:8,on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/distance"}}
assert result 2 run data get storage bs.raycast:test d
assert result 3974..3976 run data get storage bs.raycast:test d[0] 1000
assert result 6949..6951 run data get storage bs.raycast:test d[1] 1000
kill @e[tag=bs.raycast.test]

# custom boxes, from a provider that keeps the boxes set here
summon minecraft:interaction ~4.5 ~2 ~4.5 {Tags:["bs.raycast.test"]}

# one box, then behind a slab
data modify storage bs.hitbox:get_entity out set value [[-.3f,0f,-.3f,.3f,.5f,.3f,1f]]
data modify storage bs.raycast:test log set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",max_distance:4,on_entity:'data modify storage bs.raycast:test log append value "e"',on_entry:'data modify storage bs.raycast:test log append value "in"',on_exit:'data modify storage bs.raycast:test log append value "out"'}}
setblock ~4 ~1 ~4 minecraft:oak_slab
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",max_distance:4,on_block:'data modify storage bs.raycast:test log append value "b"',on_entity:'data modify storage bs.raycast:test log append value "e"'}}
setblock ~4 ~1 ~4 minecraft:air
data modify storage bs.raycast:test x set value ["e","in","out","b","e"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log

# two then three boxes that touch, with the same flag: one shape
data modify storage bs.hitbox:get_entity out set value [[-.3f,0f,-.3f,.3f,.5f,.3f,1f],[-.3f,.5f,-.3f,.3f,1f,.3f,1f]]
data modify storage bs.raycast:test log set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",max_distance:4,on_entry:'data modify storage bs.raycast:test log append value "in"',on_exit:'data modify storage bs.raycast:test log append value "out"'}}
data modify storage bs.hitbox:get_entity out append value [-.3f,1f,-.3f,.3f,1.5f,.3f,1f]
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",max_distance:4,on_entry:'data modify storage bs.raycast:test log append value "in"',on_exit:'data modify storage bs.raycast:test log append value "out"'}}
data modify storage bs.raycast:test x set value ["in","out","in","out"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log

# the same boxes with the flags 1 and 2: two shapes, half a block apart, and on_entity sees both flags
data modify storage bs.hitbox:get_entity out set value [[-.3f,0f,-.3f,.3f,.5f,.3f,1f],[-.3f,.5f,-.3f,.3f,1f,.3f,2f]]
data modify storage bs.raycast:test log set value []
data modify storage bs.raycast:test d set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",max_distance:4,on_entity:'execute if predicate bs.raycast:flag/1 if predicate bs.raycast:flag/2 run data modify storage bs.raycast:test log append value "e"',on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance"}}
assert result 1 run data get storage bs.raycast:test log
assert result 2 run data get storage bs.raycast:test d
assert result 1999..2001 run data get storage bs.raycast:test d[0] 1000
assert result 2499..2501 run data get storage bs.raycast:test d[1] 1000

# three boxes: two that overlap with the flag 4, one apart with the flag 8, merged into two shapes
data modify storage bs.hitbox:get_entity out set value [[-.3f,0f,-.3f,.3f,.3f,.3f,4f],[-.3f,.2f,-.3f,.3f,.5f,.3f,4f],[-.3f,.7f,-.3f,.3f,.9f,.3f,8f]]
data modify storage bs.raycast:test log set value []
data modify storage bs.raycast:test d set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",max_distance:4,on_entity:'execute if predicate bs.raycast:flag/4 if predicate bs.raycast:flag/8 run data modify storage bs.raycast:test log append value "e"',on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance",on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/distance"}}
assert result 1 run data get storage bs.raycast:test log
assert result 4 run data get storage bs.raycast:test d
assert result 1999..2001 run data get storage bs.raycast:test d[0] 1000
assert result 2499..2501 run data get storage bs.raycast:test d[1] 1000
assert result 2699..2701 run data get storage bs.raycast:test d[2] 1000
assert result 2899..2901 run data get storage bs.raycast:test d[3] 1000

# eight boxes out of order, overlapping in places: four shapes, each entered then left
data modify storage bs.hitbox:get_entity out set value [[-.3f,.8f,-.3f,.3f,.9f,.3f,1f],[-.3f,0f,-.3f,.3f,.1f,.3f,1f],[-.3f,.45f,-.3f,.3f,.55f,.3f,1f],[-.3f,.3f,-.3f,.3f,.4f,.3f,1f],[-.3f,.85f,-.3f,.3f,1f,.3f,1f],[-.3f,.7f,-.3f,.3f,.75f,.3f,1f],[-.3f,.05f,-.3f,.3f,.2f,.3f,1f],[-.3f,.35f,-.3f,.3f,.5f,.3f,1f]]
data modify storage bs.raycast:test d set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:pierce.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",max_distance:4,on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance",on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/distance"}}
assert result 8 run data get storage bs.raycast:test d
assert result 1999..2001 run data get storage bs.raycast:test d[0] 1000
assert result 2199..2201 run data get storage bs.raycast:test d[1] 1000
assert result 2299..2301 run data get storage bs.raycast:test d[2] 1000
assert result 2549..2551 run data get storage bs.raycast:test d[3] 1000
assert result 2699..2701 run data get storage bs.raycast:test d[4] 1000
assert result 2749..2751 run data get storage bs.raycast:test d[5] 1000
assert result 2799..2801 run data get storage bs.raycast:test d[6] 1000
assert result 2999..3001 run data get storage bs.raycast:test d[7] 1000
kill @e[type=minecraft:interaction,tag=bs.raycast.test]

# an unbounded entity 4.5 blocks above the ray: its box hangs down onto it
summon minecraft:interaction ~4.5 ~5.5 ~4.5 {Tags:["bs.raycast.test","bs.hitbox.unbounded"]}
data modify storage bs.hitbox:get_entity out set value [[-.3f,-5f,-.3f,.3f,-4f,.3f,1f]]
data modify storage bs.raycast:test log set value []
execute positioned ~4.05 ~1 ~4.5 rotated -90 0 run function #bs.raycast:pierce.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",max_distance:.9,on_entity:'data modify storage bs.raycast:test log append value "e"',on_entry:'data modify storage bs.raycast:test log append value "in"',on_exit:'data modify storage bs.raycast:test log append value "out"'}}
data modify storage bs.raycast:test x set value ["e","in","out"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log
kill @e[type=minecraft:interaction,tag=bs.raycast.test]
