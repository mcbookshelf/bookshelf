# Prepare args for the lambda function
execute store result score #i bs.ctx run data get storage bs:data collection.stack[0].i
execute store result storage bs:lambda collection.index int 1 run scoreboard players get #i bs.ctx

# Call the lambda function
function bs.collection:generate/call with storage bs:data collection.stack[0]

# Add result to collection
data modify storage bs:data collection.stack[0].result append from storage bs:lambda collection.result

# Decrement limit
execute store result score #limit bs.ctx run data get storage bs:data collection.stack[0].limit
scoreboard players remove #limit bs.ctx 1
execute store result storage bs:data collection.stack[0].limit int 1 run scoreboard players get #limit bs.ctx

# Increment index
scoreboard players add #i bs.ctx 1
execute store result storage bs:data collection.stack[0].i int 1 run scoreboard players get #i bs.ctx

# Recurse if limit > 0
execute if score #limit bs.ctx matches 1.. run function bs.collection:generate/generate_rec
