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

execute if score #generate.i bs.data matches 0 run return run function bs.generate:shape_2d/process/pause

$execute if score #generate.i bs.data matches 1.. run function bs.generate:shape_2d/strategy/$(impl)/run with storage bs:data generate._
scoreboard players remove #generate.i bs.data 1

scoreboard players add $generate.x bs.data 1
$execute if score $generate.x bs.data < #generate.w bs.data positioned ^ ^$(spacing) ^ run return run function bs.generate:shape_2d/recurse/next with storage bs:data generate._
scoreboard players set $generate.x bs.data 0
scoreboard players add $generate.y bs.data 1
$execute if score $generate.y bs.data < #generate.h bs.data positioned ~ $(oy) $(oz) positioned ^$(spacing) ^ ^ run function bs.generate:shape_2d/recurse/next with storage bs:data generate._
