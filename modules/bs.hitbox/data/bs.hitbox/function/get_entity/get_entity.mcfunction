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

scoreboard players set #i bs.ctx 0
execute if entity @s[type=#bs.hitbox:size/group_1] run scoreboard players add #i bs.ctx 1
execute if entity @s[type=#bs.hitbox:size/group_2] run scoreboard players add #i bs.ctx 2
execute if entity @s[type=#bs.hitbox:size/group_4] run scoreboard players add #i bs.ctx 4
execute if entity @s[type=#bs.hitbox:size/group_8] run scoreboard players add #i bs.ctx 8
execute if entity @s[type=#bs.hitbox:size/group_16] run scoreboard players add #i bs.ctx 16
execute if entity @s[type=#bs.hitbox:size/group_32] run scoreboard players add #i bs.ctx 32
execute if entity @s[type=#bs.hitbox:size/group_64] run scoreboard players add #i bs.ctx 64

execute store result storage bs:ctx y short 1 run scoreboard players get #i bs.ctx
function bs.hitbox:get_entity/dispatch with storage bs:ctx

execute store result storage bs:out hitbox.scale double .000001 store success score #s bs.ctx run attribute @s minecraft:scale get 1000000
execute if score #s bs.ctx matches 0 run data modify storage bs:out hitbox.scale set value 1.0
