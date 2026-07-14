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

scoreboard players reset $geometry.get_plane.v0 bs.out
scoreboard players reset $geometry.get_plane.v1 bs.out
scoreboard players reset $geometry.get_plane.v2 bs.out

scoreboard players reset $geometry.get_plane.u0 bs.out
scoreboard players reset $geometry.get_plane.u1 bs.out
scoreboard players reset $geometry.get_plane.u2 bs.out

execute unless loaded ~ ~ ~ run return fail

tp B5-0-0-0-9 ~ ~ ~

data modify storage bs.screen_detection:data Pos set from entity B5-0-0-0-9 Pos
execute store result score $geometry.get_line.v0 bs.out run data get storage bs.screen_detection:data Pos[0] 1000
execute store result score $geometry.get_line.v1 bs.out run data get storage bs.screen_detection:data Pos[1] 1000
execute store result score $geometry.get_line.v2 bs.out run data get storage bs.screen_detection:data Pos[2] 1000


execute positioned .0 .0 .0 run tp B5-0-0-0-9 ^ ^ ^1
data modify storage bs.screen_detection:data Pos set from entity B5-0-0-0-9 Pos
execute store result score $geometry.get_line.u0 bs.out run data get storage bs.screen_detection:data Pos[0] 1000
execute store result score $geometry.get_line.u1 bs.out run data get storage bs.screen_detection:data Pos[1] 1000
execute store result score $geometry.get_line.u2 bs.out run data get storage bs.screen_detection:data Pos[2] 1000

tp B5-0-0-0-9 -30000000 1000 1600
