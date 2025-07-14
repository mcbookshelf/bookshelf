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

execute unless entity @s[scores={bs.width=1..,bs.height=1..,bs.depth=1..}] run return 0

# get hitbox dimensions (width, depth, height)
scoreboard players operation #w bs.ctx = @s bs.width
scoreboard players operation #h bs.ctx = @s bs.height
scoreboard players operation #d bs.ctx = @s bs.depth

# run size-based collision check
execute if entity @s[tag=bs.hitbox.centered] run return run function bs.raycast:check/entity/size
scoreboard players operation #raycast.ry bs.data += #h bs.ctx
function bs.raycast:check/entity/size
scoreboard players operation #raycast.ry bs.data -= #h bs.ctx
