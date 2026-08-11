# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

$data modify storage bs:ctx _ set value {min: $(min), max: $(max), step: $(step)}
execute store result score #m bs.ctx run data get storage bs:ctx _.min 1
execute store result score #n bs.ctx run data get storage bs:ctx _.max 1
execute store result score #s bs.ctx run data get storage bs:ctx _.step 1

# Check for error condition min >= max
execute if score #s bs.ctx matches 1.. if score #m bs.ctx >= #n bs.ctx run return run function bs.collection:range/fail
execute if score #s bs.ctx matches ..-1 if score #m bs.ctx <= #n bs.ctx run return run function bs.collection:range/fail

data modify storage bs:out collection.value set value []
scoreboard players operation #m bs.ctx -= #s bs.ctx
function bs.collection:range/range_rec
