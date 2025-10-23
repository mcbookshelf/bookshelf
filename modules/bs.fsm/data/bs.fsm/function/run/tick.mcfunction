execute store result score #c bs.ctx run data get storage bs:data fsm.ticks
function bs.fsm:run/tick_rec

# If we still have functions to run next tick, we schedule again
execute if data storage bs:data fsm.ticks[0] run schedule function bs.fsm:run/tick 1t
