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

data modify storage bs:ctx _ set value {left:[],right:[],entry:{flag:1}}
execute store result score #n bs.ctx run scoreboard players set #f bs.ctx 1
execute if score #z bs.ctx = #x bs.ctx run scoreboard players set #n bs.ctx 2
execute if score #y bs.ctx = #x bs.ctx run scoreboard players set #n bs.ctx 3
execute if data storage bs:lambda hitbox.shape[-1][6] \
  store result score #f bs.ctx store result storage bs:ctx _.entry.flag int 1 \
  run data get storage bs:lambda hitbox.shape[-1][6]

execute if score #x bs.ctx > #raycast.btoi bs.data run function bs.raycast:collide/record/slice/right
execute if data storage bs:data raycast.record[-1] run function bs.raycast:collide/record/slice/left
scoreboard players operation #raycast.btoi bs.data < #x bs.ctx
scoreboard players operation $raycast.distance bs.lambda < #raycast.btoi bs.data

execute store result storage bs:ctx _.entry.tmin int 1 run scoreboard players get #x bs.ctx
execute store result storage bs:ctx _.entry.tmax int 1 run scoreboard players get #i bs.ctx
execute store result storage bs:ctx _.entry.norm int 1 run scoreboard players get #n bs.ctx

data modify storage bs:data raycast.record append from storage bs:ctx _.left[]
data modify storage bs:data raycast.record append from storage bs:ctx _.entry
data modify storage bs:data raycast.record append from storage bs:ctx _.right[]
