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

# Call the lambda function to transform the value into an collection
function bs.collection:flatmap/call with storage bs:data collection.stack[0]

# Flatten and append all elements from the resulting collection
data modify storage bs:data collection.stack[0].result append from storage bs:lambda collection.result[]

# Shift the collection
data modify storage bs:data collection.stack[0].consumed append from storage bs:data collection.stack[0].value[0]
data remove storage bs:data collection.stack[0].value[0]

# Recurse if there are more elements
execute if data storage bs:data collection.stack[0].value[0] run function bs.collection:flatmap/flatmap_rec
