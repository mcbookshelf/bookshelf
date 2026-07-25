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

summon minecraft:armor_stand ~.5 ~ ~.5

execute positioned ~.5 ~.5 ~1.5 facing ~ ~ ~-.5 store result score #r bs.ctx run function #bs.raycast:run {with:{blocks:false,entities:true,on_entry_point:"assert score $raycast.entry_distance bs.lambda matches 750"}}
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted entity"

execute as @n[type=armor_stand,distance=..2,limit=1] run function #bs.hitbox:set_entity {with:{width:.8,height:1}}
execute positioned ~.5 ~.5 ~1.5 facing ~ ~ ~-.5 store result score #r bs.ctx run function #bs.raycast:run {with:{blocks:false,entities:true,on_entry_point:"assert score $raycast.entry_distance bs.lambda matches 600"}}
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted entity"
