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

# resolve collision using the on_collision callback (ensure the velocity vector is in canonical space for simpler transformation)
execute rotated as @s run function #bs.move:local_to_canonical
$function $(on_collision)
execute store result storage bs:ctx x double .0000001 run scoreboard players get $move.vel_remaining.x bs.data
execute store result storage bs:ctx y double .0000001 run scoreboard players get $move.vel_remaining.y bs.data
execute store result storage bs:ctx z double .0000001 run scoreboard players get $move.vel_remaining.z bs.data
execute unless data storage bs:ctx {x:0d,y:0d,z:0d} at @s run function bs.move:teleport/canonical/run with storage bs:ctx
execute rotated as @s run function #bs.move:canonical_to_local
