$data modify storage bs:ctx _.l append string storage bs:in string.replace.str $(z) $(x)
execute store result storage bs:ctx x int 1 store result storage bs:ctx z int 1 run scoreboard players operation #i bs.ctx += #p bs.ctx

data modify storage bs:ctx _.l append from storage bs:in string.replace.new

$data modify storage bs:ctx _.str set string storage bs:ctx _.str $(y)
function bs.string:replace/loop with storage bs:ctx
