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
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"setblock ~ ~ ~ minecraft:deepslate",size:[6,3,5],batch:100000}
function #bs.generation:on_ellipsoid_outline/zxy
assert not block ~ ~ ~ minecraft:deepslate
assert not block ~ ~1 ~ minecraft:deepslate
assert not block ~ ~2 ~ minecraft:deepslate
assert not block ~ ~3 ~ minecraft:deepslate
assert not block ~ ~4 ~ minecraft:deepslate
assert not block ~1 ~ ~ minecraft:deepslate
assert block ~1 ~1 ~ minecraft:deepslate
assert block ~1 ~2 ~ minecraft:deepslate
assert block ~1 ~3 ~ minecraft:deepslate
assert not block ~1 ~4 ~ minecraft:deepslate
assert not block ~2 ~ ~ minecraft:deepslate
assert not block ~2 ~1 ~ minecraft:deepslate
assert not block ~2 ~2 ~ minecraft:deepslate
assert not block ~2 ~3 ~ minecraft:deepslate
assert not block ~2 ~4 ~ minecraft:deepslate
assert not block ~ ~ ~1 minecraft:deepslate
assert block ~ ~1 ~1 minecraft:deepslate
assert block ~ ~2 ~1 minecraft:deepslate
assert block ~ ~3 ~1 minecraft:deepslate
assert not block ~ ~4 ~1 minecraft:deepslate
assert block ~1 ~ ~1 minecraft:deepslate
assert not block ~1 ~1 ~1 minecraft:deepslate
assert not block ~1 ~2 ~1 minecraft:deepslate
assert not block ~1 ~3 ~1 minecraft:deepslate
assert block ~1 ~4 ~1 minecraft:deepslate
assert not block ~2 ~ ~1 minecraft:deepslate
assert block ~2 ~1 ~1 minecraft:deepslate
assert block ~2 ~2 ~1 minecraft:deepslate
assert block ~2 ~3 ~1 minecraft:deepslate
assert not block ~2 ~4 ~1 minecraft:deepslate
assert not block ~ ~ ~2 minecraft:deepslate
assert block ~ ~1 ~2 minecraft:deepslate
assert block ~ ~2 ~2 minecraft:deepslate
assert block ~ ~3 ~2 minecraft:deepslate
assert not block ~ ~4 ~2 minecraft:deepslate
assert block ~1 ~ ~2 minecraft:deepslate
assert not block ~1 ~1 ~2 minecraft:deepslate
assert not block ~1 ~2 ~2 minecraft:deepslate
assert not block ~1 ~3 ~2 minecraft:deepslate
assert block ~1 ~4 ~2 minecraft:deepslate
assert not block ~2 ~ ~2 minecraft:deepslate
assert block ~2 ~1 ~2 minecraft:deepslate
assert block ~2 ~2 ~2 minecraft:deepslate
assert block ~2 ~3 ~2 minecraft:deepslate
assert not block ~2 ~4 ~2 minecraft:deepslate
assert not block ~ ~ ~3 minecraft:deepslate
assert block ~ ~1 ~3 minecraft:deepslate
assert block ~ ~2 ~3 minecraft:deepslate
assert block ~ ~3 ~3 minecraft:deepslate
assert not block ~ ~4 ~3 minecraft:deepslate
assert block ~1 ~ ~3 minecraft:deepslate
assert not block ~1 ~1 ~3 minecraft:deepslate
assert not block ~1 ~2 ~3 minecraft:deepslate
assert not block ~1 ~3 ~3 minecraft:deepslate
assert block ~1 ~4 ~3 minecraft:deepslate
assert not block ~2 ~ ~3 minecraft:deepslate
assert block ~2 ~1 ~3 minecraft:deepslate
assert block ~2 ~2 ~3 minecraft:deepslate
assert block ~2 ~3 ~3 minecraft:deepslate
assert not block ~2 ~4 ~3 minecraft:deepslate
assert not block ~ ~ ~4 minecraft:deepslate
assert block ~ ~1 ~4 minecraft:deepslate
assert block ~ ~2 ~4 minecraft:deepslate
assert block ~ ~3 ~4 minecraft:deepslate
assert not block ~ ~4 ~4 minecraft:deepslate
assert block ~1 ~ ~4 minecraft:deepslate
assert not block ~1 ~1 ~4 minecraft:deepslate
assert not block ~1 ~2 ~4 minecraft:deepslate
assert not block ~1 ~3 ~4 minecraft:deepslate
assert block ~1 ~4 ~4 minecraft:deepslate
assert not block ~2 ~ ~4 minecraft:deepslate
assert block ~2 ~1 ~4 minecraft:deepslate
assert block ~2 ~2 ~4 minecraft:deepslate
assert block ~2 ~3 ~4 minecraft:deepslate
assert not block ~2 ~4 ~4 minecraft:deepslate
assert not block ~ ~ ~5 minecraft:deepslate
assert not block ~ ~1 ~5 minecraft:deepslate
assert not block ~ ~2 ~5 minecraft:deepslate
assert not block ~ ~3 ~5 minecraft:deepslate
assert not block ~ ~4 ~5 minecraft:deepslate
assert not block ~1 ~ ~5 minecraft:deepslate
assert block ~1 ~1 ~5 minecraft:deepslate
assert block ~1 ~2 ~5 minecraft:deepslate
assert block ~1 ~3 ~5 minecraft:deepslate
assert not block ~1 ~4 ~5 minecraft:deepslate
assert not block ~2 ~ ~5 minecraft:deepslate
assert not block ~2 ~1 ~5 minecraft:deepslate
assert not block ~2 ~2 ~5 minecraft:deepslate
assert not block ~2 ~3 ~5 minecraft:deepslate
assert not block ~2 ~4 ~5 minecraft:deepslate

# Every order goes over the same positions
scoreboard players set #ward.generation.shell.order bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.shell.order bs.data 1",size:[7,5,6],batch:100000}
function #bs.generation:on_ellipsoid_outline/xzy
assert score #ward.generation.shell.order bs.data matches 78
scoreboard players set #ward.generation.shell.order bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.shell.order bs.data 1",size:[7,5,6],batch:100000}
function #bs.generation:on_ellipsoid_outline/yxz
assert score #ward.generation.shell.order bs.data matches 78
scoreboard players set #ward.generation.shell.order bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.shell.order bs.data 1",size:[7,5,6],batch:100000}
function #bs.generation:on_ellipsoid_outline/yzx
assert score #ward.generation.shell.order bs.data matches 78
scoreboard players set #ward.generation.shell.order bs.data 0
data modify storage bs.generation:on_ellipsoid_outline in set value {run:"scoreboard players add #ward.generation.shell.order bs.data 1",size:[7,5,6],batch:100000}
function #bs.generation:on_ellipsoid_outline/zyx
assert score #ward.generation.shell.order bs.data matches 78
