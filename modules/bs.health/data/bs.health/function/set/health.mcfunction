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

# Note: Thanks to XanBelOr for giving the idea of using the effects_changed trigger advancement

execute store result score #h bs.ctx run data get entity @s Health 100000
execute store result score #m bs.ctx run attribute @s minecraft:max_health get 100000
$execute store result score @s bs.hmod run data get storage bs:const health.point $(points)
scoreboard players operation @s bs.hmod < #m bs.ctx
scoreboard players operation @s bs.hmod -= #h bs.ctx
scoreboard players operation #m bs.ctx -= #h bs.ctx
execute if score @s bs.hmod matches ..-1 run return run function bs.health:utils/decrease_health
execute if score @s bs.hmod matches 1.. run return run function bs.health:utils/increase_health
