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

# Prepare args for the lambda function
data modify storage bs:lambda collection.value set from storage bs:data collection.stack[0].value[0]
execute store result storage bs:lambda collection.index int 1 run data get storage bs:data collection.stack[0].consumed

# Call the lambda function and check if it passes the predicate
execute store success score #s bs.ctx run function bs.collection:all/call with storage bs:data collection.stack[0]

# If the predicate failed, set result to false and short-circuit
execute if score #s bs.ctx matches 0 run return fail

# Shift the collection
data modify storage bs:data collection.stack[0].consumed append from storage bs:data collection.stack[0].value[0]
data remove storage bs:data collection.stack[0].value[0]

# If the predicate succeeded, continue checking remaining elements
execute if score #s bs.ctx matches 1 if data storage bs:data collection.stack[0].value[0] run return run function bs.collection:all/all_rec

# If the predicate succeeded and there are no more elements, return true
execute if score #s bs.ctx matches 1 run return 1
