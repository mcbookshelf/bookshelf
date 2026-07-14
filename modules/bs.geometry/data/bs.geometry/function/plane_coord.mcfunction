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

execute if score #a bs.ctx matches 0 run return fail


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

scoreboard players operation $geometry.plane_coord.dz bs.out = #f bs.ctx
scoreboard players operation $geometry.plane_coord.dz bs.out += #g bs.ctx
scoreboard players operation $geometry.plane_coord.dz bs.out += #h bs.ctx

scoreboard players operation $geometry.plane_coord.dz bs.out /= #a bs.ctx


#Compute the relative positon of the intersection and plane origin
scoreboard players operation #i bs.ctx = $geometry.get_line.u0 bs.out
scoreboard players operation #j bs.ctx = $geometry.get_line.u1 bs.out
scoreboard players operation #k bs.ctx = $geometry.get_line.u2 bs.out

scoreboard players operation #i bs.ctx *= $geometry.plane_coord.dz bs.out
scoreboard players operation #j bs.ctx *= $geometry.plane_coord.dz bs.out
scoreboard players operation #k bs.ctx *= $geometry.plane_coord.dz bs.out

scoreboard players operation #i bs.ctx /= 1000 bs.const
scoreboard players operation #j bs.ctx /= 1000 bs.const
scoreboard players operation #k bs.ctx /= 1000 bs.const

scoreboard players operation #i bs.ctx -= #c bs.ctx
scoreboard players operation #j bs.ctx -= #d bs.ctx
scoreboard players operation #k bs.ctx -= #e bs.ctx


#compute the plane coord
scoreboard players operation $geometry.plane_coord.dx bs.out = #i bs.ctx
scoreboard players operation #l bs.ctx = #j bs.ctx
scoreboard players operation #m bs.ctx = #k bs.ctx
scoreboard players operation $geometry.plane_coord.dx bs.out *= $geometry.get_plane.i0 bs.out
scoreboard players operation #l bs.ctx *= $geometry.get_plane.i1 bs.out
scoreboard players operation #m bs.ctx *= $geometry.get_plane.i2 bs.out

scoreboard players operation $geometry.plane_coord.dx bs.out += #l bs.ctx
scoreboard players operation $geometry.plane_coord.dx bs.out += #m bs.ctx
scoreboard players operation $geometry.plane_coord.dx bs.out /= 1000 bs.out

scoreboard players operation $geometry.plane_coord.dx bs.out = #i bs.ctx
scoreboard players operation #l bs.ctx = #j bs.ctx
scoreboard players operation #m bs.ctx = #k bs.ctx
scoreboard players operation $geometry.plane_coord.dx bs.out *= $geometry.get_plane.j0 bs.out
scoreboard players operation #l bs.ctx *= $geometry.get_plane.j1 bs.out
scoreboard players operation #m bs.ctx *= $geometry.get_plane.j2 bs.out

scoreboard players operation $geometry.plane_coord.dx bs.out += #l bs.ctx
scoreboard players operation $geometry.plane_coord.dx bs.out += #m bs.ctx
scoreboard players operation $geometry.plane_coord.dx bs.out /= 1000 bs.const
