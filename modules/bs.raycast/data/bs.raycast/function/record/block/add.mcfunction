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

data modify storage bs:ctx _ set value {l:[],r:[],e:{flag:1}}
data modify storage bs:ctx _.e.flag set from storage bs:lambda hitbox.shape[-1][6]
execute store result score #f bs.ctx run data get storage bs:ctx _.e.flag
scoreboard players set #n bs.ctx 1
execute if score #z bs.ctx = #x bs.ctx run scoreboard players set #n bs.ctx 2
execute if score #y bs.ctx = #x bs.ctx run scoreboard players set #n bs.ctx 3

execute if score #x bs.ctx > #raycast.tb bs.data run function bs.raycast:record/block/slice_right
execute if data storage bs:data raycast.rb[-1] run function bs.raycast:record/block/slice_left
scoreboard players operation #raycast.tb bs.data < #x bs.ctx
scoreboard players operation #raycast.tm bs.data < #raycast.tb bs.data

execute store result storage bs:ctx _.e.tmin int 1 run scoreboard players get #x bs.ctx
execute store result storage bs:ctx _.e.tmax int 1 run scoreboard players get #i bs.ctx
execute store result storage bs:ctx _.e.norm int 1 run scoreboard players get #n bs.ctx

data modify storage bs:data raycast.rb append from storage bs:ctx _.l[]
data modify storage bs:data raycast.rb append from storage bs:ctx _.e
data modify storage bs:data raycast.rb append from storage bs:ctx _.r[]
