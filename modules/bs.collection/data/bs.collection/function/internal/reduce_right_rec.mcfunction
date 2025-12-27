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

# reduce<T>(collection: T[], fn: (accumulator: T, value: T) => T): T

# Prepare args for the lambda function
data modify storage bs:lambda collection.accumulator set from storage bs:data collection.stack[0].accumulator
data modify storage bs:lambda collection.value set from storage bs:data collection.stack[0].value[-1]
# We directly shift the collection to compute the index
data remove storage bs:data collection.stack[0].value[-1]
# Index is the length of the collection minus the number of elements consumed
execute store result storage bs:lambda collection.index int 1 run data get storage bs:data collection.stack[0].value

# Call the lambda function to reduce the value
function bs.collection:internal/call with storage bs:data collection.stack[0]
data modify storage bs:data collection.stack[0].accumulator set from storage bs:lambda collection.result

# Recurse if there are more elements
execute if data storage bs:data collection.stack[0].value[0] run function bs.collection:internal/reduce_right_rec
