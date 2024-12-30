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

execute if block ~ ~ ~ #bs.hitbox:intangible run return 0
execute unless block ~ ~ ~ #bs.hitbox:is_composite run return 1

execute summon minecraft:marker run function bs.hitbox:utils/get_fract_pos
execute store result score #x bs.ctx run data get storage bs:ctx _[0] 1000000
execute store result score #y bs.ctx run data get storage bs:ctx _[1] 1000000
execute store result score #z bs.ctx run data get storage bs:ctx _[2] 1000000

function #bs.hitbox:get_block
execute store result score #u bs.ctx run data get storage bs:out hitbox.offset.x 1000000
execute store result score #v bs.ctx run data get storage bs:out hitbox.offset.z 1000000
return run function bs.hitbox:is_in_block/check
