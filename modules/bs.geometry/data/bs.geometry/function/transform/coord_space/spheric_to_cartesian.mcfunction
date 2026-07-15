

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

#transform spheric (theta,phi,r) into cartesian (x,y,z)
#get sincos(theta)
data modify storage bs:ctx temp set value {angle: 1.2566f, axis: [0f,0f,1f]}
execute store result storage bs:ctx temp.angle float 0.00000174532925199 run data get storage bs:in geometry.shapes[{type:"point"}].origin[0] 10000

#left_rotation[2] = sin(theta/2)
#left_rotation[3] = cos(theta/2)
data modify entity B5-0-0-0-7 transformation.left_rotation set from storage bs:ctx temp

data modify storage bs:out geometry.shape set value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}

#a = sin(theta/2)
#b = cos(theta/2)
execute store result score #a bs.ctx run data get entity B5-0-0-0-7 transformation.left_rotation[2] 1000
execute store result score #b bs.ctx run data get entity B5-0-0-0-7 transformation.left_rotation[3] 1000

#c = sin(theta)
scoreboard players set #c bs.ctx 2
scoreboard players operation #c bs.ctx *= #a bs.ctx
scoreboard players operation #c bs.ctx *= #b bs.ctx
scoreboard players operation #c bs.ctx /= 1000 bs.const

#b = cos(theta)
scoreboard players operation #a bs.ctx *= #a bs.ctx
scoreboard players operation #b bs.ctx *= #b bs.ctx
scoreboard players operation #b bs.ctx -= #a bs.ctx
scoreboard players operation #b bs.ctx /= 1000 bs.const


#get sincos(phi)
data modify storage bs:ctx temp set value {angle: 1.2566f, axis: [0f,0f,1f]}
execute store result storage bs:ctx temp.angle float 0.00000174532925199 run data get storage bs:in geometry.shapes[{type:"point"}].origin[1] 10000

#left_rotation[2] = sin(theta/2)
#left_rotation[3] = cos(theta/2)
data modify entity B5-0-0-0-7 transformation.left_rotation set from storage bs:ctx temp

#d = sin(phi/2)
#e = cos(phi/2)
execute store result score #d bs.ctx run data get entity B5-0-0-0-7 transformation.left_rotation[2] 1000
execute store result score #e bs.ctx run data get entity B5-0-0-0-7 transformation.left_rotation[3] 1000

#f = sin(phi)
scoreboard players set #f bs.ctx 2
scoreboard players operation #f bs.ctx *= #d bs.ctx
scoreboard players operation #f bs.ctx *= #e bs.ctx
scoreboard players operation #f bs.ctx /= 1000 bs.const

#e = cos(phi)
scoreboard players operation #d bs.ctx *= #d bs.ctx
scoreboard players operation #e bs.ctx *= #e bs.ctx
scoreboard players operation #e bs.ctx -= #d bs.ctx
scoreboard players operation #e bs.ctx /= 1000 bs.const

#tellraw @a {score:{name:"#b",objective:bs.ctx}}
#tellraw @a {score:{name:"#c",objective:bs.ctx}}
#tellraw @a {score:{name:"#e",objective:bs.ctx}}
#tellraw @a {score:{name:"#f",objective:bs.ctx}}


#a = r
execute store result score #a bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[2] 1000

execute store result storage bs:out geometry.shape.origin[1] double -0.000001 run scoreboard players operation #f bs.ctx *= #a bs.ctx

#tellraw @a {score:{name:"#a",objective:bs.ctx}}

scoreboard players operation #e bs.ctx *= #a bs.ctx
scoreboard players operation #e bs.ctx /= 1000 bs.const

execute store result storage bs:out geometry.shape.origin[0] double -0.000001 run scoreboard players operation #c bs.ctx *= #e bs.ctx
execute store result storage bs:out geometry.shape.origin[2] double 0.000001 run scoreboard players operation #b bs.ctx *= #e bs.ctx

#tellraw @a {nbt:"geometry.shape.origin",storage:"bs:out"}

