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

execute store result score #h bs.ctx run data get storage bs:out hitbox.height 1000
execute store result score #w bs.ctx run data get storage bs:out hitbox.width 500
execute store result score #s bs.ctx run data get storage bs:out hitbox.scale 1000
scoreboard players operation #h bs.ctx *= #s bs.ctx
scoreboard players operation #w bs.ctx *= #s bs.ctx

execute summon minecraft:marker run function bs.hitbox:utils/get_negative_pos
execute at @s summon minecraft:marker run function bs.hitbox:utils/get_relative_pos with storage bs:ctx
execute store result score #l bs.ctx store result score #x bs.ctx run data get storage bs:ctx _[0] 1000000
execute store result score #m bs.ctx store result score #y bs.ctx run data get storage bs:ctx _[1] 1000000
execute store result score #n bs.ctx store result score #z bs.ctx run data get storage bs:ctx _[2] 1000000

scoreboard players operation #x bs.ctx -= #w bs.ctx
scoreboard players operation #z bs.ctx -= #w bs.ctx
scoreboard players operation #l bs.ctx += #w bs.ctx
scoreboard players operation #m bs.ctx += #h bs.ctx
scoreboard players operation #n bs.ctx += #w bs.ctx

return run function bs.hitbox:is_entity_in_block/check/check
