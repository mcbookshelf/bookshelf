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

execute if data storage bs:data generation._{direction:"xz"} run data modify storage bs:data generation._.oz set from entity @s Pos[2]
execute unless data storage bs:data generation._{direction:"xz"} run data modify storage bs:data generation._.oy set from entity @s Pos[1]
kill @s

$function bs.generation:shape_2d/strategy/$(impl)/setup

execute if data storage bs:data generation._{direction:"xz"} rotated 0 90 run return run function bs.generation:shape_2d/recurse/next with storage bs:data generation._
execute if data storage bs:data generation._{direction:"xy"} rotated 0 0 run return run function bs.generation:shape_2d/recurse/next with storage bs:data generation._
execute if data storage bs:data generation._{direction:"zy"} rotated 90 0 run return run function bs.generation:shape_2d/recurse/next with storage bs:data generation._
