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

# Prepare args for lambda call
data modify storage bs:lambda collection.value set from storage bs:data collection.stack[0].value[-1]
execute store result score #i bs.ctx run data get storage bs:data collection.stack[0].i
execute store result storage bs:data collection.stack[0].i int 1 store result storage bs:lambda collection.index int 1 run scoreboard players remove #i bs.ctx 1

# Call the lambda function with the args
execute store success score #s bs.ctx run function bs.collection:find_last/call with storage bs:data collection.stack[0]

# If the lambda function succeeded, set the result and return
execute if score #s bs.ctx matches 1 run return run function bs.collection:find_last/set_result

# Shift the collection
data remove storage bs:data collection.stack[0].value[-1]

# If the lambda function failed, try the next element
execute if data storage bs:data collection.stack[0].value[0] run function bs.collection:find_last/find_last_rec
