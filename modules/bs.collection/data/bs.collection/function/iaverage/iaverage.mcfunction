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

# Get sum & count
execute store result score #c bs.ctx if data storage bs:out collection.value[]
execute store result score #s bs.ctx run function #bs.collection:isum

# Compute a ratio for the average computation
scoreboard players set #r bs.ctx 1000000000
scoreboard players operation #r bs.ctx /= #c bs.ctx
data modify storage bs:ctx _ set value {}
execute store result storage bs:ctx _.ratio double .000000001 run scoreboard players get #r bs.ctx

# Compute the average
data remove storage bs:out collection.value
function bs.collection:iaverage/compute_iaverage with storage bs:ctx _

$return run data get storage bs:out collection.value $(scale)
