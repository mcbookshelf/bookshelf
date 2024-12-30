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

summon minecraft:armor_stand 0.0 0.0 0.0 {Tags:["bs.packtest","bs.packtest.1"],NoGravity:1b}
summon minecraft:armor_stand 0.0 0.0 1.0 {Tags:["bs.packtest","bs.packtest.2"],NoGravity:1b}

execute as @e[type=minecraft:armor_stand,tag=bs.packtest.2] at @e[type=minecraft:armor_stand,tag=bs.packtest.1] run function #bs.link:create_link_ata
tp @e[type=minecraft:armor_stand,tag=bs.packtest.1] 0.0 0.0 0.0 52 -12
execute as @e[type=minecraft:armor_stand,tag=bs.packtest.2] run function #bs.link:keep_local_pos

execute as @e[type=minecraft:armor_stand,tag=bs.packtest.1] at @s positioned ^ ^ ^1 run assert entity @e[type=minecraft:armor_stand,tag=bs.packtest.2,distance=..0.002]

kill @e[type=minecraft:armor_stand,tag=bs.packtest]
