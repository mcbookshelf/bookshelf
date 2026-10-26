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
kill @e[tag=ward.generation.ellipse.direction]
execute align xyz run summon minecraft:marker ~.5 ~.5 ~.5 {Tags:["ward.generation.ellipse.direction"]}
scoreboard players set #ward.generation.ellipse.direction bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.ellipse.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.ellipse.direction bs.data 1",size:[-5,-4],batch:1000000}
function #bs.generation:on_ellipse/xy
assert score #ward.generation.ellipse.direction bs.data matches 16
scoreboard players set #ward.generation.ellipse.direction bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.ellipse.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.ellipse.direction bs.data 1",size:[-5,-4],batch:1000000}
function #bs.generation:on_ellipse/xz
assert score #ward.generation.ellipse.direction bs.data matches 16
scoreboard players set #ward.generation.ellipse.direction bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.ellipse.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.ellipse.direction bs.data 1",size:[-5,-4],batch:1000000}
function #bs.generation:on_ellipse/yx
assert score #ward.generation.ellipse.direction bs.data matches 16
scoreboard players set #ward.generation.ellipse.direction bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.ellipse.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.ellipse.direction bs.data 1",size:[-5,-4],batch:1000000}
function #bs.generation:on_ellipse/yz
assert score #ward.generation.ellipse.direction bs.data matches 16
scoreboard players set #ward.generation.ellipse.direction bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.ellipse.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.ellipse.direction bs.data 1",size:[-5,-4],batch:1000000}
function #bs.generation:on_ellipse/zx
assert score #ward.generation.ellipse.direction bs.data matches 16
scoreboard players set #ward.generation.ellipse.direction bs.data 0
data modify storage bs.generation:on_ellipse in set value {run:"execute if entity @e[type=minecraft:marker,tag=ward.generation.ellipse.direction,dx=4,dy=4,dz=4] run scoreboard players add #ward.generation.ellipse.direction bs.data 1",size:[-5,-4],batch:1000000}
function #bs.generation:on_ellipse/zy
assert score #ward.generation.ellipse.direction bs.data matches 16
kill @e[tag=ward.generation.ellipse.direction]
