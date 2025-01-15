$data modify storage bs:out string.split append string storage bs:in string.split.str $(z) $(x)
execute store result storage bs:ctx x int 1 store result storage bs:ctx z int 1 run scoreboard players operation #i bs.ctx += #p bs.ctx
scoreboard players add #c bs.ctx 1

$data modify storage bs:ctx _.str set string storage bs:ctx _.str $(y)

execute if score #c bs.ctx >= #bs.string.maxsplit bs.data run return run data modify storage bs:out string.split append from storage bs:ctx _.str

function bs.string:split/count/loop with storage bs:ctx
