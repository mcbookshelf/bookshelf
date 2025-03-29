# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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
# @dummy
# @skyaccess true

setblock 0 0 0 minecraft:bookshelf
tp @s -.5 0.0 1.5 0.0 0.0

scoreboard players set @s bs.vel.x 1000
scoreboard players set @s bs.vel.y 0
scoreboard players set @s bs.vel.z -1000

function #bs.move:apply_vel {scale:0.001,with:{blocks:true,entities:false,on_collision:"#bs.move:callback/stick"}}

execute store result score #packtest.x bs.data run data get entity @s Pos[0] 1000
execute store result score #packtest.z bs.data run data get entity @s Pos[2] 1000

dummy @s leave

assert score #packtest.x bs.data matches -303..-297
assert score #packtest.z bs.data matches 1297..1303
