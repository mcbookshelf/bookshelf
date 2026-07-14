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

execute unless loaded ~ ~ ~ run return fail

tp B5-0-0-0-9 ~ ~ ~

data modify storage bs.ctx:data Pos set from entity B5-0-0-0-9 Pos
execute store result score #o0 bs.ctx run data get storage bs.ctx:data Pos[0] 1000
execute store result score #o1 bs.ctx run data get storage bs.ctx:data Pos[1] 1000
execute store result score #o2 bs.ctx run data get storage bs.ctx:data Pos[2] 1000


execute positioned .0 .0 .0 run tp B5-0-0-0-9 ^ ^ ^1
data modify storage bs.ctx:data Pos set from entity B5-0-0-0-9 Pos
execute store result score #n0 bs.ctx run data get storage bs.ctx:data Pos[0] 1000
execute store result score #n1 bs.ctx run data get storage bs.ctx:data Pos[1] 1000
execute store result score #n2 bs.ctx run data get storage bs.ctx:data Pos[2] 1000

execute positioned .0 .0 .0 run tp B5-0-0-0-9 ^1 ^ ^
data modify storage bs.ctx:data Pos set from entity B5-0-0-0-9 Pos
execute store result score #i0 bs.ctx run data get storage bs.ctx:data Pos[0] 1000
execute store result score #i1 bs.ctx run data get storage bs.ctx:data Pos[1] 1000
execute store result score #i2 bs.ctx run data get storage bs.ctx:data Pos[2] 1000


#cross product to get the 2snc director vector of the plane
scoreboard players operation #intern0 bs.ctx = #n2 bs.ctx
scoreboard players operation #intern0 bs.ctx *= #i1 bs.ctx
scoreboard players operation #j0 bs.ctx = #n1 bs.ctx
scoreboard players operation #j0 bs.ctx *= #i2 bs.ctx
scoreboard players operation #j0 bs.ctx -= #intern0 bs.ctx
scoreboard players operation #j0 bs.ctx /= 1000 bs.const

scoreboard players operation #intern0 bs.ctx = #n0 bs.ctx
scoreboard players operation #intern0 bs.ctx *= #i2 bs.ctx
scoreboard players operation #j1 bs.ctx = #n2 bs.ctx
scoreboard players operation #j1 bs.ctx *= #i0 bs.ctx
scoreboard players operation #j1 bs.ctx -= #intern0 bs.ctx
scoreboard players operation #j1 bs.ctx /= 1000 bs.const

scoreboard players operation #intern0 bs.ctx = #n1 bs.ctx
scoreboard players operation #intern0 bs.ctx *= #i0 bs.ctx
scoreboard players operation #j2 bs.ctx = #n0 bs.ctx
scoreboard players operation #j2 bs.ctx *= #i1 bs.ctx
scoreboard players operation #j2 bs.ctx -= #intern0 bs.ctx
scoreboard players operation #j2 bs.ctx /= 1000 bs.const


tp B5-0-0-0-9 -30000000 1000 1600
