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

function bs.raycast:utils/tp_hit_point with storage bs:lambda raycast
execute if data storage bs:data raycast.data{hit_point:1b} run data modify storage bs:lambda raycast.hit_point set from entity @s Pos
execute positioned as @s as @n[predicate=bs.raycast:internal/collide,distance=..24,sort=arbitrary] run function bs.raycast:collide/entity/target
tp @s ~ ~ ~

scoreboard players operation #raycast.epiercing bs.data = $raycast.piercing bs.lambda
execute unless data storage bs:data raycast.piercing{} run scoreboard players operation #raycast.bpiercing bs.data = #raycast.epiercing bs.data
