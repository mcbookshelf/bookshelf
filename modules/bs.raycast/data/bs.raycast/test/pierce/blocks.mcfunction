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

# a full block: entered 0.5 blocks away, left 1.5 blocks away, the exit relative to the block, going west then east
setblock ~4 ~ ~4 minecraft:stone
data modify storage bs.raycast:test d set value []
assert not run execute positioned ~5.5 ~.5 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:3,on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance",on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/distance"}}
execute positioned ~5.5 ~.5 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:3,on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/x"}}
execute positioned ~5.5 ~.5 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:3,on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/y"}}
execute positioned ~5.5 ~.5 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:3,on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/z"}}
execute positioned ~3.5 ~.5 ~4.5 rotated -90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:3,on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/x"}}
assert result 6 run data get storage bs.raycast:test d
assert result 499..501 run data get storage bs.raycast:test d[0] 1000
assert result 1499..1501 run data get storage bs.raycast:test d[1] 1000
assert result -1..1 run data get storage bs.raycast:test d[2] 1000
assert result 499..501 run data get storage bs.raycast:test d[3] 1000
assert result 499..501 run data get storage bs.raycast:test d[4] 1000
assert result 999..1001 run data get storage bs.raycast:test d[5] 1000

# on_block alone, on the full block
data modify storage bs.raycast:test log set value []
execute positioned ~5.5 ~.5 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:3,on_block:'data modify storage bs.raycast:test log append value "b"'}}
assert result 1 run data get storage bs.raycast:test log

# a stair, through its step only: one box, left 1.387 blocks away, even when on_block asks for the boxes of another block
setblock ~4 ~ ~4 minecraft:oak_stairs[facing=east]
data modify storage bs.raycast:test d set value []
execute positioned ~5.5 ~ ~4.5 facing ~-.5 ~.52 ~ run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:1.5,on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/distance"}}
execute positioned ~5.5 ~ ~4.5 facing ~-.5 ~.52 ~ run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:1.5,on_block:"execute positioned ~ ~-1 ~ run function #bs.hitbox:get_block/collision",on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/distance"}}
assert result 2 run data get storage bs.raycast:test d
assert result 1386..1388 run data get storage bs.raycast:test d[0] 1000
assert result 1386..1388 run data get storage bs.raycast:test d[1] 1000

# down through its step and its bottom: two boxes that touch, entered and left once
data modify storage bs.raycast:test log set value []
execute positioned ~4.75 ~2 ~4.5 rotated 0 90 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:1.9,on_entry:'data modify storage bs.raycast:test log append value "in"',on_exit:'data modify storage bs.raycast:test log append value "out"'}}
data modify storage bs.raycast:test x set value ["in","out"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log

# waterlogged, one entry per flag, and on_block alone sees both
setblock ~4 ~ ~4 minecraft:oak_stairs[facing=east,waterlogged=true]
data modify storage bs.raycast:test log set value []
execute positioned ~5.5 ~ ~4.5 facing ~-.5 ~.52 ~ run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision_with_fluid",max_distance:2,on_entry:'data modify storage bs.raycast:test log append value "in"'}}
execute positioned ~5.5 ~ ~4.5 facing ~-.5 ~.52 ~ run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision_with_fluid",max_distance:2,on_block:'execute if predicate bs.raycast:flag/1 if predicate bs.raycast:flag/2 run data modify storage bs.raycast:test log append value "b"'}}
data modify storage bs.raycast:test x set value ["in","in","b"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log

# an entry can stop the ray: through the water, stopped by the stair, the water entry still runs
setblock ~4 ~ ~4 minecraft:oak_stairs[facing=west,waterlogged=true]
data modify storage bs.raycast:test log set value []
assert run execute positioned ~5.5 ~.75 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision_with_fluid",max_distance:2,on_entry:'execute unless predicate bs.raycast:flag/1 run data modify storage bs.raycast:test log append value "water"'}}
data modify storage bs.raycast:test x set value ["water"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log
setblock ~4 ~ ~4 minecraft:air

# three cauldrons, through their side walls: on_block first, then each wall entered and left
setblock ~3 ~ ~4 minecraft:cauldron
setblock ~4 ~ ~4 minecraft:cauldron
setblock ~5 ~ ~4 minecraft:cauldron
data modify storage bs.raycast:test log set value []
assert not run execute positioned ~6.5 ~.5 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_block:'data modify storage bs.raycast:test log append value "b"',on_entry:'data modify storage bs.raycast:test log append value "in"',on_exit:'data modify storage bs.raycast:test log append value "out"'}}
data modify storage bs.raycast:test x set value ["b","in","out","in","out","b","in","out","in","out","b","in","out","in","out"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log

# on_block stops the ray at the second one, before its walls, and an exit stops it at the first wall
data modify storage bs.raycast:test log set value []
assert run execute positioned ~6.5 ~.5 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_block:'execute unless data storage bs.raycast:test log[0] run data modify storage bs.raycast:test log append value "b"',on_entry:'data modify storage bs.raycast:test log append value "in"'}}
assert run execute positioned ~6.5 ~.5 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_entry:'data modify storage bs.raycast:test log append value "in"',on_exit:"return 0"}}
data modify storage bs.raycast:test x set value ["b","in","in","in"]
assert not run data modify storage bs.raycast:test x set from storage bs.raycast:test log

# near a side, each wall overlaps a corner post: 4 boxes that merge into 2 shapes per cauldron
data modify storage bs.raycast:test d set value []
data modify storage bs.raycast:test e set value []
execute positioned ~6.5 ~.5 ~4.2 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance",on_exit:"data modify storage bs.raycast:test e append compute default float bs.raycast:exit/distance"}}
assert result 6 run data get storage bs.raycast:test d
assert result 6 run data get storage bs.raycast:test e
assert result 499..501 run data get storage bs.raycast:test d[0] 1000
assert result 624..626 run data get storage bs.raycast:test e[0] 1000
assert result 1374..1376 run data get storage bs.raycast:test d[1] 1000
assert result 1499..1501 run data get storage bs.raycast:test e[1] 1000

# inside a side wall: its 7 boxes merge into one shape per cauldron
data modify storage bs.raycast:test d set value []
execute positioned ~6.5 ~.5 ~4.06 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_entry:"data modify storage bs.raycast:test d append compute default float bs.raycast:entry/distance",on_exit:"data modify storage bs.raycast:test d append compute default float bs.raycast:exit/distance"}}
assert result 6 run data get storage bs.raycast:test d
assert result 499..501 run data get storage bs.raycast:test d[0] 1000
assert result 1499..1501 run data get storage bs.raycast:test d[1] 1000
assert result 1499..1501 run data get storage bs.raycast:test d[2] 1000
assert result 2499..2501 run data get storage bs.raycast:test d[3] 1000
assert result 2499..2501 run data get storage bs.raycast:test d[4] 1000
assert result 3499..3501 run data get storage bs.raycast:test d[5] 1000

# at the height of the floor, the floor and both walls merge into one shape per cauldron
data modify storage bs.raycast:test log set value []
execute positioned ~6.5 ~.22 ~4.5 rotated 90 0 run function #bs.raycast:pierce.in {with:{blocks:"#bs.hitbox:get_block/collision",max_distance:4,on_entry:'data modify storage bs.raycast:test log append value "in"'}}
assert result 3 run data get storage bs.raycast:test log
