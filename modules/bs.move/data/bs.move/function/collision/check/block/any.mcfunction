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

# if the block is a full cube, check collision using a fixed 1×1×1 AABB
data remove storage bs:lambda hitbox
scoreboard players set #move.hit_flag bs.data 0
$execute store result storage bs:ctx y int 1 store result score #move.hit_flag bs.data run $(blocks)
execute if score #move.hit_flag bs.data matches 1.. unless data storage bs:lambda hitbox run return run function bs.move:collision/check/block/cube with storage bs:ctx

# otherwise, check collision against the block shape
execute store result score #p bs.ctx run data get storage bs:lambda hitbox.offset.x 10000000
execute store result score #q bs.ctx run data get storage bs:lambda hitbox.offset.z 10000000
scoreboard players operation #p bs.ctx += #move.x bs.data
scoreboard players operation #q bs.ctx += #move.z bs.data
execute store result score #move.hit_flag bs.data store result storage bs:ctx y int 1 run data get storage bs:lambda hitbox.shape[-1][6]
execute if score #move.hit_flag bs.data matches 0 store result storage bs:ctx y int 1 run scoreboard players set #move.hit_flag bs.data 1
execute if data storage bs:lambda hitbox.shape[-1] run function bs.move:collision/check/block/shape with storage bs:ctx
