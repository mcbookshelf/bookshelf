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

scoreboard players set #ward.generation.cuboid.blocks bs.data 0
data remove storage ward.generation:cuboid blocks

# Lines of every length, with the last command each time
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[1,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 4
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[2,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 12
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[3,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 24
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[4,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 40
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[5,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 60
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[6,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 84
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[7,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 112
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[8,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 144
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[9,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 180
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks bs.data 1",size:[17,2,2],batch:1000000,on_finished:"data modify storage ward.generation:cuboid blocks.whole append value 1b"}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.blocks bs.data matches 248
assert data storage ward.generation:cuboid blocks.whole[9]

# A batch of every size under a line: each generation goes on where the tick cut it, and visits each position once
scoreboard players set #ward.generation.cuboid.blocks.1 bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks.1 bs.data 1",size:[5,2,2],batch:1,on_finished:"data modify storage ward.generation:cuboid blocks.b1 set value 1b"}
function #bs.generation:on_cuboid/xyz
scoreboard players set #ward.generation.cuboid.blocks.2 bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks.2 bs.data 1",size:[5,2,2],batch:2,on_finished:"data modify storage ward.generation:cuboid blocks.b2 set value 1b"}
function #bs.generation:on_cuboid/xyz
scoreboard players set #ward.generation.cuboid.blocks.3 bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks.3 bs.data 1",size:[5,2,2],batch:3,on_finished:"data modify storage ward.generation:cuboid blocks.b3 set value 1b"}
function #bs.generation:on_cuboid/xyz
scoreboard players set #ward.generation.cuboid.blocks.4 bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks.4 bs.data 1",size:[9,2,2],batch:4,on_finished:"data modify storage ward.generation:cuboid blocks.b4 set value 1b"}
function #bs.generation:on_cuboid/xyz
scoreboard players set #ward.generation.cuboid.blocks.5 bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks.5 bs.data 1",size:[9,2,2],batch:5,on_finished:"data modify storage ward.generation:cuboid blocks.b5 set value 1b"}
function #bs.generation:on_cuboid/xyz
scoreboard players set #ward.generation.cuboid.blocks.6 bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks.6 bs.data 1",size:[9,2,2],batch:6,on_finished:"data modify storage ward.generation:cuboid blocks.b6 set value 1b"}
function #bs.generation:on_cuboid/xyz
scoreboard players set #ward.generation.cuboid.blocks.7 bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"scoreboard players add #ward.generation.cuboid.blocks.7 bs.data 1",size:[9,2,2],batch:7,on_finished:"data modify storage ward.generation:cuboid blocks.b7 set value 1b"}
function #bs.generation:on_cuboid/xyz
await data storage ward.generation:cuboid blocks.b1
await data storage ward.generation:cuboid blocks.b2
await data storage ward.generation:cuboid blocks.b3
await data storage ward.generation:cuboid blocks.b4
await data storage ward.generation:cuboid blocks.b5
await data storage ward.generation:cuboid blocks.b6
await data storage ward.generation:cuboid blocks.b7
assert score #ward.generation.cuboid.blocks.1 bs.data matches 20
assert score #ward.generation.cuboid.blocks.2 bs.data matches 20
assert score #ward.generation.cuboid.blocks.3 bs.data matches 20
assert score #ward.generation.cuboid.blocks.4 bs.data matches 36
assert score #ward.generation.cuboid.blocks.5 bs.data matches 36
assert score #ward.generation.cuboid.blocks.6 bs.data matches 36
assert score #ward.generation.cuboid.blocks.7 bs.data matches 36
