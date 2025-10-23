# Input:
# Storage: bs:ctx _.states_to_browse (a list of states name)
# Storage: bs:ctx _.states_to_find (a list of states name)
# Storage: bs:ctx _.fsm (a FSM)

# If we have no more state to browse, we return
execute unless data storage bs:ctx _.states_to_browse[-1] run return 1

# We select the first state of the stack to get states having a transition to it
data modify storage bs:ctx _.current_state set from storage bs:ctx _.states_to_browse[-1]

# This function places the states having a transition to the current state in storage bs:ctx _.states_to_find
function bs.fsm:check/internal/get_input_states with storage bs:ctx _

# We remove the state from the stack
data remove storage bs:ctx _.states_to_browse[-1]

# We update the list of states to find, if we fail, we return since it means that one of the states does not exist (even if this is supposed to be impossible)
# This will also add the found states to the list of states to browse
execute unless function bs.fsm:check/internal/update_found_states run return fail

# We continue to browse the states, we return the result of the function call to propagate errors
return run function bs.fsm:check/internal/explore_state
