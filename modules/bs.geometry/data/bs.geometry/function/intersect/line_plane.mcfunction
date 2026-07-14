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
execute store result score $geometry.get_plane.o0 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].Pos[0] 1000
execute store result score $geometry.get_plane.o1 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].Pos[1] 1000
execute store result score $geometry.get_plane.o2 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].Pos[2] 1000

execute store result score $geometry.get_plane.i0 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].i[0] 1000
execute store result score $geometry.get_plane.i1 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].i[1] 1000
execute store result score $geometry.get_plane.i2 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].i[2] 1000

execute store result score $geometry.get_plane.j0 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].j[0] 1000
execute store result score $geometry.get_plane.j1 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].j[1] 1000
execute store result score $geometry.get_plane.j2 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].j[2] 1000

execute store result score $geometry.get_plane.n0 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].k[0] 1000
execute store result score $geometry.get_plane.n1 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].k[1] 1000
execute store result score $geometry.get_plane.n2 bs.out run data get storage bs:in geometry.shapes[{type:"plane"}].k[2] 1000


#get line parameters
execute store result score $geometry.get_plane.v0 bs.out run data get storage bs:in geometry.shapes[{type:"line"}].Pos[0] 1000
execute store result score $geometry.get_plane.v1 bs.out run data get storage bs:in geometry.shapes[{type:"line"}].Pos[1] 1000
execute store result score $geometry.get_plane.v2 bs.out run data get storage bs:in geometry.shapes[{type:"line"}].Pos[2] 1000

execute store result score $geometry.get_plane.u0 bs.out run data get storage bs:in geometry.shapes[{type:"line"}].k[0] 1000
execute store result score $geometry.get_plane.u1 bs.out run data get storage bs:in geometry.shapes[{type:"line"}].k[1] 1000
execute store result score $geometry.get_plane.u2 bs.out run data get storage bs:in geometry.shapes[{type:"line"}].k[2] 1000


scoreboard players reset $geometry.plane_coord.dx bs.out
scoreboard players reset $geometry.plane_coord.dy bs.out
scoreboard players reset $geometry.plane_coord.dz bs.out

scoreboard players operation #a bs.ctx = $geometry.get_plane.n0 bs.out
scoreboard players operation #a bs.ctx *= $geometry.get_line.u0 bs.out

scoreboard players operation #b bs.ctx = $geometry.get_plane.n1 bs.out
scoreboard players operation #b bs.ctx *= $geometry.get_line.u1 bs.out
scoreboard players operation #a bs.ctx += #b bs.ctx

scoreboard players operation #b bs.ctx = $geometry.get_plane.n2 bs.out
scoreboard players operation #b bs.ctx *= $geometry.get_line.u2 bs.out
scoreboard players operation #a bs.ctx += #b bs.ctx
scoreboard players operation #a bs.ctx /= 1000 bs.const

#if the line is included in the plane
execute if score #a bs.ctx matches 0 run return run data modify storage bs:out geometry.shape set from storage bs:in geometry.shapes[{type:"line"}]

#Compute the value of the parameter of the axis
scoreboard players operation #c bs.ctx = $geometry.get_plane.o0 bs.out
scoreboard players operation #d bs.ctx = $geometry.get_plane.o1 bs.out
scoreboard players operation #e bs.ctx = $geometry.get_plane.o2 bs.out

scoreboard players operation #c bs.ctx -= $geometry.get_line.v0 bs.out
scoreboard players operation #d bs.ctx -= $geometry.get_line.v1 bs.out
scoreboard players operation #e bs.ctx -= $geometry.get_line.v2 bs.out

scoreboard players operation #f bs.ctx = #c bs.ctx
scoreboard players operation #g bs.ctx = #d bs.ctx
scoreboard players operation #h bs.ctx = #e bs.ctx

scoreboard players operation #f bs.ctx *= $geometry.get_plane.n0 bs.out
scoreboard players operation #g bs.ctx *= $geometry.get_plane.n1 bs.out
scoreboard players operation #h bs.ctx *= $geometry.get_plane.n2 bs.out

data modify storage bs:out geometry.shape set value {type:"point",Pos:[0,0,0]}
execute store result storage bs:out geometry.shape.Pos[0] double 0.000001 run scoreboard players get #f bs.ctx
execute store result storage bs:out geometry.shape.Pos[1] double 0.000001 run scoreboard players get #g bs.ctx
execute store result storage bs:out geometry.shape.Pos[2] double 0.000001 run scoreboard players get #h bs.ctx
