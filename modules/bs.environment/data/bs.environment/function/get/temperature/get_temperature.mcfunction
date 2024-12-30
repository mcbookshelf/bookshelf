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

loot replace block -30000000 0 1606 container.0 loot bs.environment:get/get_biome
execute store result score #t bs.ctx run data get block -30000000 0 1606 item.components."minecraft:custom_data".temperature
execute store result storage bs:ctx y double .00000001 summon minecraft:marker run function bs.environment:get/temperature/variation
$execute store result score $environment.get_temperature bs.out run return run data get storage bs:ctx y $(scale)
