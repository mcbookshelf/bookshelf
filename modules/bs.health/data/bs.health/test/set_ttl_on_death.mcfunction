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

summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.health.set_ttl_on_death"]}
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl_on_death] run function #bs.health:set_ttl.in {time:5}
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl_on_death] run function #bs.health:set_ttl_on_death.in {run:"setblock ~ ~ ~ minecraft:bone_block"}
await not entity @n[type=minecraft:armor_stand,tag=ward.health.set_ttl_on_death] inside
await block ~ ~ ~ minecraft:bone_block
setblock ~ ~ ~ minecraft:air

summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.health.set_ttl_on_death"]}
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl_on_death] run function #bs.health:set_ttl.in {time:5}
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl_on_death] run function #bs.health:set_ttl_on_death.in {run:"setblock ~ ~ ~ minecraft:bone_block"}
await delay 2t
data modify storage bs.health:set_ttl_on_death in set value {run:"setblock ~ ~ ~ minecraft:bookshelf"}
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl_on_death] run function #bs.health:set_ttl_on_death
await not entity @n[type=minecraft:armor_stand,tag=ward.health.set_ttl_on_death] inside
await block ~ ~ ~ minecraft:bookshelf
setblock ~ ~ ~ minecraft:air
kill @e[type=minecraft:armor_stand,tag=ward.health.set_ttl_on_death]
