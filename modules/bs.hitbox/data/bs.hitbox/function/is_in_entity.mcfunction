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

execute unless entity @s[tag=bs.hitbox.custom] run return run \
  execute if entity @s[dy=0] positioned ~-.99999999999999 ~-.99999999999999 ~-.99999999999999 if entity @s[dy=0]

data modify storage bs:ctx _ set from entity @s Pos
data modify storage bs:ctx x set from storage bs:ctx _[0]
data modify storage bs:ctx y set from storage bs:ctx _[1]
data modify storage bs:ctx z set from storage bs:ctx _[2]
execute summon minecraft:marker run function bs.hitbox:utils/get_distance_pos with storage bs:ctx
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

return run execute \
  if score #x bs.ctx matches ..0 \
  if score #i bs.ctx matches 0.. \
  if score #y bs.ctx matches ..0 \
  if score #j bs.ctx matches 0.. \
  if score #z bs.ctx matches ..0 \
  if score #k bs.ctx matches 0..
