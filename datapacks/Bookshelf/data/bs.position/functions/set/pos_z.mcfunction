# INFO ------------------------------------------------------------------------
# Copyright © 2023 Gunivers Community.

# Authors: Aksiome, Leirof
# Contributors:

# Version: 3.0
# Created: ??/??/???? (1.13)
# Last modification: 31/08/2023 (23w33a)

# Documentation: https://bookshelf.docs.gunivers.net/en/latest/modules/position.html#set-position
# Dependencies:
# Note:

# CODE ------------------------------------------------------------------------

execute at @s run tp B5-0-0-0-1 ~ ~ ~
$execute store result entity B5-0-0-0-1 Pos[2] double $(scale) run scoreboard players get @s bs.pos.z
execute at B5-0-0-0-1 run tp @s ~ ~ ~
execute in minecraft:overworld run tp B5-0-0-0-1 -30000000 0 1600
