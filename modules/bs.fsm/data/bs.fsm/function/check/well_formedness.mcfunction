# Input:
# Storage: bs:ctx _.fsm (a FSM)

# We copy the states names to the entity tag since an entity tag array can only store one occurrence of a value
# This array will be useful to know if a transition refers to a state that does not exist
scoreboard players set #r bs.ctx 1
data modify storage bs:ctx _.saved_tags set from entity B5-0-0-0-1 Tags
data modify entity B5-0-0-0-1 Tags append from storage bs:ctx _.fsm.states[].name

data modify storage bs:ctx _.states set value []
data modify storage bs:ctx _.states append from storage bs:ctx _.fsm.states[]

# We check if the FSM is valid

# First, we check if the FSM has an initial state
execute unless data storage bs:ctx _.fsm.initial run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "The FSM does not have an initial state."}] \
}
execute unless data storage bs:ctx _.fsm.initial run scoreboard players set #r bs.ctx 0

# Then, we check if the FSM has at least one state
execute unless data storage bs:ctx _.states[0] run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "The FSM does not have any state."}] \
}
execute unless data storage bs:ctx _.states[0] run scoreboard players set #r bs.ctx 0

# Finally, we have to check each state
execute unless score #r bs.ctx matches 0 store success score #r bs.ctx run function bs.fsm:check/internal/well_formedness_state

# We restore the previous tags
data modify entity B5-0-0-0-1 Tags set from storage bs:ctx _.saved_tags

# We return the result of the check
execute if score #r bs.ctx matches 0 run return fail
return 1
