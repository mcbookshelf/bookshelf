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

# Initialize new chunk
data modify storage bs:data collection.stack[0].current set value []
execute store result score #n bs.ctx run data get storage bs:data collection.stack[0].size

# Fill the chunk
function bs.collection:chunk/fill_rec

# Add the chunk to the result
data modify storage bs:data collection.stack[0].result append from storage bs:data collection.stack[0].current

# Continue if there are more elements
execute if data storage bs:data collection.stack[0].value[0] run function bs.collection:chunk/chunk_rec
