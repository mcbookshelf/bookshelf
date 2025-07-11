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

forceload add -30000000 1600
execute unless entity B5-0-0-0-1 run summon minecraft:marker -30000000 0 1600 {UUID:[I;181,0,0,1],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"]}
execute unless entity B5-0-0-0-3 run summon minecraft:item_display -30000000 0 1600 {UUID:[I;181,0,0,3],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],view_range:0f}

scoreboard objectives add bs.const dummy [{text:"BS ",color:"dark_gray"},{text:"Constants",color:"aqua"}]
scoreboard objectives add bs.ctx dummy [{text:"BS ",color:"dark_gray"},{text:"Context",color:"aqua"}]
scoreboard objectives add bs.out dummy [{text:"BS ",color:"dark_gray"},{text:"Output",color:"aqua"}]

scoreboard objectives add bs.width dummy [{text:"BS ",color:"dark_gray"},{text:"Width",color:"aqua"}]
scoreboard objectives add bs.height dummy [{text:"BS ",color:"dark_gray"},{text:"Height",color:"aqua"}]
scoreboard objectives add bs.depth dummy [{text:"BS ",color:"dark_gray"},{text:"Depth",color:"aqua"}]

scoreboard players set 2 bs.const 2
scoreboard players set 11 bs.const 11
scoreboard players set 15 bs.const 15
scoreboard players set 255 bs.const 255
scoreboard players set 1000 bs.const 1000
scoreboard players set 65536 bs.const 65536
scoreboard players set 3129871 bs.const 3129871
scoreboard players set 1000000 bs.const 1000000
scoreboard players set 10000000 bs.const 10000000
scoreboard players set 16777216 bs.const 16777216
scoreboard players set 42317861 bs.const 42317861
scoreboard players set 116129781 bs.const 116129781
scoreboard players set 268435456 bs.const 268435456

data modify storage bs:data hitbox.offsets set value []
