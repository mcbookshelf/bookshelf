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
# Storage: bs:ctx _.template (a FSM)

# Output:
# Storage: bs:ctx _.finals (a list of states)
# Return 0 or 1 (0/fail if the FSM is not acceptable, 1 if it is)

# Goal: check if the FSM is acceptable, ie, if it has at least one final state
# Also check if the final states do not have any transition

data modify storage bs:ctx _.finals set value []
data modify storage bs:ctx _.finals append from storage bs:ctx _.template.states[{final: true}]
execute unless data storage bs:ctx _.finals[0] run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "The FSM has no final state."}] \
}
execute unless data storage bs:ctx _.finals[0] run return fail

execute if data storage bs:ctx _.finals[].transitions[0] run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "At least one final state has a transition."}] \
}
execute if data storage bs:ctx _.finals[].transitions[0] run return fail

return 1
