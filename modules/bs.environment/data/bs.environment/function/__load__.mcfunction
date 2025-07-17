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
execute unless entity B5-0-0-0-3 run summon minecraft:item_display -30000000 0 1600 {UUID:[I;181,0,0,3],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],view_range:0f}

scoreboard objectives add bs.const dummy [{text:"BS ",color:"dark_gray"},{text:"Constants",color:"aqua"}]
scoreboard objectives add bs.ctx dummy [{text:"BS ",color:"dark_gray"},{text:"Context",color:"aqua"}]
scoreboard objectives add bs.out dummy [{text:"BS ",color:"dark_gray"},{text:"Output",color:"aqua"}]

scoreboard players set -4 bs.const -4
scoreboard players set -1 bs.const -1
scoreboard players set 2 bs.const 2
scoreboard players set 3 bs.const 3
scoreboard players set 8 bs.const 8
scoreboard players set 10 bs.const 10
scoreboard players set 180 bs.const 180
scoreboard players set 250 bs.const 250
scoreboard players set 360 bs.const 360
scoreboard players set 500 bs.const 500
scoreboard players set 1000 bs.const 1000
scoreboard players set 18000 bs.const 18000
scoreboard players set 24000 bs.const 24000
scoreboard players set 36000 bs.const 36000
scoreboard players set 90000 bs.const 90000
scoreboard players set 125000 bs.const 125000
scoreboard players set 180000 bs.const 180000
scoreboard players set 324000000 bs.const 324000000

data modify storage bs:const environment.moon_phases set value ["full_moon", "waning_gibbous", "third_quarter", "waning_crescent", "new_moon", "waxing_crescent", "first_quarter", "waxing_gibbous"]
