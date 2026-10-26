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

# A command is not scheduled while one with the same id is pending
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:unique out.first set value 1b",time:2,id:"ward.schedule.unique"}
execute unless function #bs.schedule:schedule/unique run fail "a scheduled command is a failure"
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:unique out.second set value 1b",time:1,id:"ward.schedule.unique"}
execute if function #bs.schedule:schedule/unique run fail "a command with a pending id is a success"
await data storage ward.schedule:unique out.first
assert not data storage ward.schedule:unique out.second

# Once the command ran, the id is free again
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:unique out.second set value 1b",time:1,id:"ward.schedule.unique"}
function #bs.schedule:schedule/unique
await data storage ward.schedule:unique out.second

# A command with another id is scheduled
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:unique out.third set value 1b",time:2,id:"ward.schedule.unique"}
function #bs.schedule:schedule/unique
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:unique out.other set value 1b",time:1,id:"ward.schedule.unique.other"}
function #bs.schedule:schedule/unique
await data storage ward.schedule:unique out.other
await data storage ward.schedule:unique out.third

# An entity only waits for its own commands
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.unique","ward.schedule.unique.a"]}
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.unique","ward.schedule.unique.b"]}
data modify storage bs.schedule:schedule in set value {run:"tag @s add ward.schedule.unique.ran",time:2,id:"ward.schedule.unique.own"}
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.unique.a] run function #bs.schedule:schedule/unique
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.unique.b] run function #bs.schedule:schedule/unique
await entity @n[type=minecraft:armor_stand,tag=ward.schedule.unique.a,tag=ward.schedule.unique.ran]
assert entity @n[type=minecraft:armor_stand,tag=ward.schedule.unique.b,tag=ward.schedule.unique.ran]
kill @e[type=minecraft:armor_stand,tag=ward.schedule.unique]
