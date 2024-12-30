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
summon minecraft:armor_stand 0.5 0.2 1.0 {Tags:["bs.packtest","bs.packtest.2"],NoGravity:1b}

execute as @e[type=minecraft:armor_stand,tag=bs.packtest.2] at @e[type=minecraft:armor_stand,tag=bs.packtest.1] run function #bs.link:create_link_ata

assert entity @e[type=minecraft:armor_stand,tag=bs.packtest.2,predicate=bs.link:has_link]
assert score @e[type=minecraft:armor_stand,tag=bs.packtest.1,limit=1] bs.id = @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] bs.link.to
assert score @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] bs.link.rx matches 499..501
assert score @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] bs.link.ry matches 199..201
assert score @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] bs.link.rz matches 999..1001
assert score @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] bs.link.lx matches 499..501
assert score @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] bs.link.ly matches 199..201
assert score @e[type=minecraft:armor_stand,tag=bs.packtest.2,limit=1] bs.link.lz matches 999..1001

kill @e[type=minecraft:armor_stand,tag=bs.packtest]
