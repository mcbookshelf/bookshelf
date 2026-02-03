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

# Initialize new window
data modify storage bs:data collection.stack[0].current set value []
execute store result score #n bs.ctx run data get storage bs:data collection.stack[0].size

# Prepare temp copy for filling
data modify storage bs:data collection.stack[0].temp set from storage bs:data collection.stack[0].value

# Fill the window from temp
execute if score #n bs.ctx matches 1.. run function bs.collection:sliding/fill_rec

# Add to result if step > #n (not subset of previous) OR if this is the FIRST window (no previous to be subset of)
# We can check if `i` is 0.
execute store result score #step bs.ctx run data get storage bs:data collection.stack[0].step
execute store result score #i bs.ctx run data get storage bs:data collection.stack[0].i
execute if score #i bs.ctx matches 0 run data modify storage bs:data collection.stack[0].result append from storage bs:data collection.stack[0].current
execute unless score #i bs.ctx matches 0 if score #step bs.ctx > #n bs.ctx run data modify storage bs:data collection.stack[0].result append from storage bs:data collection.stack[0].current

# Increment index i
execute store result score #i bs.ctx run data get storage bs:data collection.stack[0].i
execute store result storage bs:data collection.stack[0].i int 1 run scoreboard players add #i bs.ctx 1

# Shift the collection by `step` elements
execute store result score #step bs.ctx run data get storage bs:data collection.stack[0].step
function bs.collection:sliding/shift_rec

# Recurse if there are still elements
execute if data storage bs:data collection.stack[0].value[0] run function bs.collection:sliding/sliding_rec
