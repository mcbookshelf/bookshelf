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

data remove storage ward.schedule:cancel_all out

# Commands with the id are cancelled for every entity, the others are kept
summon minecraft:armor_stand ~ ~ ~ {Tags:["ward.schedule.cancel_all"]}
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:cancel_all out.cancelled set value 1b",time:2,id:"ward.schedule.cancel_all"}
function #bs.schedule:schedule/append
execute as @n[type=minecraft:armor_stand,tag=ward.schedule.cancel_all] run function #bs.schedule:schedule/append
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:cancel_all out.kept set value 1b",time:3,id:"ward.schedule.cancel_all.kept"}
function #bs.schedule:schedule/append
data modify storage bs.schedule:cancel in set value {id:"ward.schedule.cancel_all"}
function #bs.schedule:cancel/all
await data storage ward.schedule:cancel_all out.kept
assert not data storage ward.schedule:cancel_all out.cancelled

# The id can be given as an argument
data modify storage bs.schedule:schedule in set value {run:"data modify storage ward.schedule:cancel_all out.cancelled set value 1b",time:2,id:"ward.schedule.cancel_all.in"}
function #bs.schedule:schedule/append
function #bs.schedule:cancel/all.in {id:"ward.schedule.cancel_all.in"}
await delay 3t
assert not data storage ward.schedule:cancel_all out.cancelled
kill @e[type=minecraft:armor_stand,tag=ward.schedule.cancel_all]
