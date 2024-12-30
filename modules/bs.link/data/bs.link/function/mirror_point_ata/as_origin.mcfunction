# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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

function #bs.position:get_distance_ata {scale:1000}
execute store result storage bs:ctx z double -0.001 run scoreboard players get $position.get_distance_ata bs.out

execute store result score #r bs.ctx run data get entity @s Rotation[0] 1000
execute facing entity @s eyes run function #bs.position:get_rot_h {scale:1000}
scoreboard players operation #r bs.ctx -= @s bs.rot.h
execute store result storage bs:ctx x double 0.001 run scoreboard players remove #r bs.ctx 180000
execute store result storage bs:ctx y double 0.001 run data get entity @s Rotation[1] -1000
