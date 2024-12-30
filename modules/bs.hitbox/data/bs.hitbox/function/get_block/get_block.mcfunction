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

execute unless block ~ ~ ~ #bs.hitbox:is_composite run \
  return run data modify storage bs:out hitbox set value {shape:[[0.0,0.0,0.0,16.0,16.0,16.0]]}

loot replace block -30000000 0 1606 container.0 loot bs.hitbox:get/get_block
data modify storage bs:out hitbox set from block -30000000 0 1606 item.components."minecraft:custom_data"
execute if block ~ ~ ~ #bs.hitbox:has_offset summon minecraft:marker run function bs.hitbox:get_block/offset/get
