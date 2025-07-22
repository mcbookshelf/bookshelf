# Input:
# Storage: bs:ctx _.fsm (a FSM)

# Output:
# Storage: bs:ctx _.finals (a list of states)
# Return 0 or 1 (0/fail if the FSM is not acceptable, 1 if it is)

# Goal: check if the FSM is acceptable, ie, if it has at least one final state
# Also check if the final states do not have any transition

data modify storage bs:ctx _.finals set value []
data modify storage bs:ctx _.finals append from storage bs:ctx _.fsm.states[{final: true}]
execute unless data storage bs:ctx _.finals[0] run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "The FSM has no final state."}] \
}
execute unless data storage bs:ctx _.finals[0] run return fail

execute if data storage bs:ctx _.finals[].transitions[0] run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "At least one final state has a transition."}] \
}
execute if data storage bs:ctx _.finals[].transitions[0] run return fail

return 1
