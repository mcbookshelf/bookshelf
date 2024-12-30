# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

summon minecraft:armor_stand 0.0 0.0 1.0 {Tags:["bs.packtest","bs.packtest.1"],NoGravity:1b}
summon minecraft:armor_stand 0.0 0.0 0.0 {Tags:["bs.packtest","bs.packtest.2"],NoGravity:1b}

execute as @e[type=minecraft:armor_stand,tag=bs.packtest.2] at @e[type=minecraft:armor_stand,tag=bs.packtest.1] run function #bs.link:create_link_ata

execute as @e[type=minecraft:armor_stand,tag=bs.packtest.1] at @s run tp @s ~1 ~1 ~1 ~42 ~42
execute as @e[type=minecraft:armor_stand,tag=bs.packtest.2] run function #bs.link:reverse_pos_and_rot

execute store result score #x bs.ctx run data get entity @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] Pos[0] 1000
execute store result score #y bs.ctx run data get entity @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] Pos[1] 1000
execute store result score #z bs.ctx run data get entity @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] Pos[2] 1000
execute store result score #h bs.ctx run data get entity @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] Rotation[0] 1000
execute store result score #v bs.ctx run data get entity @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] Rotation[1] 1000

kill @e[type=minecraft:armor_stand,tag=bs.packtest]

assert score #x bs.ctx matches -1001..-999
assert score #y bs.ctx matches -1001..-999
assert score #z bs.ctx matches -1001..-999
assert score #h bs.ctx matches -42001..-41999
assert score #v bs.ctx matches -42001..-41999
