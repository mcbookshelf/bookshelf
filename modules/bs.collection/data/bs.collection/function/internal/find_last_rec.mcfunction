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

# Prepare args for recursive call
data modify storage bs:lambda collection.value set from storage bs:data collection.stack[0].value[-1]
# We directly shift the collection to compute the index
data modify storage bs:data collection.stack[0].current set from storage bs:data collection.stack[0].value[-1]
data remove storage bs:data collection.stack[0].value[-1]
execute store result storage bs:lambda collection.index int 1 run data get storage bs:data collection.stack[0].value

# Call the lambda function with the args
execute store success score #s bs.ctx run function bs.collection:internal/call with storage bs:data collection.stack[0]

# If the recursive function succeeded, set the result and return
execute if score #s bs.ctx matches 1 run data modify storage bs:out collection set from storage bs:data collection.stack[0].current
execute if score #s bs.ctx matches 1 run return 0

# If the lambda function failed, try the next element
return run execute if score #s bs.ctx matches 0 if data storage bs:data collection.stack[0].value[0] run function bs.collection:internal/find_last_rec
