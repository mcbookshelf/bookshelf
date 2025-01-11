#setup
data modify storage bs:ctx _.s set from storage bs:in string.lower.str
execute store result score #c bs.ctx run data get storage bs:in string.lower.str
scoreboard players operation #n bs.ctx = #c bs.ctx
data modify storage bs:ctx _.ch set string storage bs:ctx _.s

#loop
function bs.string:lower_case/fast/loop with storage bs:ctx _

function bs.string:concat/combine_large with storage bs:ctx _

data modify storage bs:out string.lower set from storage bs:ctx _.s.1
