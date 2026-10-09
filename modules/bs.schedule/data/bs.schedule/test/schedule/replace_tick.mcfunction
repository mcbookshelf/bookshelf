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

data remove storage ward.schedule:replace_tick out

# On the same tick, the last call takes the place of the pending one
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:replace_tick out.first set value 1b",time:2,id:"ward.schedule.replace_tick"}
function #bs.schedule:schedule/replace_tick
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:replace_tick out.second set value 1b",time:2,id:"ward.schedule.replace_tick"}
function #bs.schedule:schedule/replace_tick

# A command with the same id on another tick is kept
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:replace_tick out.later set value 1b",time:4,id:"ward.schedule.replace_tick"}
function #bs.schedule:schedule/replace_tick
await data storage ward.schedule:replace_tick out.later
assert not data storage ward.schedule:replace_tick out.first
assert data storage ward.schedule:replace_tick out.second

# An entity only replaces its own commands
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.replace_tick","ward.schedule.replace_tick.a"]}
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.replace_tick","ward.schedule.replace_tick.b"]}
data modify storage bs.schedule:schedule in set value {run:"tag @s add ward.schedule.replace_tick.ran",time:2,id:"ward.schedule.replace_tick.own"}
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.replace_tick.a] run function #bs.schedule:schedule/replace_tick
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.replace_tick.b] run function #bs.schedule:schedule/replace_tick
await entity @n[type=minecraft:armor_stand,tag=ward.schedule.replace_tick.a,tag=ward.schedule.replace_tick.ran]
assert entity @n[type=minecraft:armor_stand,tag=ward.schedule.replace_tick.b,tag=ward.schedule.replace_tick.ran]
kill @e[type=minecraft:armor_stand,tag=ward.schedule.replace_tick]
