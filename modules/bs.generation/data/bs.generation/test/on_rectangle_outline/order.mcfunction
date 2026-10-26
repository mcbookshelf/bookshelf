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

# Every order does the same number of positions
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4]}
function #bs.generation:on_rectangle_outline/xy
assert score #ward.generation.outline bs.data matches 14
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4]}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.outline bs.data matches 14
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4]}
function #bs.generation:on_rectangle_outline/yx
assert score #ward.generation.outline bs.data matches 14
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4]}
function #bs.generation:on_rectangle_outline/yz
assert score #ward.generation.outline bs.data matches 14
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4]}
function #bs.generation:on_rectangle_outline/zx
assert score #ward.generation.outline bs.data matches 14
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,4]}
function #bs.generation:on_rectangle_outline/zy
assert score #ward.generation.outline bs.data matches 14

# The size follows the order of the function name, and a negative size goes the other way
data modify storage bs.generation:on_rectangle_outline in set value {run:"setblock ~ ~ ~ minecraft:copper_block",size:[3,-4]}
execute positioned ~6 ~ ~ run function #bs.generation:on_rectangle_outline/yx
assert block ~6 ~ ~ minecraft:copper_block
assert block ~3 ~ ~ minecraft:copper_block
assert block ~6 ~2 ~ minecraft:copper_block
assert block ~3 ~2 ~ minecraft:copper_block
assert block ~5 ~2 ~ minecraft:copper_block
assert block ~3 ~1 ~ minecraft:copper_block
assert not block ~5 ~1 ~ minecraft:copper_block
assert not block ~4 ~1 ~ minecraft:copper_block
assert not block ~7 ~ ~ minecraft:copper_block

# One position each tick: the lines that are cut by a tick go on where they stopped
scoreboard players set #ward.generation.outline.edge bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline.edge bs.data 1",size:[4,4],batch:1}
function #bs.generation:on_rectangle_outline/zx
await delay 20t
assert score #ward.generation.outline.edge bs.data matches 12
