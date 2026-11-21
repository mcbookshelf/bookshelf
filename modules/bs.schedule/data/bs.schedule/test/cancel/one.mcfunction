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

# Commands with the id are cancelled for the entity only, and an entity that never scheduled cancels nothing
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.cancel_one","ward.schedule.cancel_one.a"]}
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.cancel_one","ward.schedule.cancel_one.b"]}
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.cancel_one","ward.schedule.cancel_one.c"]}
data modify storage bs.schedule:schedule in set value {run:"tag @s add ward.schedule.cancel_one.ran",time:2,id:"ward.schedule.cancel_one"}
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.a] run function #bs.schedule:schedule/append
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.b] run function #bs.schedule:schedule/append
data modify storage bs.schedule:cancel in set value {id:"ward.schedule.cancel_one"}
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.a] unless function #bs.schedule:cancel/one run fail "cancelling commands is a failure"
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.a] if function #bs.schedule:cancel/one run fail "cancelling nothing is a success"
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.c] if function #bs.schedule:cancel/one run fail "an entity that never scheduled cancels something"
await entity @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.b,tag=ward.schedule.cancel_one.ran]
await delay 1t
assert not entity @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.a,tag=ward.schedule.cancel_one.ran]

# The id can be given as an argument
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.c] run function #bs.schedule:schedule/append.in {id:"ward.schedule.cancel_one.in",run:"tag @s add ward.schedule.cancel_one.ran",time:2}
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.c] run function #bs.schedule:cancel/one.in {id:"ward.schedule.cancel_one.in"}
await delay 3t
assert not entity @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_one.c,tag=ward.schedule.cancel_one.ran]
kill @e[type=minecraft:armor_stand,tag=ward.schedule.cancel_one]
