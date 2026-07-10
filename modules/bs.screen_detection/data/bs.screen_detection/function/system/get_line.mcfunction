

data modify storage bs.screen_detection:data Pos set from entity @s Pos
execute store result score #v0 bs.screen_detection run data get storage bs.screen_detection:data Pos[0] 1000
execute store result score #v1 bs.screen_detection run data get storage bs.screen_detection:data Pos[1] 1000
execute store result score #v2 bs.screen_detection run data get storage bs.screen_detection:data Pos[2] 1000


execute positioned .0 .0 .0 run tp @s ^ ^ ^1
data modify storage bs.screen_detection:data Pos set from entity @s Pos
execute store result score #u0 bs.screen_detection run data get storage bs.screen_detection:data Pos[0] 1000
execute store result score #u1 bs.screen_detection run data get storage bs.screen_detection:data Pos[1] 1000
execute store result score #u2 bs.screen_detection run data get storage bs.screen_detection:data Pos[2] 1000

kill @s

