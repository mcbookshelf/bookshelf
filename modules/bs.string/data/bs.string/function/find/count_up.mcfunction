data modify storage bs:out string.find append from storage bs:ctx x
scoreboard players add #c bs.ctx 1
execute if score #c bs.ctx = #bs.string.occurrence bs.data run return 0

execute if score #l bs.ctx = #i bs.ctx run return run data get storage bs:out string.find

execute store result storage bs:ctx x int 1 run scoreboard players add #i bs.ctx 1
data modify storage bs:ctx _.str set string storage bs:ctx _.str 1

function bs.string:find/count_search with storage bs:ctx
