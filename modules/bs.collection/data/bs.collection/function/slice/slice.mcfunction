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

# Initialize min/max
$scoreboard players set #m bs.ctx $(min)
$scoreboard players set #n bs.ctx $(max)

# Get collection size
execute store result score #s bs.ctx run data get storage bs:out collection.value

# Handle negative indices
execute if score #m bs.ctx matches ..-1 run scoreboard players operation #m bs.ctx += #s bs.ctx
execute if score #n bs.ctx matches ..-1 run scoreboard players operation #n bs.ctx += #s bs.ctx

execute if score #m bs.ctx matches ..-1 run return run function bs.collection:slice/fail {msg: "Min must be in collection bounds"}
execute if score #n bs.ctx matches ..-1 run return run function bs.collection:slice/fail {msg: "Max must be in collection bounds"}
execute if score #m bs.ctx > #n bs.ctx run return run function bs.collection:slice/fail {msg: "Min must be lower than max"}
execute if score #m bs.ctx >= #s bs.ctx run return run function bs.collection:slice/fail {msg: "Min must be lower than collection size"}
execute if score #n bs.ctx >= #s bs.ctx run return run function bs.collection:slice/fail {msg: "Max must be lower than collection size"}

data modify storage bs:ctx _ set from storage bs:out collection.value
data modify storage bs:out collection.value set value []

# Drop min
scoreboard players operation #i bs.ctx = #m bs.ctx
execute if score #i bs.ctx matches 1.. run function bs.collection:slice/slice_drop

# Take until max reached
scoreboard players operation #i bs.ctx = #n bs.ctx
scoreboard players operation #i bs.ctx -= #m bs.ctx
execute if score #i bs.ctx matches 1.. run function bs.collection:slice/slice_take
