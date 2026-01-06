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

data remove storage bs:lambda hitbox

execute if score #raycast.bpiercing bs.data matches 0.. run scoreboard players remove #raycast.bpiercing bs.data 1
scoreboard players operation $raycast.piercing bs.lambda = #raycast.bpiercing bs.data

scoreboard players set $raycast.hit_flag bs.lambda 0
execute if data storage bs:data raycast.record[{flag:1}] run scoreboard players add $raycast.hit_flag bs.lambda 1
execute if data storage bs:data raycast.record[{flag:2}] run scoreboard players add $raycast.hit_flag bs.lambda 2
execute if data storage bs:data raycast.record[{flag:4}] run scoreboard players add $raycast.hit_flag bs.lambda 4
execute if data storage bs:data raycast.record[{flag:8}] run scoreboard players add $raycast.hit_flag bs.lambda 8
execute unless data storage bs:data raycast.on_hit_point run data remove storage bs:data raycast.record

execute if data storage bs:data raycast.on_targeted_block run function bs.raycast:utils/on_targeted_block with storage bs:data raycast
