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

execute store result score #raycast.dm bs.data run data get storage bs:data raycast.max_distance 1000
execute store result score #raycast.pb bs.data store result score #raycast.pe bs.data run data get storage bs:data raycast.piercing 1
execute if score #raycast.pb bs.data matches 0 store result score #raycast.pb bs.data run data get storage bs:data raycast.piercing.blocks 1
execute if score #raycast.pe bs.data matches 0 store result score #raycast.pe bs.data run data get storage bs:data raycast.piercing.entities 1
scoreboard players add #raycast.pb bs.data 1
scoreboard players add #raycast.pe bs.data 1

execute store result score #raycast.tb bs.data store result score #raycast.te bs.data run scoreboard players set #raycast.tm bs.data 2147483647
execute store result score #count bs.raycast.id \
  store result score $raycast.entry_distance bs.lambda \
  store result score $raycast.exit_distance bs.lambda \
  store result score $raycast.prev_entry_distance bs.lambda \
  store result score $raycast.prev_exit_distance bs.lambda \
  run scoreboard players set #i bs.ctx 0

execute unless data storage bs:data raycast{blocks:0b} run scoreboard players add #i bs.ctx 2
execute unless data storage bs:data raycast{entities:0b} run scoreboard players add #i bs.ctx 3
execute unless data storage bs:data raycast{entities:0b} if entity @e[tag=bs.hitbox.custom,distance=..255,limit=1] run scoreboard players add #i bs.ctx 1
execute store result storage bs:ctx y int 1 run scoreboard players remove #i bs.ctx 1

execute unless data storage bs:data raycast{entities:0b} run tag @e[tag=bs.raycast.checked,distance=..255] remove bs.raycast.checked
execute positioned ^ ^ ^ summon minecraft:marker run function bs.raycast:recurse/init with storage bs:ctx
return run execute if score #raycast.tm bs.data matches ..2147483646
