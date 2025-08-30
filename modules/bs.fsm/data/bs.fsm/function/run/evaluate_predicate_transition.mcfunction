data modify storage bs:ctx _.transition set from storage bs:data fsm.listened_transitions[0]
data modify storage bs:ctx _.transition.predicate set from storage bs:ctx _.transition.condition.wait

# If this is a global predicate transition, we evaluate the predicate and according to the result, we switch to the target state
execute if data storage bs:data fsm.listened_transitions[0].global \
        store success score #s bs.ctx \
        run function bs.fsm:run/evaluate_global_predicate with storage bs:ctx _.transition
execute if score #s bs.ctx matches 1 run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]
execute if score #s bs.ctx matches 1 run return 1
execute if data storage bs:data fsm.listened_transitions[0].global run return fail

# If this is a local predicate transition, we evaluate the predicate and according to the result, we switch to the target state
execute store success score #s bs.ctx \
        run function bs.fsm:run/evaluate_local_predicate with storage bs:ctx _.transition
execute if score #s bs.ctx matches 1 run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]
execute if score #s bs.ctx matches 1 run return 1

return fail
