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

# Check if current value is already in result (bs:out collection.value)
data modify storage bs:ctx _.temp_check set from storage bs:out collection.value
execute store success score #f bs.ctx run function bs.collection:distinct/contains_check

# If not found (found=0), append it to result
execute if score #f bs.ctx matches 0 run data modify storage bs:out collection.value append from storage bs:ctx _.value[0]

# Next iteration
data remove storage bs:ctx _.value[0]
execute if data storage bs:ctx _.value[0] run function bs.collection:distinct/distinct_rec
