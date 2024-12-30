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

scoreboard players set #t bs.ctx 0
summon minecraft:armor_stand ~ ~ ~ {Tags:["bs.packtest"]}
execute as @e[type=minecraft:armor_stand,tag=bs.packtest] run function #bs.health:time_to_live {with:{time:5,on_death:"scoreboard players set #t bs.ctx 1"}}
await delay 5t

assert score #t bs.ctx matches 1
assert not entity @e[type=minecraft:armor_stand,distance=..1] inside
