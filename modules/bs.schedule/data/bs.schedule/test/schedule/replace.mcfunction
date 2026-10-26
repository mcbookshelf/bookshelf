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

data remove storage ward.schedule:replace out

# The last call takes the place of the pending ones, whatever their tick
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:replace out.first set value 1b",time:2,id:"ward.schedule.replace"}
function #bs.schedule:schedule/replace
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:replace out.second set value 1b",time:4,id:"ward.schedule.replace"}
function #bs.schedule:schedule/replace
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:replace out.third set value 1b",time:3,id:"ward.schedule.replace"}
function #bs.schedule:schedule/replace
await data storage ward.schedule:replace out.third
await delay 2t
assert not data storage ward.schedule:replace out.first
assert not data storage ward.schedule:replace out.second

# An entity only replaces its own commands
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.replace","ward.schedule.replace.a"]}
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.replace","ward.schedule.replace.b"]}
data modify storage bs.schedule:schedule in set value {run:"tag @s add ward.schedule.replace.ran",time:2,id:"ward.schedule.replace.own"}
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.replace.a] run function #bs.schedule:schedule/replace
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.replace.b] run function #bs.schedule:schedule/replace
await entity @n[type=minecraft:armor_stand,tag=ward.schedule.replace.a,tag=ward.schedule.replace.ran]
assert entity @n[type=minecraft:armor_stand,tag=ward.schedule.replace.b,tag=ward.schedule.replace.ran]
kill @e[type=minecraft:armor_stand,tag=ward.schedule.replace]
