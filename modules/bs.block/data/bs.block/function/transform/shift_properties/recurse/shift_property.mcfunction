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

scoreboard players set #n bs.ctx 1
execute if data storage bs:ctx _.i[-1].by store result score #n bs.ctx run data get storage bs:ctx _.i[-1].by

scoreboard players set #i bs.ctx 0
$execute store success score #s bs.ctx run data modify storage bs:ctx _.i[-1].v set from storage bs:out block.properties."$(name)"
execute if score #s bs.ctx matches 1 \
  store result score #i bs.ctx \
  run function bs.block:transform/shift_properties/recurse/index with storage bs:ctx _.i[-1]

scoreboard players operation #i bs.ctx += #n bs.ctx
execute store result storage bs:ctx _.i[-1].i short 1 run scoreboard players operation #i bs.ctx %= #l bs.ctx
function bs.block:transform/shift_properties/recurse/update_property with storage bs:ctx _.i[-1]
