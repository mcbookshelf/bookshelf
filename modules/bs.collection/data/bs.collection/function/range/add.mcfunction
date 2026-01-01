execute store result storage bs:ctx _ int 1 run scoreboard players get #m bs.ctx
data modify storage bs:out collection.value append from storage bs:ctx _
scoreboard players operation #m bs.ctx += #s bs.ctx
function bs.collection:range/range_rec
