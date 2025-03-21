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

execute store result score #r bs.ctx run function bs.hitbox:is_entity_in_blocks/check/check with storage bs:ctx _
execute if score #r bs.ctx matches 1 run return 1

scoreboard players remove #z bs.ctx 1000000
scoreboard players remove #n bs.ctx 1000000
execute if score #n bs.ctx matches 1.. positioned ~ ~ ~1 if function bs.hitbox:is_entity_in_blocks/recurse/z run return 1
scoreboard players add #z bs.ctx 1000000
scoreboard players add #n bs.ctx 1000000
