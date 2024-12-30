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

tag @s add bs.raycast.omit
scoreboard players set #raycast.distance bs.data 2147483647
execute store result score #raycast.piercing bs.data run data get storage bs:data raycast.piercing
execute store result score #raycast.max_distance bs.data run data get storage bs:data raycast.max_distance 1000
data modify storage bs:out raycast set value {distance:0d,hit_normal:[0,0,0]}
execute summon minecraft:marker run function bs.raycast:recurse/init
tag @e[tag=bs.raycast.omit] remove bs.raycast.omit
return run execute unless score #raycast.distance bs.data matches 2147483647
