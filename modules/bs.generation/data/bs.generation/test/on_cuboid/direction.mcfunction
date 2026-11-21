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

# A negative size goes west, down or north
data modify storage bs.generation:on_cuboid in set value {run:"setblock ~ ~ ~ minecraft:gold_block",size:[-2,1,-2]}
execute positioned ~4 ~ ~4 run function #bs.generation:on_cuboid/zyx
assert block ~4 ~ ~4 minecraft:gold_block
assert block ~3 ~ ~4 minecraft:gold_block
assert block ~4 ~ ~3 minecraft:gold_block
assert block ~3 ~ ~3 minecraft:gold_block
assert not block ~5 ~ ~4 minecraft:gold_block
assert not block ~2 ~ ~4 minecraft:gold_block
assert not block ~4 ~1 ~4 minecraft:gold_block

# Each axis has its own direction
data modify storage bs.generation:on_cuboid in set value {run:"setblock ~ ~ ~ minecraft:stone",size:[2,-2,1]}
execute positioned ~ ~4 ~ run function #bs.generation:on_cuboid/xyz
assert block ~ ~4 ~ minecraft:stone
assert block ~1 ~4 ~ minecraft:stone
assert block ~ ~3 ~ minecraft:stone
assert block ~1 ~3 ~ minecraft:stone
assert not block ~ ~5 ~ minecraft:stone

# On every order, a negative size on each axis stays in the cube that ends at the origin
kill @e[tag=ward.generation.cuboid.direction]
execute align xyz run summon minecraft:marker ~.5 ~.5 ~.5 {Tags:["ward.generation.cuboid.direction"]}
scoreboard players set #ward.generation.cuboid.direction bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid/xyz
assert score #ward.generation.cuboid.direction bs.data matches 60
scoreboard players set #ward.generation.cuboid.direction bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid/xzy
assert score #ward.generation.cuboid.direction bs.data matches 60
scoreboard players set #ward.generation.cuboid.direction bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid/yxz
assert score #ward.generation.cuboid.direction bs.data matches 60
scoreboard players set #ward.generation.cuboid.direction bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid/yzx
assert score #ward.generation.cuboid.direction bs.data matches 60
scoreboard players set #ward.generation.cuboid.direction bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid/zxy
assert score #ward.generation.cuboid.direction bs.data matches 60
scoreboard players set #ward.generation.cuboid.direction bs.data 0
data modify storage bs.generation:on_cuboid in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid/zyx
assert score #ward.generation.cuboid.direction bs.data matches 60
kill @e[tag=ward.generation.cuboid.direction]
