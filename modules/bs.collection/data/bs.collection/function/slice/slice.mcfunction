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

# Initialize min/max
$scoreboard players set #m bs.ctx $(min)
$scoreboard players set #n bs.ctx $(max)

scoreboard players set #i bs.ctx 0

# Get collection size
execute store result score #s bs.ctx run data get storage bs:out collection.value

# Handle negative indices
execute if score #m bs.ctx matches ..-1 run scoreboard players operation #m bs.ctx += #s bs.ctx
execute if score #n bs.ctx matches ..-1 run scoreboard players operation #n bs.ctx += #s bs.ctx

execute if score #m bs.ctx matches ..-1 run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:slice/slice", tag: "slice", message: '"Min must be in collection bounds"'} 
execute if score #m bs.ctx matches ..-1 run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:slice/slice", tag: "slice", message: '"Max must be in collection bounds"'} 
execute if score #m bs.ctx > #n bs.ctx run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:slice/slice", tag: "slice", message: '"Min must be lower than max"'} 
execute if score #m bs.ctx >= #s bs.ctx run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:slice/slice", tag: "slice", message: '"Min must be lower than collection size"'} 
execute if score #n bs.ctx >= #s bs.ctx run function #bs.log:error {namespace: "bs.collection", path: "bs.collection:slice/slice", tag: "slice", message: '"Max must be lower than collection size"'} 
execute unless score #m bs.ctx matches 0.. if score #m bs.ctx matches 0.. if score #m bs.ctx <= #n bs.ctx unless score #n bs.ctx < #s bs.ctx unless score #n bs.ctx < #s bs.ctx run return fail

data modify storage bs:ctx _ set from storage bs:out collection.value
data modify storage bs:out collection.value set value []

# Drop min
execute unless score #m bs.ctx matches 0 run function bs.collection:slice/call_drop

# Take until max reached
function bs.collection:slice/call_take
