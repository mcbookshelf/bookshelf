execute if score #c bs.ctx matches 1.. run data modify storage bs:out collection.value append from storage bs:ctx _
execute if score #c bs.ctx matches 1.. run scoreboard players remove #c bs.ctx 1

execute if score #c bs.ctx matches 1.. run function bs.collection:repeat/repeat_rec
