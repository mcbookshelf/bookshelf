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

scoreboard players set #ward.generation.ellipsoid.blocks bs.data 0
data remove storage ward.generation:ellipsoid blocks

# Lines of every length, with the last command each time
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks bs.data 1",size:[16,16,3],batch:1000000,on_finished:"data modify storage ward.generation:ellipsoid blocks.whole append value 1b"}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.ellipsoid.blocks bs.data matches 432
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks bs.data 1",size:[17,17,3],batch:1000000,on_finished:"data modify storage ward.generation:ellipsoid blocks.whole append value 1b"}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.ellipsoid.blocks bs.data matches 915
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks bs.data 1",size:[5,5,1],batch:1000000,on_finished:"data modify storage ward.generation:ellipsoid blocks.whole append value 1b"}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.ellipsoid.blocks bs.data matches 936
assert data storage ward.generation:ellipsoid blocks.whole[2]

# A batch of every size under a line: each generation goes on where the tick cut it, and visits each position once
scoreboard players set #ward.generation.ellipsoid.blocks.1 bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks.1 bs.data 1",size:[5,5,3],batch:1,on_finished:"data modify storage ward.generation:ellipsoid blocks.b1 set value 1b"}
function #bs.generation:on_ellipsoid/xyz
scoreboard players set #ward.generation.ellipsoid.blocks.2 bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks.2 bs.data 1",size:[5,5,3],batch:2,on_finished:"data modify storage ward.generation:ellipsoid blocks.b2 set value 1b"}
function #bs.generation:on_ellipsoid/xyz
scoreboard players set #ward.generation.ellipsoid.blocks.3 bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks.3 bs.data 1",size:[5,5,3],batch:3,on_finished:"data modify storage ward.generation:ellipsoid blocks.b3 set value 1b"}
function #bs.generation:on_ellipsoid/xyz
scoreboard players set #ward.generation.ellipsoid.blocks.4 bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks.4 bs.data 1",size:[13,7,3],batch:4,on_finished:"data modify storage ward.generation:ellipsoid blocks.b4 set value 1b"}
function #bs.generation:on_ellipsoid/xyz
scoreboard players set #ward.generation.ellipsoid.blocks.5 bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks.5 bs.data 1",size:[13,7,3],batch:5,on_finished:"data modify storage ward.generation:ellipsoid blocks.b5 set value 1b"}
function #bs.generation:on_ellipsoid/xyz
scoreboard players set #ward.generation.ellipsoid.blocks.6 bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks.6 bs.data 1",size:[13,7,3],batch:6,on_finished:"data modify storage ward.generation:ellipsoid blocks.b6 set value 1b"}
function #bs.generation:on_ellipsoid/xyz
scoreboard players set #ward.generation.ellipsoid.blocks.7 bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.ellipsoid.blocks.7 bs.data 1",size:[13,7,3],batch:7,on_finished:"data modify storage ward.generation:ellipsoid blocks.b7 set value 1b"}
function #bs.generation:on_ellipsoid/xyz
await data storage ward.generation:ellipsoid blocks.b1
await data storage ward.generation:ellipsoid blocks.b2
await data storage ward.generation:ellipsoid blocks.b3
await data storage ward.generation:ellipsoid blocks.b4
await data storage ward.generation:ellipsoid blocks.b5
await data storage ward.generation:ellipsoid blocks.b6
await data storage ward.generation:ellipsoid blocks.b7
assert score #ward.generation.ellipsoid.blocks.1 bs.data matches 39
assert score #ward.generation.ellipsoid.blocks.2 bs.data matches 39
assert score #ward.generation.ellipsoid.blocks.3 bs.data matches 39
assert score #ward.generation.ellipsoid.blocks.4 bs.data matches 157
assert score #ward.generation.ellipsoid.blocks.5 bs.data matches 157
assert score #ward.generation.ellipsoid.blocks.6 bs.data matches 157
assert score #ward.generation.ellipsoid.blocks.7 bs.data matches 157
