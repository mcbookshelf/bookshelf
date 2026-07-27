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


#get plane parameters
execute store result score #l bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].origin[0] 1000
execute store result score #m bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].origin[1] 1000
execute store result score #n bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].origin[2] 1000

execute store result score #i bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].k[0] 1000
execute store result score #j bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].k[1] 1000
execute store result score #k bs.ctx run data get storage bs:in geometry.shapes[{type:"plane"}].k[2] 1000

#get line parameters
execute store result score #x bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].origin[2] 1000

execute store result score #o bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[0] 1000
execute store result score #p bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[1] 1000
execute store result score #q bs.ctx run data get storage bs:in geometry.shapes[{type:"line"}].k[2] 1000

#compute dot product of the normal vector of the plane and the director vector of the line
scoreboard players operation #a bs.ctx = #i bs.ctx
scoreboard players operation #a bs.ctx *= #o bs.ctx

scoreboard players operation #b bs.ctx = #j bs.ctx
scoreboard players operation #b bs.ctx *= #p bs.ctx
scoreboard players operation #a bs.ctx += #b bs.ctx

scoreboard players operation #b bs.ctx = #k bs.ctx
scoreboard players operation #b bs.ctx *= #q bs.ctx
scoreboard players operation #a bs.ctx += #b bs.ctx
scoreboard players operation #a bs.ctx /= 1000 bs.const

#if the line is included in the plane
execute if score #a bs.ctx matches 0 run return run data modify storage bs:out geometry.intersect append from storage bs:in geometry.shapes[{type:"line"}]

#Compute the value of the parameter of the axis
scoreboard players operation #c bs.ctx = #l bs.ctx
scoreboard players operation #d bs.ctx = #m bs.ctx
scoreboard players operation #e bs.ctx = #n bs.ctx

scoreboard players operation #c bs.ctx -= #x bs.ctx
scoreboard players operation #d bs.ctx -= #y bs.ctx
scoreboard players operation #e bs.ctx -= #z bs.ctx

scoreboard players operation #c bs.ctx *= #i bs.ctx
scoreboard players operation #d bs.ctx *= #j bs.ctx
scoreboard players operation #e bs.ctx *= #k bs.ctx

scoreboard players operation #c bs.ctx += #d bs.ctx
scoreboard players operation #c bs.ctx += #e bs.ctx
scoreboard players operation #c bs.ctx /= #a bs.ctx

scoreboard players operation $geometry.intersect.dz bs.out = #c bs.ctx

scoreboard players operation #o bs.ctx *= #c bs.ctx
scoreboard players operation #p bs.ctx *= #c bs.ctx
scoreboard players operation #q bs.ctx *= #c bs.ctx

scoreboard players operation #o bs.ctx /= 1000 bs.const
scoreboard players operation #p bs.ctx /= 1000 bs.const
scoreboard players operation #q bs.ctx /= 1000 bs.const

data modify storage bs:out geometry.intersect append value {type:"point",coord_type:"cartesian",origin:[0d,0d,0d]}
execute store result storage bs:out geometry.intersect[-1].origin[0] double 0.001 run scoreboard players operation #o bs.ctx += #x bs.ctx
execute store result storage bs:out geometry.intersect[-1].origin[1] double 0.001 run scoreboard players operation #p bs.ctx += #y bs.ctx
execute store result storage bs:out geometry.intersect[-1].origin[2] double 0.001 run scoreboard players operation #q bs.ctx += #z bs.ctx
