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

data modify storage bs:ctx _.tmp set value {}
data modify storage bs:ctx _.tmp.command set from storage bs:data fsm.listened_transitions[0].condition.wait

# If this is a global command transition, we run the command and according to the result, we switch to the target state
execute if data storage bs:data fsm.listened_transitions[0].global \
        store success score #s bs.ctx \
        run function bs.fsm:run/run_command_global with storage bs:ctx _.tmp

execute if score #s bs.ctx matches 1 run return run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]
execute if data storage bs:data fsm.listened_transitions[0].global run return fail

# If this is a local command transition, we run the command and according to the result, we switch to the target state
data modify storage bs:ctx _.tmp.context set from storage bs:data fsm.listened_transitions[0].context
execute store success score #s bs.ctx \
        run function bs.fsm:run/run_command_local with storage bs:ctx _.tmp

execute if score #s bs.ctx matches 1 run return run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]

return fail
