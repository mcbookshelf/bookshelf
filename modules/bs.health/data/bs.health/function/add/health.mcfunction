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

# Note: Thanks to XanBelOr for the idea of using the effects_changed trigger advancement

# Get current health, max_health, and input points
execute store result score #h bs.ctx run data get entity @s Health 100000
execute store result score #m bs.ctx run attribute @s minecraft:max_health get 100000
$execute store result score #p bs.ctx run data get storage bs:const health.point $(points)

# Add incoming points to the healing modifier and clamp to max possible healing
scoreboard players operation @s bs.hmod += #p bs.ctx
scoreboard players operation #m bs.ctx -= #h bs.ctx
scoreboard players operation @s bs.hmod < #m bs.ctx

# Apply health change: reduction is instant, increase waits for instant_health to take effect
execute if score @s bs.hmod matches ..-1 run return run function bs.health:utils/decrease_health
execute if score @s bs.hmod matches 1.. run return run function bs.health:utils/increase_health
