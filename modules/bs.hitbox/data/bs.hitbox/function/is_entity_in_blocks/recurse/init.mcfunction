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

scoreboard players operation #i bs.ctx /= 1000000 bs.const
scoreboard players operation #i bs.ctx *= 1000000 bs.const
scoreboard players operation #x bs.ctx -= #i bs.ctx
scoreboard players operation #l bs.ctx -= #i bs.ctx

scoreboard players operation #j bs.ctx /= 1000000 bs.const
scoreboard players operation #j bs.ctx *= 1000000 bs.const
scoreboard players operation #y bs.ctx -= #j bs.ctx
scoreboard players operation #m bs.ctx -= #j bs.ctx

scoreboard players operation #k bs.ctx /= 1000000 bs.const
scoreboard players operation #k bs.ctx *= 1000000 bs.const
scoreboard players operation #z bs.ctx -= #k bs.ctx
scoreboard players operation #n bs.ctx -= #k bs.ctx

$execute at @s align xyz positioned ~$(x) ~$(y) ~$(z) run return run function bs.hitbox:is_entity_in_blocks/recurse/x
