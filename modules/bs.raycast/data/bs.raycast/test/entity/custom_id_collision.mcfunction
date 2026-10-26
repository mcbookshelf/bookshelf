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

summon minecraft:marker ~.5 ~ ~.5 {Tags:["bs.ward","bs.ward.1"]}
execute as @e[type=minecraft:marker,tag=bs.ward.1,distance=..2,limit=1] run function #bs.hitbox:set_entity {with:{width:1,height:1}}
execute positioned ~1.5 ~.5 ~.5 facing ~-.5 ~ ~ store result score #r bs.ctx run function #bs.raycast:run {with:{blocks:false,entities:"bs.ward",max_distance:4}}
execute if score #r bs.ctx matches 0 run fail "Failed to seed an entity ID on the custom hitbox"

execute as @e[type=minecraft:marker,tag=bs.ward.1,distance=..2,limit=1] run function #bs.hitbox:set_entity {with:{width:0,height:1}}
summon minecraft:armor_stand ~.6 ~ ~.5 {Tags:["bs.ward","bs.ward.2"]}
execute positioned ~1.5 ~.5 ~.5 facing ~-.5 ~ ~ store result score #r bs.ctx run function #bs.raycast:run {with:{blocks:false,entities:"bs.ward",max_distance:4}}
execute if score #r bs.ctx matches 0 run fail "Failed to detect the target after the custom hitbox early return"

assert entity @e[type=minecraft:marker,tag=bs.ward.1,tag=bs.raycast.checked,distance=..2,limit=1]
assert score @e[type=minecraft:armor_stand,tag=bs.ward.2,distance=..2,limit=1] bs.raycast.id matches 1..
execute as @e[type=minecraft:marker,tag=bs.ward.1,distance=..2,limit=1] if score @s bs.raycast.id = @e[type=minecraft:armor_stand,tag=bs.ward.2,distance=..2,limit=1] bs.raycast.id run fail "Zero-sized custom hitbox retained a colliding raycast ID"

kill @e[tag=bs.ward,distance=..2]
