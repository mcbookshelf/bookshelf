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

execute summon minecraft:marker run function bs.generation:utils/get_location
execute unless data storage bs:data generation._.dim run function bs.generation:utils/get_dimension

execute store result storage bs:data generation._.x int 1 run scoreboard players get $generation.x bs.lambda
execute store result storage bs:data generation._.y int 1 run scoreboard players get $generation.y bs.lambda

data modify storage bs:data generation.shape_2d prepend from storage bs:data generation._
schedule function bs.generation:shape_2d/process/scheduled 1t replace
