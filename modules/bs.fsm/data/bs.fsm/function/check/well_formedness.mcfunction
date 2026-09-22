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

# The checks work in bs:ctx check, which the runtime never touches (it holds fsm while it runs the commands of a machine)
data modify storage bs:ctx check set from storage bs:ctx _
data modify storage bs:ctx check.states set value []
data modify storage bs:ctx check.states append from storage bs:ctx check.template.states[]

scoreboard players set #r bs.ctx 1

# We check if the FSM is valid

# First, we check if the FSM has an initial state
execute unless data storage bs:ctx check.template.initial run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "The FSM does not have an initial state."}] \
}
execute unless data storage bs:ctx check.template.initial run scoreboard players set #r bs.ctx 0

# Then, we check if the FSM has at least one state
execute unless data storage bs:ctx check.states[0] run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "The FSM does not have any state."}] \
}
execute unless data storage bs:ctx check.states[0] run scoreboard players set #r bs.ctx 0

# Finally, we have to check each state
execute unless score #r bs.ctx matches 0 store success score #r bs.ctx run function bs.fsm:check/internal/well_formedness_state

# We restore our context
data modify storage bs:ctx _ set from storage bs:ctx check
data remove storage bs:ctx check

# We return the result of the check
execute if score #r bs.ctx matches 0 run return fail
return 1
