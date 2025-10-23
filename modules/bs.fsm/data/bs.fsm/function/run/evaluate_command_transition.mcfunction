data modify storage bs:ctx _.tmp set value {}
data modify storage bs:ctx _.tmp.command set from storage bs:data fsm.listened_transitions[0].condition.wait

# If this is a global command transition, we run the command and according to the result, we switch to the target state
execute if data storage bs:data fsm.listened_transitions[0].global \
        store success score #s bs.ctx \
        run function bs.fsm:run/run_command_global with storage bs:ctx _.tmp
execute if score #s bs.ctx matches 1 run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]
execute if score #s bs.ctx matches 1 run return 1
execute if data storage bs:data fsm.listened_transitions[0].global run return fail

# If this is a local command transition, we run the command and according to the result, we switch to the target state
data modify storage bs:ctx _.tmp.context set from storage bs:data fsm.listened_transitions[0].context
execute store success score #s bs.ctx \
        run function bs.fsm:run/run_command_local with storage bs:ctx _.tmp
execute if score #s bs.ctx matches 1 run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]
execute if score #s bs.ctx matches 1 run return 1

return fail
