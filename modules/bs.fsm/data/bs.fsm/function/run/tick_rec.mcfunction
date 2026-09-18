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

# Input:
# - Storage bs:data fsm.ticks: {context: <uuid>, command: <command>} | { command: <command> }

# Terminal cases:
# The list is empty
execute unless data storage bs:data fsm.ticks[0] run return 1
# We already ran all the commands
execute if score #c bs.ctx matches ..0 run return 1

# We reduce the counter
scoreboard players remove #c bs.ctx 1

# If the command is global, we run it
execute if data storage bs:data fsm.ticks[0].global run function bs.fsm:run/run_command_global with storage bs:data fsm.ticks[0]

scoreboard players set #s bs.ctx -1
# Else, we first check if the entity exists, otherwise we remove the command from the tick list
execute unless data storage bs:data fsm.ticks[0].global store success score #s bs.ctx run function bs.fsm:run/check_entity with storage bs:data fsm.ticks[0]
execute if score #s bs.ctx matches 0 run data remove storage bs:data fsm.ticks[0]

# We run the command only if the entity exists
execute if score #s bs.ctx matches 1 run function bs.fsm:run/run_command_local with storage bs:data fsm.ticks[0]

# If the entity exists, or if we are on a global command, we shift the tick list
# We do not shift the tick list if the entity does not exist since we already removed the command
execute unless score #s bs.ctx matches 0 run data modify storage bs:data fsm.ticks append from storage bs:data fsm.ticks[0]
execute unless score #s bs.ctx matches 0 run data remove storage bs:data fsm.ticks[0]

# Recursion to continue the commands execution
function bs.fsm:run/tick_rec
