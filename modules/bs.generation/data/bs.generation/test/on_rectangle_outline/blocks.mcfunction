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

scoreboard players set #ward.generation.rectangle_outline.blocks bs.data 0
data remove storage ward.generation:rectangle_outline blocks

# Lines of every length, with the last command each time
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[1,3],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 3
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[2,4],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 11
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[3,5],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 23
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[4,6],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 39
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[5,7],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 59
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[6,8],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 83
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[7,9],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 111
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[8,10],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 143
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[9,11],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 179
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks bs.data 1",size:[17,19],batch:1000000,on_finished:"data modify storage ward.generation:rectangle_outline blocks.whole append value 1b"}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.rectangle_outline.blocks bs.data matches 247
assert data storage ward.generation:rectangle_outline blocks.whole[9]

# A batch of every size under a line: each generation goes on where the tick cut it, and visits each position once
scoreboard players set #ward.generation.rectangle_outline.blocks.1 bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks.1 bs.data 1",size:[5,6],batch:1,on_finished:"data modify storage ward.generation:rectangle_outline blocks.b1 set value 1b"}
function #bs.generation:on_rectangle_outline/xz
scoreboard players set #ward.generation.rectangle_outline.blocks.2 bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks.2 bs.data 1",size:[5,6],batch:2,on_finished:"data modify storage ward.generation:rectangle_outline blocks.b2 set value 1b"}
function #bs.generation:on_rectangle_outline/xz
scoreboard players set #ward.generation.rectangle_outline.blocks.3 bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks.3 bs.data 1",size:[5,6],batch:3,on_finished:"data modify storage ward.generation:rectangle_outline blocks.b3 set value 1b"}
function #bs.generation:on_rectangle_outline/xz
scoreboard players set #ward.generation.rectangle_outline.blocks.4 bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks.4 bs.data 1",size:[9,10],batch:4,on_finished:"data modify storage ward.generation:rectangle_outline blocks.b4 set value 1b"}
function #bs.generation:on_rectangle_outline/xz
scoreboard players set #ward.generation.rectangle_outline.blocks.5 bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks.5 bs.data 1",size:[9,10],batch:5,on_finished:"data modify storage ward.generation:rectangle_outline blocks.b5 set value 1b"}
function #bs.generation:on_rectangle_outline/xz
scoreboard players set #ward.generation.rectangle_outline.blocks.6 bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks.6 bs.data 1",size:[9,10],batch:6,on_finished:"data modify storage ward.generation:rectangle_outline blocks.b6 set value 1b"}
function #bs.generation:on_rectangle_outline/xz
scoreboard players set #ward.generation.rectangle_outline.blocks.7 bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.rectangle_outline.blocks.7 bs.data 1",size:[14,10],batch:7,on_finished:"data modify storage ward.generation:rectangle_outline blocks.b7 set value 1b"}
function #bs.generation:on_rectangle_outline/xz
await data storage ward.generation:rectangle_outline blocks.b1
await data storage ward.generation:rectangle_outline blocks.b2
await data storage ward.generation:rectangle_outline blocks.b3
await data storage ward.generation:rectangle_outline blocks.b4
await data storage ward.generation:rectangle_outline blocks.b5
await data storage ward.generation:rectangle_outline blocks.b6
await data storage ward.generation:rectangle_outline blocks.b7
assert score #ward.generation.rectangle_outline.blocks.1 bs.data matches 18
assert score #ward.generation.rectangle_outline.blocks.2 bs.data matches 18
assert score #ward.generation.rectangle_outline.blocks.3 bs.data matches 18
assert score #ward.generation.rectangle_outline.blocks.4 bs.data matches 34
assert score #ward.generation.rectangle_outline.blocks.5 bs.data matches 34
assert score #ward.generation.rectangle_outline.blocks.6 bs.data matches 34
assert score #ward.generation.rectangle_outline.blocks.7 bs.data matches 44
