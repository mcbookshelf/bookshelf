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

execute unless entity @s[scores={bs.width=1..,bs.height=1..,bs.depth=1..}] run return 0

# get hitbox dimensions (width, depth, height)
execute store result storage bs:ctx w float 0.0001 run scoreboard players get @s bs.width
execute store result storage bs:ctx h float 0.0001 run scoreboard players get @s bs.height
execute store result storage bs:ctx d float 0.0001 run scoreboard players get @s bs.depth

# run size-based collision check
execute if entity @s[tag=bs.hitbox.centered] run return run function bs.raycast:check/entity/aabb
data modify storage bs:data raycast.ry set compute default float {type:"add",inputs:[{type:"storage",storage:"bs:data",path:"raycast.ry"},{type:"storage",storage:"bs:ctx",path:"h"}]}
function bs.raycast:check/entity/aabb
data modify storage bs:data raycast.ry set compute default float {type:"sub",left:{type:"storage",storage:"bs:data",path:"raycast.ry"},right:{type:"storage",storage:"bs:ctx",path:"h"}}
