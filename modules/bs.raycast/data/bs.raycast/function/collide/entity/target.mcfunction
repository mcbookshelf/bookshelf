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

execute if score #raycast.epiercing bs.data matches 0.. run scoreboard players remove #raycast.epiercing bs.data 1
scoreboard players operation $raycast.piercing bs.lambda = #raycast.epiercing bs.data

scoreboard players set $raycast.hit_flag bs.lambda -1
execute if entity @s[tag=bs.raycast.nx] if score #raycast.ux bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 5
execute if entity @s[tag=bs.raycast.nx] if score #raycast.ux bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 4
execute if entity @s[tag=bs.raycast.nz] if score #raycast.uz bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 3
execute if entity @s[tag=bs.raycast.nz] if score #raycast.uz bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 2
execute if entity @s[tag=bs.raycast.ny] if score #raycast.uy bs.data matches ..-1 run scoreboard players set $raycast.hit_face bs.lambda 1
execute if entity @s[tag=bs.raycast.ny] if score #raycast.uy bs.data matches 0.. run scoreboard players set $raycast.hit_face bs.lambda 0

execute if data storage bs:data raycast.data{hit_normal:1b} run function bs.raycast:utils/get_hit_normal
execute if data storage bs:data raycast.data{targeted_entity:1b} run data modify storage bs:lambda raycast.targeted_entity set from entity @s UUID

execute if data storage bs:data raycast.on_targeted_entity at @s run function bs.raycast:utils/on_targeted_entity with storage bs:data raycast
execute if data storage bs:data raycast.on_hit_point run function bs.raycast:utils/on_hit_point with storage bs:data raycast

execute store result score #raycast.etoi bs.data run scoreboard players set @s bs.toi 2147483647
scoreboard players operation #raycast.etoi bs.data < @e[distance=..255,scores={bs.toi=0..}] bs.toi
