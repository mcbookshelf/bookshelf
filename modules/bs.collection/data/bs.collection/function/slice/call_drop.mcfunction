data remove storage bs:ctx _[0]
scoreboard players add #i bs.ctx 1
execute if score #i bs.ctx < #m bs.ctx if data storage bs:ctx _[0] run function bs.collection:slice/call_drop
