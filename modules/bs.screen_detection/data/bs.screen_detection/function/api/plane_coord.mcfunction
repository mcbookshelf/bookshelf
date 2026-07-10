
scoreboard players reset #dx bs.screen_detection
scoreboard players reset #dy bs.screen_detection
scoreboard players reset #dz bs.screen_detection

scoreboard players operation #dot0 bs.screen_detection = #n0 bs.screen_detection
scoreboard players operation #dot0 bs.screen_detection *= #u0 bs.screen_detection

scoreboard players operation #dot1 bs.screen_detection = #n1 bs.screen_detection
scoreboard players operation #dot1 bs.screen_detection *= #u1 bs.screen_detection
scoreboard players operation #dot0 bs.screen_detection += #dot1 bs.screen_detection

scoreboard players operation #dot1 bs.screen_detection = #n2 bs.screen_detection
scoreboard players operation #dot1 bs.screen_detection *= #u2 bs.screen_detection
scoreboard players operation #dot0 bs.screen_detection += #dot1 bs.screen_detection
scoreboard players operation #dot0 bs.screen_detection /= #1000 bs.screen_detection


execute unless score #dot0 bs.screen_detection matches 0 run function bs.screen_detection:system/intersection_final




