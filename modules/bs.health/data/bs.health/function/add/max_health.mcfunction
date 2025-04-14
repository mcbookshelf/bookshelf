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

# Get input points and base max_health
$execute store result score #p bs.ctx run data get storage bs:const health.point $(points)
execute store result score #m bs.ctx run attribute @s minecraft:max_health base get 100000

# Add points to base max_health and apply the result
execute store result storage bs:ctx y double .00001 run scoreboard players operation #m bs.ctx += #p bs.ctx
function bs.health:utils/set_max_health with storage bs:ctx
