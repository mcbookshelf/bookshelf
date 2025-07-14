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

execute if entity @s[scores={bs.width=0..,bs.height=0..,bs.depth=0..}] run return run function bs.raycast:check/entity/custom

# get hitbox dimensions (width, depth, height)
function #bs.hitbox:get_entity
execute store result score #w bs.ctx run data get storage bs:out hitbox.width 5000
execute store result score #h bs.ctx run data get storage bs:out hitbox.height 5000
execute store result score #d bs.ctx run data get storage bs:out hitbox.depth 5000
execute unless score #w bs.ctx matches 1.. unless score #h bs.ctx matches 1.. unless score #d bs.ctx matches 1.. run return 0
execute store result score #s bs.ctx run data get storage bs:out hitbox.scale 1000
scoreboard players operation #w bs.ctx *= #s bs.ctx
scoreboard players operation #h bs.ctx *= #s bs.ctx
scoreboard players operation #d bs.ctx *= #s bs.ctx

# run size-based collision check
execute if entity @s[type=#bs.hitbox:is_shaped] run return run function bs.raycast:check/entity/size
scoreboard players operation #raycast.ry bs.data += #h bs.ctx
function bs.raycast:check/entity/size
scoreboard players operation #raycast.ry bs.data -= #h bs.ctx
