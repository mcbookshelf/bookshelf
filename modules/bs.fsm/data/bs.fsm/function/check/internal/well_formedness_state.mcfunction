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
# Storage: bs:ctx check.states (a list of states)
# Storage: bs:ctx check.template (a FSM)

# Output:
# Fail if the current state is not valid

# If we don't have any state to check, we return
execute unless data storage bs:ctx check.states[0] run return 1

# We check if the current state has a name
execute unless data storage bs:ctx check.states[0].name run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "A state does not have a name."}] \
}
execute unless data storage bs:ctx check.states[0].name run return fail

# If the state has transitions, we check if they are valid
execute if data storage bs:ctx check.states[0].transitions store success score #s bs.ctx run function bs.fsm:check/internal/well_formedness_transition

# We propagate the error if the transitions are not valid
execute if score #s bs.ctx matches 0 run return fail

# We check the next state
data remove storage bs:ctx check.states[0]
return run function bs.fsm:check/internal/well_formedness_state
