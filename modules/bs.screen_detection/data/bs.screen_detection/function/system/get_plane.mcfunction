

data modify storage bs.screen_detection:data Pos set from entity @s Pos
execute store result score #o0 bs.screen_detection run data get storage bs.screen_detection:data Pos[0] 1000
execute store result score #o1 bs.screen_detection run data get storage bs.screen_detection:data Pos[1] 1000
execute store result score #o2 bs.screen_detection run data get storage bs.screen_detection:data Pos[2] 1000


execute positioned .0 .0 .0 run tp @s ^ ^ ^1
data modify storage bs.screen_detection:data Pos set from entity @s Pos
execute store result score #n0 bs.screen_detection run data get storage bs.screen_detection:data Pos[0] 1000
execute store result score #n1 bs.screen_detection run data get storage bs.screen_detection:data Pos[1] 1000
execute store result score #n2 bs.screen_detection run data get storage bs.screen_detection:data Pos[2] 1000

execute positioned .0 .0 .0 run tp @s ^1 ^ ^
data modify storage bs.screen_detection:data Pos set from entity @s Pos
execute store result score #i0 bs.screen_detection run data get storage bs.screen_detection:data Pos[0] 1000
execute store result score #i1 bs.screen_detection run data get storage bs.screen_detection:data Pos[1] 1000
execute store result score #i2 bs.screen_detection run data get storage bs.screen_detection:data Pos[2] 1000


#cross product to get the 2snc director vector of the plane
scoreboard players operation #intern0 bs.screen_detection = #n2 bs.screen_detection
scoreboard players operation #intern0 bs.screen_detection *= #i1 bs.screen_detection
scoreboard players operation #j0 bs.screen_detection = #n1 bs.screen_detection
scoreboard players operation #j0 bs.screen_detection *= #i2 bs.screen_detection
scoreboard players operation #j0 bs.screen_detection -= #intern0 bs.screen_detection
scoreboard players operation #j0 bs.screen_detection /= #1000 bs.screen_detection

scoreboard players operation #intern0 bs.screen_detection = #n0 bs.screen_detection
scoreboard players operation #intern0 bs.screen_detection *= #i2 bs.screen_detection
scoreboard players operation #j1 bs.screen_detection = #n2 bs.screen_detection
scoreboard players operation #j1 bs.screen_detection *= #i0 bs.screen_detection
scoreboard players operation #j1 bs.screen_detection -= #intern0 bs.screen_detection
scoreboard players operation #j1 bs.screen_detection /= #1000 bs.screen_detection

scoreboard players operation #intern0 bs.screen_detection = #n1 bs.screen_detection
scoreboard players operation #intern0 bs.screen_detection *= #i0 bs.screen_detection
scoreboard players operation #j2 bs.screen_detection = #n0 bs.screen_detection
scoreboard players operation #j2 bs.screen_detection *= #i1 bs.screen_detection
scoreboard players operation #j2 bs.screen_detection -= #intern0 bs.screen_detection
scoreboard players operation #j2 bs.screen_detection /= #1000 bs.screen_detection



kill @s

