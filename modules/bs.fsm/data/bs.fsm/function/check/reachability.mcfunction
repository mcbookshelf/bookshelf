# Input:
# Storage: bs:ctx _.fsm (a FSM)
# Storage: bs:ctx _.finals (a list of states)

# Storage: bs:ctx _.found_states (a list of states name)

# Goal: check if from any state of the FSM, we can reach a final state.
# In more technical terms, we want to check if the FSM is a weakly connected graph with a path existing from any state to a final state.

# How do we proceed? Depth-first search algorithm
# 1. We initialize an empty stack to store the states to explore
# 1. We stack into it the final states
# 2. We unstack the first state of the stack and identify the states having a transition to it (internal/explore_state)
# 3. We add them to the stack if we have not already visited them (internal/update_found_states)
# 4. We repeat the process until the stack is empty (internal/explore_state)
# → If we visit all the states, that means that from any state of the FSM, we can reach a final state
# → Else, some states cannot reach a final state

# We also profit from this function to check if all states used in transitions are defined in the FSM


# Initialization
data modify storage bs:ctx _.states_to_find set value []
data modify storage bs:ctx _.states_to_find append from storage bs:ctx _.fsm.states[]
data modify storage bs:ctx _.states_to_find[].found set value false
# We set the final states as found
data modify storage bs:ctx _.states_to_find[{final: true}].found set value true

# We initialize the stack of states to start exploring with the final states
data modify storage bs:ctx _.states_to_browse set value []
data modify storage bs:ctx _.states_to_browse append from storage bs:ctx _.finals[].name

# We start the depth-first search algorithm
execute store success score #s bs.ctx run function bs.fsm:check/internal/explore_state

# If we fail to explore the states, that means that some states used in transitions are not defined in the FSM
execute if score #s bs.ctx matches 0 run return fail

# Else, we check if all states are found
data modify storage bs:ctx _.not_found_states set value []
data modify storage bs:ctx _.not_found_states append from storage bs:ctx _.states_to_find[{found: false}]

# If we have some states that cannot reach a final state, we log an error and return
execute if data storage bs:ctx _.not_found_states[0] run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "The states '"}, {nbt: "_.not_found_states[].name", storage: "bs:ctx"},{text: "' cannot reach a final state."}] \
}
execute if data storage bs:ctx _.not_found_states[0] run return fail

# Else, we return success
return 1
