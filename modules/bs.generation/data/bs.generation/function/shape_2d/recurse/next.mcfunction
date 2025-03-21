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

execute if score #generation.i bs.data matches 0 run return run function bs.generation:shape_2d/process/pause

$execute if score #generation.i bs.data matches 1.. run function bs.generation:shape_2d/strategy/$(impl)/run with storage bs:data generation._
scoreboard players remove #generation.i bs.data 1

scoreboard players add $generation.x bs.lambda 1
$execute if score $generation.x bs.lambda < #generation.w bs.data positioned ^ ^$(spacing) ^ run return run function bs.generation:shape_2d/recurse/next with storage bs:data generation._
scoreboard players set $generation.x bs.lambda 0
scoreboard players add $generation.y bs.lambda 1
$execute if score $generation.y bs.lambda < #generation.h bs.data positioned ~ $(oy) $(oz) positioned ^$(spacing) ^ ^ run function bs.generation:shape_2d/recurse/next with storage bs:data generation._
