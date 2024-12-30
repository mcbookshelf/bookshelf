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

# compute output data and run callbacks
tp @s ~ ~ ~
data modify storage bs:out raycast.targeted_block set from entity @s Pos
execute store result storage bs:out raycast.distance double .001 run scoreboard players get #raycast.distance bs.data
execute if data storage bs:data raycast.on_targeted_block at @s run function bs.raycast:react/targeted_block with storage bs:data raycast
execute summon minecraft:marker run function bs.raycast:compute/hit_point with storage bs:out raycast

# stop the recursion if piercing is 0
execute unless score #raycast.piercing bs.data matches 0 run scoreboard players set #raycast.distance bs.data 2147483647
execute if score #raycast.piercing bs.data matches 0 run scoreboard players set #raycast.max_distance bs.data -2147483648
scoreboard players remove #raycast.piercing bs.data 1
