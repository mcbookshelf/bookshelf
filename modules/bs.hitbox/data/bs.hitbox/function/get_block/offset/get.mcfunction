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

execute store result score #u bs.ctx store result storage bs:ctx x int 1 run data get entity @s Pos[0]
execute store result score #v bs.ctx store result storage bs:ctx z int 1 run data get entity @s Pos[2]

function bs.hitbox:get_block/offset/fetch with storage bs:ctx
execute if score #s bs.ctx matches 0 run function bs.hitbox:get_block/offset/compute
kill @s

execute if block ~ ~ ~ minecraft:pointed_dripstone run function bs.hitbox:get_block/offset/clamp {min:-1250000,max:1250000}
