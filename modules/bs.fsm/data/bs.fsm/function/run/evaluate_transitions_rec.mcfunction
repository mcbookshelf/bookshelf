# Input:
# - Storage bs:data fsm.listened_transitions: {source: <state_name>, context: <context>, command: <command>, instance_name: <instance_name>, to: <state_name>, condition: { type: "delay" | "predicate" | "function", wait: string }}[]

# Terminal cases:
# The list is empty
execute unless data storage bs:data fsm.listened_transitions[0] run return 1
# We already checked the current transition
execute if data storage bs:data fsm.listened_transitions[0].checked run return 1


scoreboard players set #s bs.ctx -1
# If this is a local transition, we check if the entity exists, otherwise we remove the transition from the list and we continue the recursion
execute unless data storage bs:data fsm.listened_transitions[0].global \
        store success score #s bs.ctx \
        run function bs.fsm:run/check_entity with storage bs:data fsm.listened_transitions[0]
execute if score #s bs.ctx matches 0 run data remove storage bs:data fsm.listened_transitions[0]
execute if score #s bs.ctx matches 0 run return run function bs.fsm:run/evaluate_transitions_rec

scoreboard players set #s bs.ctx 0

# Delayed transition
execute store success score #s bs.ctx if data storage bs:data fsm.listened_transitions[0].condition{type: "delay"} run function bs.fsm:run/evaluate_delay_transition

# Command transition
execute if score #s bs.ctx matches 0 if data storage bs:data fsm.listened_transitions[0].condition{type: "command"} store success score #s bs.ctx run function bs.fsm:run/evaluate_command_transition

# Predicate transitions
execute if score #s bs.ctx matches 0 if data storage bs:data fsm.listened_transitions[0].condition{type: "predicate"} store success score #s bs.ctx run function bs.fsm:run/evaluate_predicate_transition

# If we didn't evaluated the current transition, we set the transition as checked and we shift the list
execute if score #s bs.ctx matches 0 run data modify storage bs:data fsm.listened_transitions[0].checked set value true
execute if score #s bs.ctx matches 0 run data modify storage bs:data fsm.listened_transitions append from storage bs:data fsm.listened_transitions[0]
execute if score #s bs.ctx matches 0 run data remove storage bs:data fsm.listened_transitions[0]

# If the current transition has been evaluated, we don't need to shift the list since the transition has been removed by the switch_state function

# We continue the recursion
return run function bs.fsm:run/evaluate_transitions_rec
