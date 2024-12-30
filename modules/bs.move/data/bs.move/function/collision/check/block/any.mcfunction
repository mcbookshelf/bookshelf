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

execute unless block ~ ~ ~ #bs.hitbox:is_composite run return run function bs.move:collision/check/block/cube

function #bs.hitbox:get_block
execute store result score #move.ox bs.data run data get storage bs:out hitbox.offset.x 10000000
execute store result score #move.oz bs.data run data get storage bs:out hitbox.offset.z 10000000
scoreboard players operation #move.ox bs.data += #move.x bs.data
scoreboard players operation #move.oz bs.data += #move.z bs.data
function bs.move:collision/check/block/shape
