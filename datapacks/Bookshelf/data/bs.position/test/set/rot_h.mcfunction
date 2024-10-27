# Position is set correctly
# @batch bs.position

summon minecraft:marker ~ ~ ~ {Tags:["packtest"]}

execute store result score @n[type=minecraft:marker,tag=packtest] bs.rot.h run random value -10000..10000
execute as @n[type=minecraft:marker,tag=packtest] run function #bs.position:set_rot_h {scale:.001}
execute store result score #h bs.ctx run data get entity @n[type=minecraft:marker,tag=packtest] Rotation[0] 1000
scoreboard players operation #h bs.ctx -= @n[type=minecraft:marker,tag=packtest] bs.rot.h

kill @n[type=minecraft:marker,tag=packtest]

assert score #h bs.ctx matches -2..2
