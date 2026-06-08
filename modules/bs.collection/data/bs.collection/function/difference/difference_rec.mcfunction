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

execute unless data storage bs:ctx _.value[0] run return 1

# Check if current value is in other
data modify storage bs:ctx _.temp_check set from storage bs:ctx _.other
execute store success score #a bs.ctx run function bs.collection:distinct/contains_check

# If NOT in other, check if already in result (to ensure distinctness)
execute if score #a bs.ctx matches 0 run data modify storage bs:ctx _.temp_check set from storage bs:out collection.value
execute if score #a bs.ctx matches 0 store success score #r bs.ctx run function bs.collection:distinct/contains_check
execute if score #r bs.ctx matches 1 run scoreboard players set #a bs.ctx 1

# Append if needed (if not in other AND not in result, #a is still 0)
execute if score #a bs.ctx matches 0 run data modify storage bs:out collection.value append from storage bs:ctx _.value[0]

# Next iteration
data remove storage bs:ctx _.value[0]
function bs.collection:difference/difference_rec
