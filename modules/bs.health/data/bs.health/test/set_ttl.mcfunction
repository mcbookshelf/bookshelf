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

summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.health.set_ttl"]}
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl] run function #bs.health:set_ttl.in {time:5}
await delay 4t
assert entity @n[type=minecraft:armor_stand,tag=ward.health.set_ttl] inside
await delay 1t
assert not entity @n[type=minecraft:armor_stand,tag=ward.health.set_ttl] inside

summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.health.set_ttl","ward.health.set_ttl.long"]}
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.health.set_ttl","ward.health.set_ttl.short"]}
data modify storage bs.health:set_ttl in set value {time:"10t"}
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl.long] run function #bs.health:set_ttl
data modify storage bs.health:set_ttl in set value {time:"5t"}
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl.short] run function #bs.health:set_ttl
await not entity @n[type=minecraft:armor_stand,tag=ward.health.set_ttl.short] inside
assert entity @n[type=minecraft:armor_stand,tag=ward.health.set_ttl.long] inside
await not entity @n[type=minecraft:armor_stand,tag=ward.health.set_ttl.long] inside

summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.health.set_ttl"]}
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl] run function #bs.health:set_ttl.in {time:5}
await delay 4t
execute as @n[type=minecraft:armor_stand,tag=ward.health.set_ttl] run function #bs.health:set_ttl.in {time:5}
await delay 4t
assert entity @n[type=minecraft:armor_stand,tag=ward.health.set_ttl] inside
await not entity @n[type=minecraft:armor_stand,tag=ward.health.set_ttl] inside
kill @e[type=minecraft:armor_stand,tag=ward.health.set_ttl]
