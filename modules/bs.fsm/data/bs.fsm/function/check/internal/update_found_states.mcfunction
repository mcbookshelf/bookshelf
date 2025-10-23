# Input:
# Storage: bs:ctx _.source_states (a list of states name)
# Storage: bs:ctx _.states_to_find (a list of states name)
# Storage: bs:ctx _.states_to_browse (a list of states name)

# If we have no more state to find, we directly return to stop the recursive loop
execute unless data storage bs:ctx _.source_states[0] run return 1

data modify storage bs:ctx _.state set from storage bs:ctx _.source_states[0].name
data remove storage bs:ctx _.source_states[0]

# First, we select the state to find, to avoid the use of multiple macro commands
execute store success score #s bs.ctx run function bs.fsm:check/internal/select_state with storage bs:ctx _

# If we fail to select the state, that is because the state does not exist (even if this is supposed to be impossible), we log an error and return
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: bs.fsm, \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: [{text: "The state '"}, {nbt: "_.state",storage: "bs:ctx"},{text: "' does not exist."}] \
}
execute if score #s bs.ctx matches 0 run return fail

# If we succeed to write the state as found, it means that the state was not found before
execute store success score #s bs.ctx run data modify storage bs:ctx _.states_to_find[{selected: true}].found set value true
data remove storage bs:ctx _.states_to_find[{selected: true}].selected

# If we succeed, we add the state to the list of states to browse
execute if score #s bs.ctx matches 1 run data modify storage bs:ctx _.states_to_browse append from storage bs:ctx _.state

# Else, that means we already browse the state, or we already plan to browse it. Since we do not want to browse the same state twice, we do nothing

# We need to run this function until we have no more state to find, we directly return the result of the function call to propagate errors
return run function bs.fsm:check/internal/update_found_states
