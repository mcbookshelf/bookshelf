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

# Only the positions inside the ellipsoid are done
data modify storage bs.generation:on_ellipsoid in set value {run:"setblock ~ ~ ~ minecraft:tuff",size:[5,5,5]}
function #bs.generation:on_ellipsoid/xyz
assert not block ~ ~ ~ minecraft:tuff
assert not block ~ ~ ~1 minecraft:tuff
assert not block ~ ~ ~2 minecraft:tuff
assert not block ~ ~ ~3 minecraft:tuff
assert not block ~ ~ ~4 minecraft:tuff
assert not block ~ ~1 ~ minecraft:tuff
assert block ~ ~1 ~1 minecraft:tuff
assert block ~ ~1 ~2 minecraft:tuff
assert block ~ ~1 ~3 minecraft:tuff
assert not block ~ ~1 ~4 minecraft:tuff
assert not block ~ ~2 ~ minecraft:tuff
assert block ~ ~2 ~1 minecraft:tuff
assert block ~ ~2 ~2 minecraft:tuff
assert block ~ ~2 ~3 minecraft:tuff
assert not block ~ ~2 ~4 minecraft:tuff
assert not block ~ ~3 ~ minecraft:tuff
assert block ~ ~3 ~1 minecraft:tuff
assert block ~ ~3 ~2 minecraft:tuff
assert block ~ ~3 ~3 minecraft:tuff
assert not block ~ ~3 ~4 minecraft:tuff
assert not block ~ ~4 ~ minecraft:tuff
assert not block ~ ~4 ~1 minecraft:tuff
assert not block ~ ~4 ~2 minecraft:tuff
assert not block ~ ~4 ~3 minecraft:tuff
assert not block ~ ~4 ~4 minecraft:tuff
assert not block ~1 ~ ~ minecraft:tuff
assert block ~1 ~ ~1 minecraft:tuff
assert block ~1 ~ ~2 minecraft:tuff
assert block ~1 ~ ~3 minecraft:tuff
assert not block ~1 ~ ~4 minecraft:tuff
assert block ~1 ~1 ~ minecraft:tuff
assert block ~1 ~1 ~1 minecraft:tuff
assert block ~1 ~1 ~2 minecraft:tuff
assert block ~1 ~1 ~3 minecraft:tuff
assert block ~1 ~1 ~4 minecraft:tuff
assert block ~1 ~2 ~ minecraft:tuff
assert block ~1 ~2 ~1 minecraft:tuff
assert block ~1 ~2 ~2 minecraft:tuff
assert block ~1 ~2 ~3 minecraft:tuff
assert block ~1 ~2 ~4 minecraft:tuff
assert block ~1 ~3 ~ minecraft:tuff
assert block ~1 ~3 ~1 minecraft:tuff
assert block ~1 ~3 ~2 minecraft:tuff
assert block ~1 ~3 ~3 minecraft:tuff
assert block ~1 ~3 ~4 minecraft:tuff
assert not block ~1 ~4 ~ minecraft:tuff
assert block ~1 ~4 ~1 minecraft:tuff
assert block ~1 ~4 ~2 minecraft:tuff
assert block ~1 ~4 ~3 minecraft:tuff
assert not block ~1 ~4 ~4 minecraft:tuff
assert not block ~2 ~ ~ minecraft:tuff
assert block ~2 ~ ~1 minecraft:tuff
assert block ~2 ~ ~2 minecraft:tuff
assert block ~2 ~ ~3 minecraft:tuff
assert not block ~2 ~ ~4 minecraft:tuff
assert block ~2 ~1 ~ minecraft:tuff
assert block ~2 ~1 ~1 minecraft:tuff
assert block ~2 ~1 ~2 minecraft:tuff
assert block ~2 ~1 ~3 minecraft:tuff
assert block ~2 ~1 ~4 minecraft:tuff
assert block ~2 ~2 ~ minecraft:tuff
assert block ~2 ~2 ~1 minecraft:tuff
assert block ~2 ~2 ~2 minecraft:tuff
assert block ~2 ~2 ~3 minecraft:tuff
assert block ~2 ~2 ~4 minecraft:tuff
assert block ~2 ~3 ~ minecraft:tuff
assert block ~2 ~3 ~1 minecraft:tuff
assert block ~2 ~3 ~2 minecraft:tuff
assert block ~2 ~3 ~3 minecraft:tuff
assert block ~2 ~3 ~4 minecraft:tuff
assert not block ~2 ~4 ~ minecraft:tuff
assert block ~2 ~4 ~1 minecraft:tuff
assert block ~2 ~4 ~2 minecraft:tuff
assert block ~2 ~4 ~3 minecraft:tuff
assert not block ~2 ~4 ~4 minecraft:tuff
assert not block ~3 ~ ~ minecraft:tuff
assert block ~3 ~ ~1 minecraft:tuff
assert block ~3 ~ ~2 minecraft:tuff
assert block ~3 ~ ~3 minecraft:tuff
assert not block ~3 ~ ~4 minecraft:tuff
assert block ~3 ~1 ~ minecraft:tuff
assert block ~3 ~1 ~1 minecraft:tuff
assert block ~3 ~1 ~2 minecraft:tuff
assert block ~3 ~1 ~3 minecraft:tuff
assert block ~3 ~1 ~4 minecraft:tuff
assert block ~3 ~2 ~ minecraft:tuff
assert block ~3 ~2 ~1 minecraft:tuff
assert block ~3 ~2 ~2 minecraft:tuff
assert block ~3 ~2 ~3 minecraft:tuff
assert block ~3 ~2 ~4 minecraft:tuff
assert block ~3 ~3 ~ minecraft:tuff
assert block ~3 ~3 ~1 minecraft:tuff
assert block ~3 ~3 ~2 minecraft:tuff
assert block ~3 ~3 ~3 minecraft:tuff
assert block ~3 ~3 ~4 minecraft:tuff
assert not block ~3 ~4 ~ minecraft:tuff
assert block ~3 ~4 ~1 minecraft:tuff
assert block ~3 ~4 ~2 minecraft:tuff
assert block ~3 ~4 ~3 minecraft:tuff
assert not block ~3 ~4 ~4 minecraft:tuff
assert not block ~4 ~ ~ minecraft:tuff
assert not block ~4 ~ ~1 minecraft:tuff
assert not block ~4 ~ ~2 minecraft:tuff
assert not block ~4 ~ ~3 minecraft:tuff
assert not block ~4 ~ ~4 minecraft:tuff
assert not block ~4 ~1 ~ minecraft:tuff
assert block ~4 ~1 ~1 minecraft:tuff
assert block ~4 ~1 ~2 minecraft:tuff
assert block ~4 ~1 ~3 minecraft:tuff
assert not block ~4 ~1 ~4 minecraft:tuff
assert not block ~4 ~2 ~ minecraft:tuff
assert block ~4 ~2 ~1 minecraft:tuff
assert block ~4 ~2 ~2 minecraft:tuff
assert block ~4 ~2 ~3 minecraft:tuff
assert not block ~4 ~2 ~4 minecraft:tuff
assert not block ~4 ~3 ~ minecraft:tuff
assert block ~4 ~3 ~1 minecraft:tuff
assert block ~4 ~3 ~2 minecraft:tuff
assert block ~4 ~3 ~3 minecraft:tuff
assert not block ~4 ~3 ~4 minecraft:tuff
assert not block ~4 ~4 ~ minecraft:tuff
assert not block ~4 ~4 ~1 minecraft:tuff
assert not block ~4 ~4 ~2 minecraft:tuff
assert not block ~4 ~4 ~3 minecraft:tuff
assert not block ~4 ~4 ~4 minecraft:tuff

# Each position inside is done once, whatever the size
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[1,1,1],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 1
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[2,2,2],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 8
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[3,3,3],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 19
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[4,4,4],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 32
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[5,5,5],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 81
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[8,8,8],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 280
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,9,9],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 389
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[16,16,16],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 2176
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[12,5,7],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 224
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[3,11,2],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 46
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[1,7,7],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 37
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[7,1,7],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 37
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[7,7,1],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 37
scoreboard players set #ward.generation.round bs.data 0
data modify storage bs.generation:on_ellipsoid in set value {run:"scoreboard players add #ward.generation.round bs.data 1",size:[9,1,1],batch:100000}
function #bs.generation:on_ellipsoid/xyz
assert score #ward.generation.round bs.data matches 9
