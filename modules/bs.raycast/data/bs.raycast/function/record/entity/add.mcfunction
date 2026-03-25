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

data modify storage bs:ctx _ set value {r:[],e:{norm:1}}
execute if score #x bs.ctx > #raycast.te bs.data run function bs.raycast:record/entity/slice
scoreboard players operation #raycast.te bs.data < #x bs.ctx
scoreboard players operation #raycast.tm bs.data < #raycast.te bs.data

execute unless score @s bs.raycast.id matches 1.. store result score @s bs.raycast.id run scoreboard players add #count bs.raycast.id 1
execute if entity @s[type=!#bs.hitbox:is_shaped,tag=!bs.hitbox.centered] run scoreboard players operation #b bs.ctx -= #h bs.ctx
execute store result storage bs:ctx _.e.id int 1 run scoreboard players get @s bs.raycast.id
execute store result storage bs:ctx _.e.tmin int 1 run scoreboard players get #x bs.ctx
execute store result storage bs:ctx _.e.tmax int 1 run scoreboard players get #i bs.ctx
execute store result storage bs:ctx _.e.x int 1 run scoreboard players get #a bs.ctx
execute store result storage bs:ctx _.e.y int 1 run scoreboard players get #b bs.ctx
execute store result storage bs:ctx _.e.z int 1 run scoreboard players get #c bs.ctx
execute if score #z bs.ctx = #x bs.ctx run data modify storage bs:ctx _.e.norm set value 2
execute if score #y bs.ctx = #x bs.ctx run data modify storage bs:ctx _.e.norm set value 3

data modify storage bs:data raycast.re append from storage bs:ctx _.e
data modify storage bs:data raycast.re append from storage bs:ctx _.r[]
execute store result score #raycast.id bs.data run data get storage bs:data raycast.re[-1].id
