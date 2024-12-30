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

$execute store result score #h bs.ctx run data get storage bs:const health.point $(points)

execute store result score #m bs.ctx run attribute @s minecraft:max_health get 100000
execute store result score #a bs.ctx run attribute @s minecraft:max_health modifier value get bs.health:limit
scoreboard players operation #m bs.ctx -= #a bs.ctx
execute store result storage bs:ctx y double 0.00001 run scoreboard players operation #m bs.ctx += #h bs.ctx

execute store success score #s bs.ctx run attribute @s minecraft:max_health modifier value get bs.health:limit
execute if score #s bs.ctx matches 1 store result storage bs:ctx x double 0.00001 run scoreboard players operation #a bs.ctx -= #h bs.ctx
execute if score #s bs.ctx matches 1 if score #a bs.ctx matches ..0 run function bs.health:apply/increase_health with storage bs:ctx

function bs.health:apply/set_max_health with storage bs:ctx
