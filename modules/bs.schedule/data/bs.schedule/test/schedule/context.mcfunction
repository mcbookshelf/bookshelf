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

# @dummy

# The command runs as the entity that scheduled it
data modify storage bs.schedule:schedule in set value {run:"tag @s add ward.schedule.context.as",time:1,id:"ward.schedule.context"}
function #bs.schedule:schedule/append
await entity @s[tag=ward.schedule.context.as]

# The command runs at the position it was scheduled from
setblock ~ ~1 ~ minecraft:bookshelf
data modify storage bs.schedule:schedule in set value {run:"execute if block ~ ~1 ~ minecraft:bookshelf run tag @s add ward.schedule.context.at",time:1,id:"ward.schedule.context"}
function #bs.schedule:schedule/append
await entity @s[tag=ward.schedule.context.at]

# The command runs with the rotation it was scheduled with
data modify storage bs.schedule:schedule in set value {run:"execute positioned ^ ^ ^1 if block ~ ~ ~ minecraft:bookshelf run tag @s add ward.schedule.context.rotated",time:1,id:"ward.schedule.context"}
execute rotated 0 -90 run function #bs.schedule:schedule/append
await entity @s[tag=ward.schedule.context.rotated]

# The command runs in the dimension it was scheduled from
data modify storage bs.schedule:schedule in set value {run:"execute if dimension minecraft:the_nether run tag @s add ward.schedule.context.in",time:1,id:"ward.schedule.context"}
execute in minecraft:the_nether run function #bs.schedule:schedule/append
await entity @s[tag=ward.schedule.context.in]

# The command runs at the position it was scheduled from, in another dimension too
data modify storage bs.schedule:schedule in set value {run:'execute if predicate {type:"minecraft:location_check",predicate:{dimension:"minecraft:the_nether",position:{x:{min:79.9,max:80.1},y:{min:63.9,max:64.1},z:{min:79.9,max:80.1}}}} run tag @s add ward.schedule.context.nether',time:1,id:"ward.schedule.context"}
execute in minecraft:the_nether positioned 80.0 64.0 80.0 run function #bs.schedule:schedule/append
await entity @s[tag=ward.schedule.context.nether]
