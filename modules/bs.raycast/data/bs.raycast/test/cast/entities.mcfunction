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

# two armor stands in a column, the first one 2.3 blocks above the ray
summon minecraft:armor_stand ~4.5 ~2.3 ~4.5 {NoGravity:1b,Tags:["bs.raycast.test"]}
summon minecraft:armor_stand ~4.5 ~5 ~4.5 {NoGravity:1b,Tags:["bs.raycast.test"]}

# an entity stops the ray, with or without a selector, within the max distance only
assert run execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test"}}
assert run execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",max_distance:3}}
assert not run execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",max_distance:2.2}}

# the entry, at the feet of the first one: its distance, and the point relative to the feet
data modify storage bs.raycast:test d set value []
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance"}}
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",on_entity:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/x"}}
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",on_entity:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/y"}}
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",on_entity:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/z"}}
assert result 4 run data get storage bs.raycast:test d
assert result 2299..2301 run data get storage bs.raycast:test d[0] 1000
assert result -1..1 run data get storage bs.raycast:test d[1] 1000
assert result -1..1 run data get storage bs.raycast:test d[2] 1000
assert result -1..1 run data get storage bs.raycast:test d[3] 1000

# with blocks, the nearest one: a slab below it, a slab in the same block before its feet, then a slab after its feet
data modify storage bs.raycast:test log set value []
setblock ~4 ~1 ~4 minecraft:oak_slab
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",on_block:'data modify storage bs.raycast:test log append value "b"',on_entity:'data modify storage bs.raycast:test log append value "e"'}}
setblock ~4 ~1 ~4 minecraft:air
setblock ~4 ~2 ~4 minecraft:oak_slab
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",on_block:'data modify storage bs.raycast:test log append value "b"',on_entity:'data modify storage bs.raycast:test log append value "e"'}}
setblock ~4 ~2 ~4 minecraft:oak_slab[type=top]
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"#bs.hitbox:get_entity/sized",selector:"tag=bs.raycast.test",on_block:'data modify storage bs.raycast:test log append value "b"',on_entity:'data modify storage bs.raycast:test log append value "e"'}}
data modify storage bs.raycast:test x set value ["b","b","e"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log
setblock ~4 ~2 ~4 minecraft:air
kill @e[type=minecraft:armor_stand,tag=bs.raycast.test]

# a custom box, from a provider that keeps the boxes set here: alone, then behind a slab and in front of another
summon minecraft:interaction ~4.5 ~2 ~4.5 {Tags:["bs.raycast.test"]}
data modify storage bs.hitbox:get_entity out set value [[-.3f,.3f,-.3f,.3f,.5f,.3f,1f]]
assert run execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test"}}
data modify storage bs.raycast:test log set value []
setblock ~4 ~1 ~4 minecraft:oak_slab
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",on_block:'data modify storage bs.raycast:test log append value "b"',on_entity:'data modify storage bs.raycast:test log append value "e"'}}
setblock ~4 ~1 ~4 minecraft:air
setblock ~4 ~2 ~4 minecraft:oak_slab[type=top]
execute positioned ~4.5 ~ ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",on_block:'data modify storage bs.raycast:test log append value "b"',on_entity:'data modify storage bs.raycast:test log append value "e"'}}
data modify storage bs.raycast:test x set value ["b","e"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log
setblock ~4 ~2 ~4 minecraft:air
kill @e[type=minecraft:interaction,tag=bs.raycast.test]

# an unbounded entity 4.5 blocks above the ray: its box hangs down onto it
summon minecraft:interaction ~4.5 ~5.5 ~4.5 {Tags:["bs.raycast.test","bs.hitbox.unbounded"]}
data modify storage bs.hitbox:get_entity out set value [[-.3f,-5f,-.3f,.3f,-4f,.3f,1f]]
assert run execute positioned ~4.05 ~1 ~4.5 rotated -90 0 run function #bs.raycast:cast.in {with:{entities:"bs.raycast:test/none",selector:"tag=bs.raycast.test",max_distance:.9}}
kill @e[type=minecraft:interaction,tag=bs.raycast.test]
