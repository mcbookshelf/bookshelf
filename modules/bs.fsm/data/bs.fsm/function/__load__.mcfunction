forceload add -30000000 1600

execute unless entity B5-0-0-0-1 run summon minecraft:marker -30000000 0 1600 {UUID:[I;181,0,0,1],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"]}
execute unless entity B5-0-0-0-2 run summon minecraft:text_display -30000000 0 1600 {UUID:[I;181,0,0,2],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"],view_range:0f,alignment:"center"}
execute unless data storage bs:data fsm run data modify storage bs:data fsm set value { fsm: {}, running_instances: {}, listened_transitions: [], ticks: [] }

# execute if data storage bs:data fsm.ticks[0] run schedule function bs.fsm:run/tick 1t
