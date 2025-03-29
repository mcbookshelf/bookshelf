# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

$data modify storage bs:ctx _ set value {run:'$(run)',with:$(with)}
data modify storage bs:ctx _.id set from storage bs:ctx _.with.id

# Handle the unit, return early on failure
execute if data storage bs:ctx _.with.unit store success score #s bs.ctx run function bs.schedule:schedule/unit/handle with storage bs:ctx _.with
execute if data storage bs:ctx _.with.unit if score #s bs.ctx matches 0 run return run function #bs.log:error {namespace:"bs.schedule", tag:"schedule", path:"#bs.schedule:schedule", message:["Unit '",{storage:"bs:ctx",nbt:"_.with.unit"},"' is not supported."]}

# Schedule the callback, update the gametime and add a unique id
execute unless data storage bs:ctx _.with.time run data modify storage bs:ctx _.with.time set value 1
execute store result storage bs:ctx _.time int 1 run function bs.schedule:schedule/callback with storage bs:ctx _.with
execute store result storage bs:ctx _.suid int 1 run scoreboard players add #schedule.suid bs.data 1

# Get the current context (entity location and selector)
function bs.schedule:schedule/context/get_dimension
execute in minecraft:overworld as B5-0-0-0-1 run function bs.schedule:schedule/context/get_position
execute unless score @s bs.schedule.id matches -2147483648.. store result score @s bs.schedule.id run scoreboard players add #counter bs.schedule.id 1
execute if entity @s store result storage bs:ctx _.esid int 1 run scoreboard players get @s bs.schedule.id

# Add the command to the schedule queue
data remove storage bs:ctx _.with
data modify storage bs:data schedule.queue prepend from storage bs:ctx _
function #bs.log:info {namespace:"bs.schedule", tag:"schedule", path:"#bs.schedule:schedule", message:'"Command scheduled."'}
return run scoreboard players get #schedule.suid bs.data
