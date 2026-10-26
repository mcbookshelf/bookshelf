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

# Prepare args for the run function
data modify storage bs:lambda collection.index set from storage bs:data collection.stack[-1].i

# Call the generator
function bs.collection:generate_while/call_run with storage bs:data collection.stack[-1]
data modify storage bs:data collection.stack[-1].result append from storage bs:lambda collection.result

# Check predicate
data modify storage bs:lambda collection.value set from storage bs:lambda collection.result
execute store success score #s bs.ctx run function bs.collection:generate_while/call_predicate with storage bs:data collection.stack[-1]

# If failure, remove the last result and return
execute if score #s bs.ctx matches 0 run return run data remove storage bs:data collection.stack[-1].result[-1]

execute store result score #i bs.ctx run data get storage bs:data collection.stack[-1].i
execute store result storage bs:data collection.stack[-1].i int 1 run scoreboard players add #i bs.ctx 1
function bs.collection:generate_while/generate_while_rec
