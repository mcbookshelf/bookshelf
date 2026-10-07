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

execute store result score #s bs.ctx run function bs.hitbox:utils/provide_entities with storage bs.hitbox:overlaps/blocks in
execute if score #s bs.ctx matches 0 run return fail
summon minecraft:marker ~ ~ ~ {UUID:[I;181,0,0,0]}
execute align xyz as B5-0-0-0-0 run function bs.hitbox:utils/get_relative_pos
execute store result score #m bs.ctx run data get storage bs.hitbox:get_entity out
execute store result score #a bs.ctx store result storage bs.hitbox: x int 1 run compute default integer bs.hitbox:_overlaps/blocks/min_x
execute store result score #b bs.ctx store result storage bs.hitbox: y int 1 run compute default integer bs.hitbox:_overlaps/blocks/min_y
execute store result score #c bs.ctx store result storage bs.hitbox: z int 1 run compute default integer bs.hitbox:_overlaps/blocks/min_z
execute store result score #u bs.ctx run compute default integer bs.hitbox:_overlaps/blocks/max_x
execute store result score #v bs.ctx run compute default integer bs.hitbox:_overlaps/blocks/max_y
execute store result score #w bs.ctx run compute default integer bs.hitbox:_overlaps/blocks/max_z
scoreboard players operation #j bs.ctx = #b bs.ctx
execute align xyz run return run function bs.hitbox:overlaps/blocks/custom/scan with storage bs.hitbox:
