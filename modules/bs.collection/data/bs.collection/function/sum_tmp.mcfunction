execute store result score #a bs.ctx run data get storage bs:lambda collection.value
execute store result score #b bs.ctx run data get storage bs:lambda collection.accumulator
scoreboard players operation #a bs.ctx += #b bs.ctx
execute store result storage bs:lambda collection.result int 1 run scoreboard players get #a bs.ctx
