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

execute summon minecraft:marker run function #bs.id:give_cuid
execute summon minecraft:armor_stand run function #bs.id:give_cuid
execute summon minecraft:armor_stand run function #bs.id:give_cuid
execute summon minecraft:marker run function #bs.id:give_cuid
execute summon minecraft:marker run function #bs.id:give_cuid
execute summon minecraft:armor_stand run function #bs.id:give_cuid
execute summon minecraft:marker run function #bs.id:give_cuid
kill @e[type=minecraft:armor_stand,distance=..1]

function #bs.id:update_cuids
scoreboard players set #packtest.i bs.cid 0
execute store result score #packtest bs.cid run scoreboard players operation #packtest.i bs.cid > @e bs.cid
execute as @e[type=minecraft:marker] if score @s bs.cid = #packtest.i bs.cid run scoreboard players remove #packtest.i bs.cid 1
execute as @e[type=minecraft:marker] if score @s bs.cid = #packtest.i bs.cid run scoreboard players remove #packtest.i bs.cid 1
execute as @e[type=minecraft:marker] if score @s bs.cid = #packtest.i bs.cid run scoreboard players remove #packtest.i bs.cid 1
execute as @e[type=minecraft:marker] if score @s bs.cid = #packtest.i bs.cid run scoreboard players remove #packtest.i bs.cid 1
scoreboard players operation #packtest bs.cid -= #packtest.i bs.cid
kill @e[type=minecraft:marker,distance=..1]
assert score #packtest bs.cid matches 4
