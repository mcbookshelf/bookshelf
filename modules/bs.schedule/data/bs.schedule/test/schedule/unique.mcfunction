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

data remove storage ward.schedule:unique out

# On the same tick, the last call takes the place of the pending one
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:unique out.first set value 1b",time:2,id:"ward.schedule.unique"}
function #bs.schedule:schedule/unique
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:unique out.second set value 1b",time:2,id:"ward.schedule.unique"}
function #bs.schedule:schedule/unique

# A command with the same id on another tick is kept
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:unique out.later set value 1b",time:4,id:"ward.schedule.unique"}
function #bs.schedule:schedule/unique
await data storage ward.schedule:unique out.later
assert not data storage ward.schedule:unique out.first
assert data storage ward.schedule:unique out.second

# An entity only replaces its own commands
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.unique","ward.schedule.unique.a"]}
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.unique","ward.schedule.unique.b"]}
data modify storage bs.schedule:schedule in set value {run:"tag @s add ward.schedule.unique.ran",time:2,id:"ward.schedule.unique.own"}
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.unique.a] run function #bs.schedule:schedule/unique
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.unique.b] run function #bs.schedule:schedule/unique
await entity @n[type=minecraft:armor_stand,tag=ward.schedule.unique.a,tag=ward.schedule.unique.ran]
assert entity @n[type=minecraft:armor_stand,tag=ward.schedule.unique.b,tag=ward.schedule.unique.ran]
kill @e[type=minecraft:armor_stand,tag=ward.schedule.unique]
