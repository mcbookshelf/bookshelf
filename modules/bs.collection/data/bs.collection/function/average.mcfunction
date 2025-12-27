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

# Save input collection
data modify storage bs:data collection.stack prepend value { value: [] }
data modify storage bs:data collection.stack[0].value set from storage bs:out collection

# Get sum at scale 1000
execute store result score #s bs.ctx run function #bs.collection:sum

# Restore collection for count
data modify storage bs:out collection set from storage bs:data collection.stack[0].value

# Get count
execute store result score #c bs.ctx run function #bs.collection:count

# Calculate average: sum / count at scale
scoreboard players operation #s bs.ctx /= #c bs.ctx

# Result on storage rescaled to original scale
execute store result storage bs:out collection double 0.001 run scoreboard players get #s bs.ctx

# Clean up
data remove storage bs:data collection.stack[0]

return run scoreboard players get #s bs.ctx
