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

# Only the positions that touch the outside by a side are done, whatever the size
scoreboard players set #ward.generation.ring.size bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.size bs.data 1",size:[9,9],batch:100000}
function #bs.generation:on_ellipse_outline/xz
assert score #ward.generation.ring.size bs.data matches 24
scoreboard players set #ward.generation.ring.size bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.size bs.data 1",size:[16,5],batch:100000}
function #bs.generation:on_ellipse_outline/xz
assert score #ward.generation.ring.size bs.data matches 30
scoreboard players set #ward.generation.ring.size bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.size bs.data 1",size:[1,1],batch:100000}
function #bs.generation:on_ellipse_outline/xz
assert score #ward.generation.ring.size bs.data matches 1
scoreboard players set #ward.generation.ring.size bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.size bs.data 1",size:[2,2],batch:100000}
function #bs.generation:on_ellipse_outline/xz
assert score #ward.generation.ring.size bs.data matches 4
scoreboard players set #ward.generation.ring.size bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.size bs.data 1",size:[7,1],batch:100000}
function #bs.generation:on_ellipse_outline/xz
assert score #ward.generation.ring.size bs.data matches 7
scoreboard players set #ward.generation.ring.size bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.size bs.data 1",size:[30,30],batch:100000}
function #bs.generation:on_ellipse_outline/xz
assert score #ward.generation.ring.size bs.data matches 84

# A ring: the inside is left alone
data modify storage bs.generation:on_ellipse_outline in set value {run:"setblock ~ ~ ~ minecraft:bricks",size:[7,7],batch:100000}
function #bs.generation:on_ellipse_outline/xz
assert not block ~ ~ ~ minecraft:bricks
assert not block ~ ~ ~1 minecraft:bricks
assert block ~ ~ ~2 minecraft:bricks
assert block ~ ~ ~3 minecraft:bricks
assert block ~ ~ ~4 minecraft:bricks
assert not block ~ ~ ~5 minecraft:bricks
assert not block ~ ~ ~6 minecraft:bricks
assert not block ~1 ~ ~ minecraft:bricks
assert block ~1 ~ ~1 minecraft:bricks
assert not block ~1 ~ ~2 minecraft:bricks
assert not block ~1 ~ ~3 minecraft:bricks
assert not block ~1 ~ ~4 minecraft:bricks
assert block ~1 ~ ~5 minecraft:bricks
assert not block ~1 ~ ~6 minecraft:bricks
assert block ~2 ~ ~ minecraft:bricks
assert not block ~2 ~ ~1 minecraft:bricks
assert not block ~2 ~ ~2 minecraft:bricks
assert not block ~2 ~ ~3 minecraft:bricks
assert not block ~2 ~ ~4 minecraft:bricks
assert not block ~2 ~ ~5 minecraft:bricks
assert block ~2 ~ ~6 minecraft:bricks
assert block ~3 ~ ~ minecraft:bricks
assert not block ~3 ~ ~1 minecraft:bricks
assert not block ~3 ~ ~2 minecraft:bricks
assert not block ~3 ~ ~3 minecraft:bricks
assert not block ~3 ~ ~4 minecraft:bricks
assert not block ~3 ~ ~5 minecraft:bricks
assert block ~3 ~ ~6 minecraft:bricks
assert block ~4 ~ ~ minecraft:bricks
assert not block ~4 ~ ~1 minecraft:bricks
assert not block ~4 ~ ~2 minecraft:bricks
assert not block ~4 ~ ~3 minecraft:bricks
assert not block ~4 ~ ~4 minecraft:bricks
assert not block ~4 ~ ~5 minecraft:bricks
assert block ~4 ~ ~6 minecraft:bricks
assert not block ~5 ~ ~ minecraft:bricks
assert block ~5 ~ ~1 minecraft:bricks
assert not block ~5 ~ ~2 minecraft:bricks
assert not block ~5 ~ ~3 minecraft:bricks
assert not block ~5 ~ ~4 minecraft:bricks
assert block ~5 ~ ~5 minecraft:bricks
assert not block ~5 ~ ~6 minecraft:bricks
assert not block ~6 ~ ~ minecraft:bricks
assert not block ~6 ~ ~1 minecraft:bricks
assert block ~6 ~ ~2 minecraft:bricks
assert block ~6 ~ ~3 minecraft:bricks
assert block ~6 ~ ~4 minecraft:bricks
assert not block ~6 ~ ~5 minecraft:bricks
assert not block ~6 ~ ~6 minecraft:bricks
