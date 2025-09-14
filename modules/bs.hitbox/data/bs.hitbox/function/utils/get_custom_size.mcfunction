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

execute summon minecraft:marker run function bs.hitbox:utils/get_negative_pos
execute in minecraft:overworld positioned as @s as B5-0-0-0-1 run function bs.hitbox:utils/get_entity_pos with storage bs:ctx
execute store result score #x bs.ctx store result score #i bs.ctx run data get storage bs:ctx _[0] 10000000
execute store result score #y bs.ctx store result score #j bs.ctx run data get storage bs:ctx _[1] 10000000
execute store result score #z bs.ctx store result score #k bs.ctx run data get storage bs:ctx _[2] 10000000

scoreboard players operation #x bs.ctx -= @s bs.width
execute if entity @s[tag=bs.hitbox.centered] run scoreboard players operation #y bs.ctx -= @s bs.height
scoreboard players operation #z bs.ctx -= @s bs.depth
scoreboard players operation #i bs.ctx += @s bs.width
execute if score #y bs.ctx = #j bs.ctx run scoreboard players operation #j bs.ctx += @s bs.height
scoreboard players operation #j bs.ctx += @s bs.height
scoreboard players operation #k bs.ctx += @s bs.depth
