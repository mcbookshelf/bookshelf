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

data remove storage ward.generation:cuboid out

# Positions past the batch wait for the next ticks, and the last command runs at the end
data modify storage bs.generation:on_cuboid in set value {run:"setblock ~ ~ ~ minecraft:stone",size:[2,1,2],batch:1,on_finished:"data modify storage ward.generation:cuboid out.finished set value 1b"}
function #bs.generation:on_cuboid/xyz
assert block ~ ~ ~ minecraft:stone
assert not block ~1 ~ ~ minecraft:stone
await block ~1 ~ ~ minecraft:stone
assert not block ~ ~ ~1 minecraft:stone
await block ~ ~ ~1 minecraft:stone
assert not block ~1 ~ ~1 minecraft:stone
assert not data storage ward.generation:cuboid out.finished
await block ~1 ~ ~1 minecraft:stone
await data storage ward.generation:cuboid out.finished

# A command can start another generation: it starts at the next tick
data modify storage bs.generation:on_rectangle in set value {run:"setblock ~ ~ ~ minecraft:gold_block",size:[2,1]}
data modify storage bs.generation:on_cuboid in set value {run:"execute positioned ~ ~3 ~ run function #bs.generation:on_rectangle/xz",size:[2,1,1]}
function #bs.generation:on_cuboid/xyz
assert not block ~ ~3 ~ minecraft:gold_block
await delay 1t
assert block ~ ~3 ~ minecraft:gold_block
assert block ~2 ~3 ~ minecraft:gold_block

# A list left over from a tick the game interrupted does not block the next generation
data modify storage bs.generation: tasks set value [{}]
scoreboard players set #generation.tick bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"setblock ~ ~ ~ minecraft:iron_block",size:[1,1,1]}
execute positioned ~ ~5 ~ run function #bs.generation:on_cuboid/xyz
assert block ~ ~5 ~ minecraft:iron_block
