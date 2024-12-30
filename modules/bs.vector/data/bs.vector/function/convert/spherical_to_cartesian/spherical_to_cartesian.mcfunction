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

$scoreboard players set #s bs.ctx $(scaling)
scoreboard players set #t bs.ctx 1000000000
execute store result storage bs:ctx y double .000000001 run scoreboard players operation #t bs.ctx /= #s bs.ctx
execute store result storage bs:ctx x int 1 run scoreboard players get $vector.spherical_to_cartesian.2 bs.in
execute in minecraft:overworld as B5-0-0-0-1 run function bs.vector:convert/spherical_to_cartesian/compute with storage bs:ctx
execute store result score $vector.spherical_to_cartesian.0 bs.out run data get storage bs:ctx _[0]
execute store result score $vector.spherical_to_cartesian.1 bs.out run data get storage bs:ctx _[1]
execute store result score $vector.spherical_to_cartesian.2 bs.out run data get storage bs:ctx _[2]
