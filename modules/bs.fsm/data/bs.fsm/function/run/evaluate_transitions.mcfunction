# Input:
# - Storage bs:data fsm.listened_transitions: {source: <state_name>, context: <context>, command: <command>, instance_name: <instance_name>, to: <state_name>, condition: { type: "delay" | "predicate" | "function", wait: string }}[]

# Unlike the tick function, we will not use a counter to know when to stop the recursion
# Indeed, in the tick function we don't unregister the tick commands, so we cannot loose the count
# In this function, we will remove the transitions that have been evaluated, as well as all the transitions for this instance
# As we don't know how many transitions will be removed, we prefer to use a flag on transitions to directly know from the current transition if we need to continue the recursion

function bs.fsm:run/evaluate_transitions_rec
# We reset the checked flag for the next evaluation
data remove storage bs:data fsm.listened_transitions[].checked

# If we still have transitions to evaluate, we schedule again
execute if data storage bs:data fsm.listened_transitions[0] run schedule function bs.fsm:run/evaluate_transitions 1t
