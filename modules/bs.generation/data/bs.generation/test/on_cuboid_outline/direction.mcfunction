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

# On every order, a negative size on each axis stays in the cube that ends at the origin
kill @e[tag=ward.generation.cuboid_outline.direction]
execute align xyz run summon minecraft:marker ~.5 ~.5 ~.5 {Tags:["ward.generation.cuboid_outline.direction"]}
scoreboard players set #ward.generation.cuboid_outline.direction bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid_outline.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid_outline.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid_outline/xyz
assert score #ward.generation.cuboid_outline.direction bs.data matches 54
scoreboard players set #ward.generation.cuboid_outline.direction bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid_outline.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid_outline.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid_outline/xzy
assert score #ward.generation.cuboid_outline.direction bs.data matches 54
scoreboard players set #ward.generation.cuboid_outline.direction bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid_outline.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid_outline.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid_outline/yxz
assert score #ward.generation.cuboid_outline.direction bs.data matches 54
scoreboard players set #ward.generation.cuboid_outline.direction bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid_outline.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid_outline.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid_outline/yzx
assert score #ward.generation.cuboid_outline.direction bs.data matches 54
scoreboard players set #ward.generation.cuboid_outline.direction bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid_outline.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid_outline.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid_outline/zxy
assert score #ward.generation.cuboid_outline.direction bs.data matches 54
scoreboard players set #ward.generation.cuboid_outline.direction bs.data 0
data modify storage bs.generation:on_cuboid_outline in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.cuboid_outline.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.cuboid_outline.direction bs.data 1",size:[-5,-4,-3],batch:1000000}
function #bs.generation:on_cuboid_outline/zyx
assert score #ward.generation.cuboid_outline.direction bs.data matches 54
kill @e[tag=ward.generation.cuboid_outline.direction]
