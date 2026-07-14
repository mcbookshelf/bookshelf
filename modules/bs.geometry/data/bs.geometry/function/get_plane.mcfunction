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

scoreboard players reset $geometry.get_plane.o0 bs.out
scoreboard players reset $geometry.get_plane.o1 bs.out
scoreboard players reset $geometry.get_plane.o2 bs.out

scoreboard players reset $geometry.get_plane.n0 bs.out
scoreboard players reset $geometry.get_plane.n1 bs.out
scoreboard players reset $geometry.get_plane.n2 bs.out

scoreboard players reset $geometry.get_plane.i0 bs.out
scoreboard players reset $geometry.get_plane.i1 bs.out
scoreboard players reset $geometry.get_plane.i2 bs.out

scoreboard players reset $geometry.get_plane.j0 bs.out
scoreboard players reset $geometry.get_plane.j1 bs.out
scoreboard players reset $geometry.get_plane.j2 bs.out

execute unless loaded ~ ~ ~ run return fail

tp B5-0-0-0-9 ~ ~ ~

data modify storage bs:data geometry.Pos set from entity B5-0-0-0-9 Pos
execute store result score $geometry.get_plane.o0 bs.out run data get storage bs.out:data Pos[0] 1000
execute store result score $geometry.get_plane.o1 bs.out run data get storage bs.out:data Pos[1] 1000
execute store result score $geometry.get_plane.o2 bs.out run data get storage bs.out:data Pos[2] 1000


execute positioned .0 .0 .0 run tp B5-0-0-0-9 ^ ^ ^1
data modify storage bs:data geometry.Pos set from entity B5-0-0-0-9 Pos
execute store result score $geometry.get_plane.n0 bs.out run data get storage bs.out:data Pos[0] 1000
execute store result score $geometry.get_plane.n1 bs.out run data get storage bs.out:data Pos[1] 1000
execute store result score $geometry.get_plane.n2 bs.out run data get storage bs.out:data Pos[2] 1000

execute positioned .0 .0 .0 run tp B5-0-0-0-9 ^1 ^ ^
data modify storage bs:data geometry.Pos set from entity B5-0-0-0-9 Pos
execute store result score $geometry.get_plane.i0 bs.out run data get storage bs.out:data Pos[0] 1000
execute store result score $geometry.get_plane.i1 bs.out run data get storage bs.out:data Pos[1] 1000
execute store result score $geometry.get_plane.i2 bs.out run data get storage bs.out:data Pos[2] 1000


#cross product to get the 2snc director vector of the plane
scoreboard players operation #a bs.ctx = $geometry.get_plane.n2 bs.out
scoreboard players operation #a bs.ctx *= $geometry.get_plane.i1 bs.out
scoreboard players operation $geometry.get_plane.j0 bs.out = $geometry.get_plane.n1 bs.out
scoreboard players operation $geometry.get_plane.j0 bs.out *= $geometry.get_plane.i2 bs.out
scoreboard players operation $geometry.get_plane.j0 bs.out -= #a bs.ctx
scoreboard players operation $geometry.get_plane.j0 bs.out /= 1000 bs.const

scoreboard players operation #a bs.ctx = $geometry.get_plane.n0 bs.out
scoreboard players operation #a bs.ctx *= $geometry.get_plane.i2 bs.out
scoreboard players operation $geometry.get_plane.j1 bs.out = $geometry.get_plane.n2 bs.out
scoreboard players operation $geometry.get_plane.j1 bs.out *= $geometry.get_plane.i0 bs.out
scoreboard players operation $geometry.get_plane.j1 bs.out -= #a bs.ctx
scoreboard players operation $geometry.get_plane.j1 bs.out /= 1000 bs.const

scoreboard players operation #a bs.ctx = $geometry.get_plane.n1 bs.out
scoreboard players operation #a bs.ctx *= $geometry.get_plane.i0 bs.out
scoreboard players operation $geometry.get_plane.j2 bs.out = $geometry.get_plane.n0 bs.out
scoreboard players operation $geometry.get_plane.j2 bs.out *= $geometry.get_plane.i1 bs.out
scoreboard players operation $geometry.get_plane.j2 bs.out -= #a bs.ctx
scoreboard players operation $geometry.get_plane.j2 bs.out /= 1000 bs.const


tp B5-0-0-0-9 -30000000 1000 1600
