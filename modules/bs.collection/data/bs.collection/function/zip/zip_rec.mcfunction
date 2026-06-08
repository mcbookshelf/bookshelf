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

# Create the pair [value1, value2]
data modify storage bs:data collection.stack[0].pair set value []
data modify storage bs:data collection.stack[0].pair append from storage bs:data collection.stack[0].value[0]
data modify storage bs:data collection.stack[0].pair append from storage bs:data collection.stack[0].other[0]

# Add pair to result
data modify storage bs:data collection.stack[0].result append from storage bs:data collection.stack[0].pair

# Shift both collections
data remove storage bs:data collection.stack[0].value[0]
data remove storage bs:data collection.stack[0].other[0]

# Recurse if both collections have elements
execute if data storage bs:data collection.stack[0].value[0] if data storage bs:data collection.stack[0].other[0] run function bs.collection:zip/zip_rec
