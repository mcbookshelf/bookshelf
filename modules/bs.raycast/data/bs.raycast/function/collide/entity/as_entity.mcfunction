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

execute store result score #raycast.etmin bs.data run scoreboard players set @s bs.tmin 2147483647
scoreboard players operation #raycast.etmin bs.data < @e[distance=..255,scores={bs.tmin=0..}] bs.tmin

data modify storage bs:lambda raycast.targeted_entity set from entity @s UUID

data modify storage bs:lambda raycast.hit_normal set value [0,0,0]
execute if entity @s[tag=bs.raycast.normx] store result storage bs:lambda raycast.hit_normal[0] int -1 run data get storage bs:data raycast.sx
execute if entity @s[tag=bs.raycast.normy] store result storage bs:lambda raycast.hit_normal[1] int -1 run data get storage bs:data raycast.sy
execute if entity @s[tag=bs.raycast.normz] store result storage bs:lambda raycast.hit_normal[2] int -1 run data get storage bs:data raycast.sz

execute if data storage bs:data raycast.on_targeted_entity at @s run function bs.raycast:utils/on_targeted_entity with storage bs:data raycast
