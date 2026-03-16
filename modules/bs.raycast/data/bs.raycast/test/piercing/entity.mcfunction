# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

summon minecraft:armor_stand ~.6 ~ ~.5
summon minecraft:armor_stand ~.5 ~ ~.5
summon minecraft:armor_stand ~.4 ~ ~.5

execute store result score #packtest.on_entry_point bs.data store result score #packtest.on_exit_point bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~1.5 ~.5 ~.5 facing ~-.5 ~ ~ run function #bs.raycast:run {with:{blocks:false,entities:true,piercing:{entities:1},max_distance:4,on_entry_point:"scoreboard players add #packtest.on_entry_point bs.data 1",on_exit_point:"scoreboard players add #packtest.on_exit_point bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}

assert score #packtest.on_entry_point bs.data matches 2
assert score #packtest.on_exit_point bs.data matches 2
assert score #packtest.on_targeted_entity bs.data matches 2

execute store result score #packtest.on_entry_point bs.data store result score #packtest.on_exit_point bs.data run scoreboard players set #packtest.on_targeted_entity bs.data 0
execute positioned ~1.5 ~.5 ~.5 facing ~-.5 ~ ~ run function #bs.raycast:run {with:{blocks:false,entities:true,piercing:{entities:-1},max_distance:4,on_entry_point:"scoreboard players add #packtest.on_entry_point bs.data 1",on_exit_point:"scoreboard players add #packtest.on_exit_point bs.data 1",on_targeted_entity:"scoreboard players add #packtest.on_targeted_entity bs.data 1"}}

assert score #packtest.on_entry_point bs.data matches 3
assert score #packtest.on_exit_point bs.data matches 3
assert score #packtest.on_targeted_entity bs.data matches 3
