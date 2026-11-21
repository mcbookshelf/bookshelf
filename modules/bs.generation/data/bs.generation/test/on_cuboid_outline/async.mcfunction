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

# One position each tick: the lines that are cut by a tick go on where they stopped
scoreboard players set #ward.generation.outline.async bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline.async bs.data 1",size:[4,4,4],batch:1}
function #bs.generation:on_cuboid_outline/zxy
assert score #ward.generation.outline.async bs.data matches 1
await delay 20t
assert score #ward.generation.outline.async bs.data matches 2..55
await delay 50t
assert score #ward.generation.outline.async bs.data matches 56

# A few positions each tick, with the inside still left alone
data remove storage ward.generation:outline out
data modify storage bs.generation:on_cuboid_outline in set value {run:"setblock ~ ~ ~ minecraft:diorite",size:[4,3,4],batch:3,on_finished:"data modify storage ward.generation:outline out.finished set value 1b"}
function #bs.generation:on_cuboid_outline/xyz
assert not block ~3 ~2 ~3 minecraft:diorite
await data storage ward.generation:outline out.finished
assert block ~3 ~2 ~3 minecraft:diorite
assert block ~1 ~1 ~ minecraft:diorite
assert block ~ ~1 ~2 minecraft:diorite
assert not block ~1 ~1 ~1 minecraft:diorite
assert not block ~2 ~1 ~2 minecraft:diorite
