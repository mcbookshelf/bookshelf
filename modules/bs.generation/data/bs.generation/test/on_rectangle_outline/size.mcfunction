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

# Only the edge of the rectangle is done: its inside is left alone
data modify storage bs.generation:on_rectangle_outline in set value {run:"setblock ~ ~ ~ minecraft:granite",size:[4,3]}
function #bs.generation:on_rectangle_outline/xz
assert block ~ ~ ~ minecraft:granite
assert block ~3 ~ ~ minecraft:granite
assert block ~ ~ ~2 minecraft:granite
assert block ~3 ~ ~2 minecraft:granite
assert block ~1 ~ ~ minecraft:granite
assert block ~ ~ ~1 minecraft:granite
assert block ~3 ~ ~1 minecraft:granite
assert block ~2 ~ ~2 minecraft:granite
assert not block ~1 ~ ~1 minecraft:granite
assert not block ~2 ~ ~1 minecraft:granite
assert not block ~4 ~ ~ minecraft:granite
assert not block ~ ~1 ~ minecraft:granite

# Each position of the edge is done once, whatever the size
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[4,3]}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.outline bs.data matches 10
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[5,5]}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.outline bs.data matches 16
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[2,2]}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.outline bs.data matches 4
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[1,1]}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.outline bs.data matches 1
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[1,4]}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.outline bs.data matches 4
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[4,1]}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.outline bs.data matches 4
scoreboard players set #ward.generation.outline bs.data 0
data modify storage bs.generation:on_rectangle_outline in set value {run:"scoreboard players add #ward.generation.outline bs.data 1",size:[2,5]}
function #bs.generation:on_rectangle_outline/xz
assert score #ward.generation.outline bs.data matches 10
