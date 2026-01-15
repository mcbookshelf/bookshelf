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

# Get current element value
execute store result score #c bs.ctx run data get storage bs:out collection.value[0] 1

# Update minimum if current is larger - copy both score and original value
execute if score #c bs.ctx > #m bs.ctx run data modify storage bs:ctx _ set from storage bs:out collection.value[0]
execute if score #c bs.ctx > #m bs.ctx run scoreboard players operation #m bs.ctx = #c bs.ctx

# Shift the collection
data remove storage bs:out collection.value[0]

# Recurse if there are more elements
execute if data storage bs:out collection.value[0] run function bs.collection:imax/imax_rec
