# We check if the delay has passed, if so, we switch to the target state. Otherwise, we decrease the delay
execute store result score #d bs.ctx run data get storage bs:data fsm.listened_transitions[0].condition.wait
execute if score #d bs.ctx matches ..0 run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]
execute if score #d bs.ctx matches ..0 run return 1
execute if score #d bs.ctx matches 1.. run scoreboard players remove #d bs.ctx 1
execute store result storage bs:data fsm.listened_transitions[0].condition.wait int 1 run scoreboard players get #d bs.ctx

return fail
