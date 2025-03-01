data remove storage bs:ctx _.l
data modify storage bs:out string.list set value []
scoreboard players set #i bs.ctx 0
execute store result score #l bs.ctx run data get storage bs:in string.to_list.str

function bs.string:type/to_list/loop
