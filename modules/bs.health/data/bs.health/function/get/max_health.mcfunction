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

execute store result score #m bs.ctx run attribute @s minecraft:max_health get 100000
execute store result score #a bs.ctx run attribute @s minecraft:max_health modifier value get bs.health:limit 100000
execute store result storage bs:out health.get_max_health double 0.00001 run scoreboard players operation #m bs.ctx -= #a bs.ctx
$return run data get storage bs:out health.get_max_health $(scale)
