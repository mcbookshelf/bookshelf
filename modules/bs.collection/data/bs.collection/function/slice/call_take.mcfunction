data modify storage bs:out collection.value append from storage bs:ctx _[0]
data remove storage bs:ctx _[0]
scoreboard players add #i bs.ctx 1
execute if score #i bs.ctx < #n bs.ctx if data storage bs:ctx _[0] run function bs.collection:slice/call_take
