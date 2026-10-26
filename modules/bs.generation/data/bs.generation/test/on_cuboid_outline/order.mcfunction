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

# Every order does the same positions
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4,3]}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.outline bs.data matches 54
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4,3]}
function #bs.generation:on_cuboid_outline/xzy
assert score #ward.generation.outline bs.data matches 54
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4,3]}
function #bs.generation:on_cuboid_outline/yxz
assert score #ward.generation.outline bs.data matches 54
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4,3]}
function #bs.generation:on_cuboid_outline/yzx
assert score #ward.generation.outline bs.data matches 54
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4,3]}
function #bs.generation:on_cuboid_outline/zxy
assert score #ward.generation.outline bs.data matches 54
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4,3]}
function #bs.generation:on_cuboid_outline/zyx
assert score #ward.generation.outline bs.data matches 54

# The size follows the order of the function name, and a negative size goes the other way
data modify storage bs.generation:on_cuboid_outline in set value {run:"setblock ~ ~ ~ minecraft:raw_gold_block",size:[-3,3,3]}
execute positioned ~6 ~ ~6 run function #bs.generation:on_cuboid_outline/zyx
assert block ~6 ~ ~6 minecraft:raw_gold_block
assert block ~6 ~ ~4 minecraft:raw_gold_block
assert block ~8 ~2 ~4 minecraft:raw_gold_block
assert block ~7 ~1 ~6 minecraft:raw_gold_block
assert block ~7 ~1 ~4 minecraft:raw_gold_block
assert not block ~7 ~1 ~5 minecraft:raw_gold_block
assert not block ~6 ~ ~7 minecraft:raw_gold_block
