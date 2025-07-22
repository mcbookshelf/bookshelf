# Input:
# Storage: bs:ctx _.states (a list of states)
# Entity: B5-0-0-0-1 Tags (the list of all states names)

# Output:
# Fail if the current state is not valid

# If we don't have any state to check, we return
execute unless data storage bs:ctx _.states[0] run return 1

# We check if the current state has a name
execute unless data storage bs:ctx _.states[0].name run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "A state does not have a name."}] \
}
execute unless data storage bs:ctx _.states[0].name run return fail

# If the state has transitions, we check if they are valid
execute if data storage bs:ctx _.states[0].transitions store success score #s bs.ctx run function bs.fsm:check/internal/well_formedness_transition

# We propagate the error if the transitions are not valid
execute if score #s bs.ctx matches 0 run return fail

# We check the next state
data remove storage bs:ctx _.states[0]
return run function bs.fsm:check/internal/well_formedness_state
