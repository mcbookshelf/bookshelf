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

execute at @s run function bs.hitbox:utils/get_entity_size
execute store result storage bs:ctx x double .0000001 run scoreboard players operation #l bs.ctx = #x bs.ctx
execute store result storage bs:ctx y double .0000001 run scoreboard players operation #m bs.ctx = #y bs.ctx
execute store result storage bs:ctx z double .0000001 run scoreboard players operation #n bs.ctx = #z bs.ctx

data modify storage bs:ctx _ set value {shape:"#bs.hitbox:get_block_collision",ignored:"#bs.hitbox:can_pass_through"}
return run function bs.hitbox:is_entity_in_blocks/recurse/init with storage bs:ctx
