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
# Fail if the current transition is not valid

execute unless data storage bs:ctx check.states[0].transitions[0] run return 1

# First, we check that the transition has a target state
execute unless data storage bs:ctx check.states[0].transitions[0].to run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "A transition of '"}, {nbt: "check.states[0].name", storage: "bs:ctx"}, {text: "' does not have a target state."}] \
}
execute unless data storage bs:ctx check.states[0].transitions[0].to run return fail

# Then, we check that this state exists
data modify storage bs:ctx check.searched set from storage bs:ctx check.states[0].transitions[0].to
execute store success score #s bs.ctx run function bs.fsm:check/internal/state_exists with storage bs:ctx check

execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "A transition of '"}, {nbt: "check.states[0].name", storage: "bs:ctx"}, {text: "' refers an unknown state: "}, {nbt: "check.states[0].transitions[0].to", storage: "bs:ctx"}] \
}
execute if score #s bs.ctx matches 0 run return fail

# We check if the transition has a condition
execute unless data storage bs:ctx check.states[0].transitions[0].condition run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "A transition of '"}, {nbt: "check.states[0].name", storage: "bs:ctx"}, {text: "' does not have a condition."}] \
}
execute unless data storage bs:ctx check.states[0].transitions[0].condition run return fail

# We check if the condition is "manual"
data modify storage bs:ctx check.condition set value "manual"
execute store success score #s bs.ctx run data modify storage bs:ctx check.condition set from storage bs:ctx check.states[0].transitions[0].condition
# If we fail to overwrite "manual", it means that the condition is "manual"
# A manual transition is fired by its name through #bs.fsm:emit, so it must have one
execute if score #s bs.ctx matches 0 unless data storage bs:ctx check.states[0].transitions[0].name run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "A manual transition of '"}, {nbt: "check.states[0].name", storage: "bs:ctx"}, {text: "' does not have a name."}] \
}
execute if score #s bs.ctx matches 0 unless data storage bs:ctx check.states[0].transitions[0].name run return fail

# The remaining checks are about the condition object, we skip them and move on to the next transition
execute if score #s bs.ctx matches 0 run data remove storage bs:ctx check.states[0].transitions[0]
execute if score #s bs.ctx matches 0 run return run function bs.fsm:check/internal/well_formedness_transition

# If the condition is not "manual", we need to check if the condition is an object
execute unless data storage bs:ctx check.states[0].transitions[0].condition.type run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "A transition of '"}, {nbt: "check.states[0].name", storage: "bs:ctx"}, {text: "' has an invalid condition."}] \
}
execute unless data storage bs:ctx check.states[0].transitions[0].condition.type run return fail

# Now, we need to check the validity of the condition object, notably the wait
execute unless data storage bs:ctx check.states[0].transitions[0].condition.wait run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "A transition of '"}, {nbt: "check.states[0].name", storage: "bs:ctx"}, {text: "' does not have a wait in its condition."}] \
}
execute unless data storage bs:ctx check.states[0].transitions[0].condition.wait run return fail

# We check if the condition type is valid
scoreboard players set #s bs.ctx 0
execute if data storage bs:ctx check.states[0].transitions[0].condition{type: "predicate"} run scoreboard players set #s bs.ctx 1
execute if data storage bs:ctx check.states[0].transitions[0].condition{type: "command"} run scoreboard players set #s bs.ctx 1
execute if data storage bs:ctx check.states[0].transitions[0].condition{type: "delay"} run scoreboard players set #s bs.ctx 1

execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:validate", \
  tag: "validate", \
  message: [{text: "A transition of '"}, {nbt: "check.states[0].name", storage: "bs:ctx"}, {text: "' has an invalid condition."}] \
}
execute if score #s bs.ctx matches 0 run return fail

# If we pass all the checks, we can continue to the next transition
data remove storage bs:ctx check.states[0].transitions[0]
return run function bs.fsm:check/internal/well_formedness_transition
