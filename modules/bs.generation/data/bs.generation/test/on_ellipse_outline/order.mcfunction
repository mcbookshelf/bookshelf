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

# The size follows the order of the axes
data modify storage bs.generation:on_ellipse_outline in set value {run:"setblock ~ ~ ~ minecraft:sandstone",size:[6,5],batch:100000}
function #bs.generation:on_ellipse_outline/zy
assert not block ~ ~ ~ minecraft:sandstone
assert block ~ ~1 ~ minecraft:sandstone
assert block ~ ~2 ~ minecraft:sandstone
assert block ~ ~3 ~ minecraft:sandstone
assert not block ~ ~4 ~ minecraft:sandstone
assert block ~ ~ ~1 minecraft:sandstone
assert not block ~ ~1 ~1 minecraft:sandstone
assert not block ~ ~2 ~1 minecraft:sandstone
assert not block ~ ~3 ~1 minecraft:sandstone
assert block ~ ~4 ~1 minecraft:sandstone
assert block ~ ~ ~2 minecraft:sandstone
assert not block ~ ~1 ~2 minecraft:sandstone
assert not block ~ ~2 ~2 minecraft:sandstone
assert not block ~ ~3 ~2 minecraft:sandstone
assert block ~ ~4 ~2 minecraft:sandstone
assert block ~ ~ ~3 minecraft:sandstone
assert not block ~ ~1 ~3 minecraft:sandstone
assert not block ~ ~2 ~3 minecraft:sandstone
assert not block ~ ~3 ~3 minecraft:sandstone
assert block ~ ~4 ~3 minecraft:sandstone
assert block ~ ~ ~4 minecraft:sandstone
assert not block ~ ~1 ~4 minecraft:sandstone
assert not block ~ ~2 ~4 minecraft:sandstone
assert not block ~ ~3 ~4 minecraft:sandstone
assert not block ~ ~ ~5 minecraft:sandstone
assert block ~ ~1 ~5 minecraft:sandstone
assert block ~ ~2 ~5 minecraft:sandstone
assert block ~ ~3 ~5 minecraft:sandstone
assert not block ~ ~4 ~5 minecraft:sandstone
assert block ~ ~4 ~4 minecraft:sandstone

# Every order goes over the same positions
scoreboard players set #ward.generation.ring.order bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.order bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse_outline/xy
assert score #ward.generation.ring.order bs.data matches 18
scoreboard players set #ward.generation.ring.order bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.order bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse_outline/yx
assert score #ward.generation.ring.order bs.data matches 18
scoreboard players set #ward.generation.ring.order bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.order bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse_outline/yz
assert score #ward.generation.ring.order bs.data matches 18
scoreboard players set #ward.generation.ring.order bs.data 0
data modify storage bs.generation:on_ellipse_outline in set value {run:"scoreboard players add #ward.generation.ring.order bs.data 1",size:[9,6],batch:100000}
function #bs.generation:on_ellipse_outline/zx
assert score #ward.generation.ring.order bs.data matches 18
