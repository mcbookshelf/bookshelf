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

# Prepare args for the run function
execute store result score #i bs.ctx run data get storage bs:data collection.stack[0].i
execute store result storage bs:lambda collection.index int 1 run scoreboard players get #i bs.ctx

# Call the generator
function bs.collection:generate_while/call_run with storage bs:data collection.stack[0]

# Check predicate
execute store success score #s bs.ctx run function bs.collection:generate_while/call_predicate with storage bs:data collection.stack[0]

# If success, append and recurse
execute if score #s bs.ctx matches 1 run data modify storage bs:data collection.stack[0].result append from storage bs:lambda collection.result
execute if score #s bs.ctx matches 1 run scoreboard players add #i bs.ctx 1
execute if score #s bs.ctx matches 1 run execute store result storage bs:data collection.stack[0].i int 1 run scoreboard players get #i bs.ctx
execute if score #s bs.ctx matches 1 run function bs.collection:generate_while/generate_while_rec
