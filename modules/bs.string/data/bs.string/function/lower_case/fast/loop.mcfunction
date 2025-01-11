data remove storage stringlib:temp _.lt
$data modify storage bs:ctx _.lt set from storage bs:data string.CharMap.Fast[{u:"$(ch)"}].l
data modify storage bs:ctx _.l append from storage bs:ctx _.lt
execute if data storage bs:ctx _.lt run data modify storage bs:ctx _.l append from storage bs:ctx _.ch

#loop
execute if score #c bs.ctx matches 0 run return 0
scoreboard players remove #c bs.ctx 1
data modify storage bs:ctx _.s set string storage bs:ctx _.s 1
data modify storage bs:ctx _.ch set string storage bs:ctx _.s 0 1
function bs.string:lower_case/fast/loop with storage bs:ctx _
