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

data modify storage bs:out geometry.rot_axis set value {}

#this function accept an array of 2shapes as input
execute if function bs.geometry:error/2array run return fail
#a point and a plane/cylinder/sphere

execute if function bs.geometry:error/need_point run return fail
execute if function bs.geometry:error/need_3d_or_coord_space run return fail

data modify storage bs:ctx temp set from storage bs:in geometry.shapes[{type:"plane"}]
data modify storage bs:ctx temp set from storage bs:in geometry.shapes[{type:"cylinder"}]
data modify storage bs:ctx temp set from storage bs:in geometry.shapes[{type:"sphere"}]
data modify storage bs:ctx temp set from storage bs:in geometry.shapes[{type:"coord_space"}]

#get plane parameters
execute store result score #l bs.ctx run data get storage bs:ctx temp.origin[0] 1000
execute store result score #m bs.ctx run data get storage bs:ctx temp.origin[1] 1000
execute store result score #n bs.ctx run data get storage bs:ctx temp.origin[2] 1000

execute store result score #r bs.ctx run data get storage bs:ctx temp.i[0] 1000
execute store result score #s bs.ctx run data get storage bs:ctx temp.i[1] 1000
execute store result score #t bs.ctx run data get storage bs:ctx temp.i[2] 1000

execute store result score #u bs.ctx run data get storage bs:ctx temp.j[0] 1000
execute store result score #v bs.ctx run data get storage bs:ctx temp.j[1] 1000
execute store result score #w bs.ctx run data get storage bs:ctx temp.j[2] 1000

execute store result score #o bs.ctx run data get storage bs:ctx temp.k[0] 1000
execute store result score #p bs.ctx run data get storage bs:ctx temp.k[1] 1000
execute store result score #q bs.ctx run data get storage bs:ctx temp.k[2] 1000

#get point parameters
execute store result score #x bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[0] 1000
execute store result score #y bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[1] 1000
execute store result score #z bs.ctx run data get storage bs:in geometry.shapes[{type:"point"}].origin[2] 1000

#set output
data modify storage bs:out geometry.rot_axis set value {type:"point",coord_type:"cartesian",origin:[0,0,0]}

#compute
scoreboard players operation #x bs.ctx -= #l bs.ctx
scoreboard players operation #y bs.ctx -= #m bs.ctx
scoreboard players operation #z bs.ctx -= #n bs.ctx

scoreboard players operation #r bs.ctx *= #x bs.ctx
scoreboard players operation #s bs.ctx *= #y bs.ctx
scoreboard players operation #t bs.ctx *= #z bs.ctx
scoreboard players operation #r bs.ctx += #s bs.ctx
execute store result storage bs:out geometry.rot_axis.origin[0] double 0.000001 run scoreboard players operation #r bs.ctx += #t bs.ctx

scoreboard players operation #u bs.ctx *= #x bs.ctx
scoreboard players operation #v bs.ctx *= #y bs.ctx
scoreboard players operation #w bs.ctx *= #z bs.ctx
scoreboard players operation #u bs.ctx += #v bs.ctx
execute store result storage bs:out geometry.rot_axis.origin[1] double 0.000001 run scoreboard players operation #u bs.ctx += #w bs.ctx

scoreboard players operation #o bs.ctx *= #x bs.ctx
scoreboard players operation #p bs.ctx *= #y bs.ctx
scoreboard players operation #q bs.ctx *= #z bs.ctx
scoreboard players operation #o bs.ctx += #p bs.ctx
scoreboard players operation #o bs.ctx += #q bs.ctx
execute store result storage bs:out geometry.rot_axis.origin[2] double 0.001 run scoreboard players operation #o bs.ctx /= 1000 bs.const
