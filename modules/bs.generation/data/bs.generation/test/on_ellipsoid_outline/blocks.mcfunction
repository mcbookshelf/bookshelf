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

scoreboard players set #ward.generation.ellipsoid_outline.blocks bs.data 0
data remove storage ward.generation:ellipsoid_outline blocks

# Lines of every length, with the last command each time
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks bs.data 1",size:[16,16,5],batch:1000000,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.whole append value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
assert score #ward.generation.ellipsoid_outline.blocks bs.data matches 372
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks bs.data 1",size:[17,17,5],batch:1000000,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.whole append value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
assert score #ward.generation.ellipsoid_outline.blocks bs.data matches 790
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks bs.data 1",size:[33,33,3],batch:1000000,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.whole append value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
assert score #ward.generation.ellipsoid_outline.blocks bs.data matches 2132
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks bs.data 1",size:[2,5,5],batch:1000000,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.whole append value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
assert score #ward.generation.ellipsoid_outline.blocks bs.data matches 2158
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks bs.data 1",size:[5,5,1],batch:1000000,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.whole append value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
assert score #ward.generation.ellipsoid_outline.blocks bs.data matches 2179
assert data storage ward.generation:ellipsoid_outline blocks.whole[4]

# A batch of every size under a line: each generation goes on where the tick cut it, and visits each position once
scoreboard players set #ward.generation.ellipsoid_outline.blocks.1 bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks.1 bs.data 1",size:[5,5,5],batch:1,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.b1 set value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
scoreboard players set #ward.generation.ellipsoid_outline.blocks.2 bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks.2 bs.data 1",size:[5,5,5],batch:2,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.b2 set value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
scoreboard players set #ward.generation.ellipsoid_outline.blocks.3 bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks.3 bs.data 1",size:[5,5,5],batch:3,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.b3 set value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
scoreboard players set #ward.generation.ellipsoid_outline.blocks.4 bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks.4 bs.data 1",size:[17,9,5],batch:4,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.b4 set value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
scoreboard players set #ward.generation.ellipsoid_outline.blocks.5 bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks.5 bs.data 1",size:[17,9,5],batch:5,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.b5 set value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
scoreboard players set #ward.generation.ellipsoid_outline.blocks.6 bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks.6 bs.data 1",size:[17,9,5],batch:6,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.b6 set value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
scoreboard players set #ward.generation.ellipsoid_outline.blocks.7 bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.ellipsoid_outline.blocks.7 bs.data 1",size:[17,9,5],batch:7,on_finished:"data modify storage ward.generation:ellipsoid_outline blocks.b7 set value 1b"}
function #bs.generation:on_ellipsoid_outline/xyz
await data storage ward.generation:ellipsoid_outline blocks.b1
await data storage ward.generation:ellipsoid_outline blocks.b2
await data storage ward.generation:ellipsoid_outline blocks.b3
await data storage ward.generation:ellipsoid_outline blocks.b4
await data storage ward.generation:ellipsoid_outline blocks.b5
await data storage ward.generation:ellipsoid_outline blocks.b6
await data storage ward.generation:ellipsoid_outline blocks.b7
assert score #ward.generation.ellipsoid_outline.blocks.1 bs.data matches 54
assert score #ward.generation.ellipsoid_outline.blocks.2 bs.data matches 54
assert score #ward.generation.ellipsoid_outline.blocks.3 bs.data matches 54
assert score #ward.generation.ellipsoid_outline.blocks.4 bs.data matches 234
assert score #ward.generation.ellipsoid_outline.blocks.5 bs.data matches 234
assert score #ward.generation.ellipsoid_outline.blocks.6 bs.data matches 234
assert score #ward.generation.ellipsoid_outline.blocks.7 bs.data matches 234
