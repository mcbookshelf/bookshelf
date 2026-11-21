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

scoreboard players set #ward.generation.rectangle.blocks bs.data 0
data remove storage ward.generation:rectangle blocks

# Lines of every length, with the last command each time
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[1,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 2
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[2,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 6
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[3,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 12
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[4,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 20
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[5,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 30
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[6,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 42
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[7,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 56
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[8,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 72
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[9,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 90
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks bs.data 1",size:[17,2],batch:1000000,on_finished:"data modify storage ward.generation:rectangle blocks.whole append value 1b"}
function #bs.generation:on_rectangle/xz
assert score #ward.generation.rectangle.blocks bs.data matches 124
assert data storage ward.generation:rectangle blocks.whole[9]

# A batch of every size under a line: each generation goes on where the tick cut it, and visits each position once
scoreboard players set #ward.generation.rectangle.blocks.1 bs.data 0
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks.1 bs.data 1",size:[5,3],batch:1,on_finished:"data modify storage ward.generation:rectangle blocks.b1 set value 1b"}
function #bs.generation:on_rectangle/xz
scoreboard players set #ward.generation.rectangle.blocks.2 bs.data 0
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks.2 bs.data 1",size:[5,3],batch:2,on_finished:"data modify storage ward.generation:rectangle blocks.b2 set value 1b"}
function #bs.generation:on_rectangle/xz
scoreboard players set #ward.generation.rectangle.blocks.3 bs.data 0
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks.3 bs.data 1",size:[5,3],batch:3,on_finished:"data modify storage ward.generation:rectangle blocks.b3 set value 1b"}
function #bs.generation:on_rectangle/xz
scoreboard players set #ward.generation.rectangle.blocks.4 bs.data 0
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks.4 bs.data 1",size:[9,4],batch:4,on_finished:"data modify storage ward.generation:rectangle blocks.b4 set value 1b"}
function #bs.generation:on_rectangle/xz
scoreboard players set #ward.generation.rectangle.blocks.5 bs.data 0
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks.5 bs.data 1",size:[9,4],batch:5,on_finished:"data modify storage ward.generation:rectangle blocks.b5 set value 1b"}
function #bs.generation:on_rectangle/xz
scoreboard players set #ward.generation.rectangle.blocks.6 bs.data 0
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks.6 bs.data 1",size:[9,4],batch:6,on_finished:"data modify storage ward.generation:rectangle blocks.b6 set value 1b"}
function #bs.generation:on_rectangle/xz
scoreboard players set #ward.generation.rectangle.blocks.7 bs.data 0
data modify storage bs.generation:on_rectangle in set value {run:"scoreboard players add #ward.generation.rectangle.blocks.7 bs.data 1",size:[9,4],batch:7,on_finished:"data modify storage ward.generation:rectangle blocks.b7 set value 1b"}
function #bs.generation:on_rectangle/xz
await data storage ward.generation:rectangle blocks.b1
await data storage ward.generation:rectangle blocks.b2
await data storage ward.generation:rectangle blocks.b3
await data storage ward.generation:rectangle blocks.b4
await data storage ward.generation:rectangle blocks.b5
await data storage ward.generation:rectangle blocks.b6
await data storage ward.generation:rectangle blocks.b7
assert score #ward.generation.rectangle.blocks.1 bs.data matches 15
assert score #ward.generation.rectangle.blocks.2 bs.data matches 15
assert score #ward.generation.rectangle.blocks.3 bs.data matches 15
assert score #ward.generation.rectangle.blocks.4 bs.data matches 36
assert score #ward.generation.rectangle.blocks.5 bs.data matches 36
assert score #ward.generation.rectangle.blocks.6 bs.data matches 36
assert score #ward.generation.rectangle.blocks.7 bs.data matches 36
