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

# a full block, hit from each side: by that face, entered at 1 or 0 along the ray relative to the block, and the block along the ray
setblock ~4 ~4 ~4 minecraft:stone
data modify storage bs.raycast:test d set value []
data modify storage bs.raycast:test b set value []
execute positioned ~6.5 ~4.5 ~4.5 rotated 90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage bs.raycast:test b append compute default integer bs.raycast:block/x",on_entry:'execute if predicate bs.raycast:face/east run data modify storage bs.raycast:test d append compute default float bs.raycast:entry/x'}}
execute positioned ~2.5 ~4.5 ~4.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage bs.raycast:test b append compute default integer bs.raycast:block/x",on_entry:'execute if predicate bs.raycast:face/west run data modify storage bs.raycast:test d append compute default float bs.raycast:entry/x'}}
execute positioned ~4.5 ~4.5 ~6.5 rotated 180 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage bs.raycast:test b append compute default integer bs.raycast:block/z",on_entry:'execute if predicate bs.raycast:face/south run data modify storage bs.raycast:test d append compute default float bs.raycast:entry/z'}}
execute positioned ~4.5 ~4.5 ~2.5 rotated 0 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage bs.raycast:test b append compute default integer bs.raycast:block/z",on_entry:'execute if predicate bs.raycast:face/north run data modify storage bs.raycast:test d append compute default float bs.raycast:entry/z'}}
execute positioned ~4.5 ~6.5 ~4.5 rotated 0 90 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage bs.raycast:test b append compute default integer bs.raycast:block/y",on_entry:'execute if predicate bs.raycast:face/top run data modify storage bs.raycast:test d append compute default float bs.raycast:entry/y'}}
execute positioned ~4.5 ~2.5 ~4.5 rotated 0 -90 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_block:"data modify storage bs.raycast:test b append compute default integer bs.raycast:block/y",on_entry:'execute if predicate bs.raycast:face/bottom run data modify storage bs.raycast:test d append compute default float bs.raycast:entry/y'}}
assert result 6 run data get storage bs.raycast:test d
assert result 999..1001 run data get storage bs.raycast:test d[0] 1000
assert result -1..1 run data get storage bs.raycast:test d[1] 1000
assert result 999..1001 run data get storage bs.raycast:test d[2] 1000
assert result -1..1 run data get storage bs.raycast:test d[3] 1000
assert result 999..1001 run data get storage bs.raycast:test d[4] 1000
assert result -1..1 run data get storage bs.raycast:test d[5] 1000
summon minecraft:marker ~4 ~4 ~4 {Tags:["bs.raycast.test.block"]}
data modify storage bs.raycast:test x set value [0,0,0,0,0,0]
execute store result storage bs.raycast:test x[0] int 1 store result storage bs.raycast:test x[1] int 1 run data get entity @n[type=minecraft:marker,tag=bs.raycast.test.block] Pos[0]
execute store result storage bs.raycast:test x[2] int 1 store result storage bs.raycast:test x[3] int 1 run data get entity @n[type=minecraft:marker,tag=bs.raycast.test.block] Pos[2]
execute store result storage bs.raycast:test x[4] int 1 store result storage bs.raycast:test x[5] int 1 run data get entity @n[type=minecraft:marker,tag=bs.raycast.test.block] Pos[1]
kill @n[type=minecraft:marker,tag=bs.raycast.test.block]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test b

# the face is 1.5 blocks away: the max distance reaches it but no further, and without blocks the ray goes through
assert run execute positioned ~6.5 ~4.5 ~4.5 rotated 90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:1.5}}
assert not run execute positioned ~6.5 ~4.5 ~4.5 rotated 90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:1.4}}
assert not run execute positioned ~6.5 ~4.5 ~4.5 rotated 90 0 run function #bs.raycast:cast.in {with:{}}

# the arguments can come from storage too
data modify storage bs.raycast:cast in set value {blocks:"#bs.hitbox:get_block/collision"}
assert run execute positioned ~6.5 ~4.5 ~4.5 rotated 90 0 run function #bs.raycast:cast

# across the ray, the entry is in the middle of the face, and the face is 1.5 blocks away
data modify storage bs.raycast:test d set value []
execute positioned ~2.5 ~4.5 ~4.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/y"}}
execute positioned ~2.5 ~4.5 ~4.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/z"}}
execute positioned ~2.5 ~4.5 ~4.5 rotated -90 0 run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance"}}
assert result 3 run data get storage bs.raycast:test d
assert result 499..501 run data get storage bs.raycast:test d[0] 1000
assert result 499..501 run data get storage bs.raycast:test d[1] 1000
assert result 1499..1501 run data get storage bs.raycast:test d[2] 1000

# a stair: the ray enters its step by the east face, 0.72 blocks away, and passes over it from the other side
setblock ~4 ~4 ~4 minecraft:oak_stairs[facing=east]
data modify storage bs.raycast:test d set value []
execute positioned ~5.5 ~4 ~4.5 facing ~-.5 ~.52 ~ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",on_entry:'execute if predicate bs.raycast:face/east run data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance'}}
assert result 1 run data get storage bs.raycast:test d
assert result 719..721 run data get storage bs.raycast:test d[0] 1000
assert not run execute positioned ~3.5 ~4 ~4.5 facing ~.5 ~.52 ~ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:4}}

# the flag of the nearest entry: the water (2) in front of a stair facing west, the stair (1) when it faces east
setblock ~4 ~4 ~4 minecraft:oak_stairs[facing=west,waterlogged=true]
data modify storage bs.raycast:test log set value []
execute positioned ~5.5 ~4 ~4.5 facing ~-.5 ~.52 ~ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision_with_fluid",on_entry:'execute if predicate bs.raycast:flag/2 unless predicate bs.raycast:flag/1 run data modify storage bs.raycast:test log append value 1b'}}
setblock ~4 ~4 ~4 minecraft:oak_stairs[facing=east,waterlogged=true]
execute positioned ~5.5 ~4 ~4.5 facing ~-.5 ~.52 ~ run function #bs.raycast:cast.in {with:{blocks:"#bs.hitbox:get_block/collision_with_fluid",on_entry:'execute if predicate bs.raycast:flag/1 unless predicate bs.raycast:flag/2 run data modify storage bs.raycast:test log append value 1b'}}
assert result 2 run data get storage bs.raycast:test log
