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

execute store result score #r bs.ctx run function #bs.hitbox:callback/get_block_shape_with_fluid
execute unless data storage bs:lambda hitbox.shape run return run scoreboard players get #r bs.ctx
execute if block ~ ~ ~ #bs.hitbox:internal/placement_full run data modify storage bs:lambda hitbox.shape append value [0,0,0,16,16,16,4]
execute if block ~ ~ ~ #bs.hitbox:internal/placement_cauldrons run data modify storage bs:lambda hitbox.shape append value [0,3,0,16,16,16,4]
execute if block ~ ~ ~ minecraft:hopper run data modify storage bs:lambda hitbox.shape append value [0,10,0,16,16,16,4]
