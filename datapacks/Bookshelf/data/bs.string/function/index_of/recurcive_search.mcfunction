data modify storage bs:ctx _.char set from storage bs:data string.caracter
execute if score #c bs.ctx >= #string.lenth bs.data run return run scoreboard players set #c bs.ctx -1
execute unless function bs.string:index_of/test_caracter run scoreboard players add #o bs.ctx 1
execute if score #o bs.ctx = #string.occurence bs.data run return run scoreboard players get #c bs.ctx
scoreboard players add #c bs.ctx 1
data modify storage bs:ctx _.str set string storage bs:ctx _.str 1
function bs.string:index_of/recurcive_search