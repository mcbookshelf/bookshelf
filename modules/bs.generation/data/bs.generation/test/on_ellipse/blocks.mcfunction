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

scoreboard players set #ward.generation.ellipse.blocks bs.data 0
data remove storage ward.generation:ellipse blocks

# Lines of every length, with the last command each time
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks bs.data 1",size:[16,16],batch:1000000,on_finished:"data modify storage ward.generation:ellipse blocks.whole append value 1b"}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.ellipse.blocks bs.data matches 208
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks bs.data 1",size:[17,17],batch:1000000,on_finished:"data modify storage ward.generation:ellipse blocks.whole append value 1b"}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.ellipse.blocks bs.data matches 433
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks bs.data 1",size:[2,10],batch:1000000,on_finished:"data modify storage ward.generation:ellipse blocks.whole append value 1b"}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.ellipse.blocks bs.data matches 449
assert data storage ward.generation:ellipse blocks.whole[2]

# A batch of every size under a line: each generation goes on where the tick cut it, and visits each position once
scoreboard players set #ward.generation.ellipse.blocks.1 bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks.1 bs.data 1",size:[5,9],batch:1,on_finished:"data modify storage ward.generation:ellipse blocks.b1 set value 1b"}
function #bs.generation:on_ellipse/xz
scoreboard players set #ward.generation.ellipse.blocks.2 bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks.2 bs.data 1",size:[5,9],batch:2,on_finished:"data modify storage ward.generation:ellipse blocks.b2 set value 1b"}
function #bs.generation:on_ellipse/xz
scoreboard players set #ward.generation.ellipse.blocks.3 bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks.3 bs.data 1",size:[5,9],batch:3,on_finished:"data modify storage ward.generation:ellipse blocks.b3 set value 1b"}
function #bs.generation:on_ellipse/xz
scoreboard players set #ward.generation.ellipse.blocks.4 bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks.4 bs.data 1",size:[17,9],batch:4,on_finished:"data modify storage ward.generation:ellipse blocks.b4 set value 1b"}
function #bs.generation:on_ellipse/xz
scoreboard players set #ward.generation.ellipse.blocks.5 bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks.5 bs.data 1",size:[17,9],batch:5,on_finished:"data modify storage ward.generation:ellipse blocks.b5 set value 1b"}
function #bs.generation:on_ellipse/xz
scoreboard players set #ward.generation.ellipse.blocks.6 bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks.6 bs.data 1",size:[17,9],batch:6,on_finished:"data modify storage ward.generation:ellipse blocks.b6 set value 1b"}
function #bs.generation:on_ellipse/xz
scoreboard players set #ward.generation.ellipse.blocks.7 bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"scoreboard players add #ward.generation.ellipse.blocks.7 bs.data 1",size:[17,9],batch:7,on_finished:"data modify storage ward.generation:ellipse blocks.b7 set value 1b"}
function #bs.generation:on_ellipse/xz
await data storage ward.generation:ellipse blocks.b1
await data storage ward.generation:ellipse blocks.b2
await data storage ward.generation:ellipse blocks.b3
await data storage ward.generation:ellipse blocks.b4
await data storage ward.generation:ellipse blocks.b5
await data storage ward.generation:ellipse blocks.b6
await data storage ward.generation:ellipse blocks.b7
assert score #ward.generation.ellipse.blocks.1 bs.data matches 37
assert score #ward.generation.ellipse.blocks.2 bs.data matches 37
assert score #ward.generation.ellipse.blocks.3 bs.data matches 37
assert score #ward.generation.ellipse.blocks.4 bs.data matches 121
assert score #ward.generation.ellipse.blocks.5 bs.data matches 121
assert score #ward.generation.ellipse.blocks.6 bs.data matches 121
assert score #ward.generation.ellipse.blocks.7 bs.data matches 121
