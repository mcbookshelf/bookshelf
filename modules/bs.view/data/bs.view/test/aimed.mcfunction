# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
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

# @template ward:empty/9x9x9
# @dummy ~4.5 ~ ~4.5

# the dummy looks south at eye height, at a sponge 1.5 blocks away
tp @s ~4.5 ~ ~4.5 0 0
setblock ~4 ~1 ~6 minecraft:sponge
assert run function #bs.view:at_aimed_block.in {run:"execute if entity @s[type=minecraft:player] run setblock ~ ~ ~ minecraft:bookshelf",with:{}}
assert block ~4 ~1 ~6 minecraft:bookshelf
assert not run function #bs.view:at_aimed_block.in {run:"setblock ~ ~ ~ minecraft:sponge",with:{max_distance:1}}
assert block ~4 ~1 ~6 minecraft:bookshelf

# the point where it aims, on the face of the block
assert run function #bs.view:at_aimed_point.in {run:"summon minecraft:marker ~ ~ ~ {Tags:['bs.view.test']}",with:{}}
execute positioned ~4.5 ~1.62 ~6 run assert entity @e[type=minecraft:marker,tag=bs.view.test,distance=..0.01]
kill @e[type=minecraft:marker,tag=bs.view.test]
setblock ~4 ~1 ~6 minecraft:air

# alone, the dummy aims at nothing: its own box never stops the ray, and it is not left tagged
assert not run function #bs.view:at_aimed_entity.in {run:"say no",with:{max_distance:4}}
assert not entity @s[tag=bs.raycast.omit]

# an armor stand 2 blocks away: as and at it, then as the dummy at it
summon minecraft:armor_stand ~4.5 ~ ~6.5 {NoGravity:1b,Tags:["bs.view.test"]}
assert run function #bs.view:as_aimed_entity.in {run:"execute if entity @s[type=minecraft:armor_stand,distance=..0.01] run tag @s add bs.view.test.as",with:{selector:"tag=bs.view.test"}}
assert entity @e[type=minecraft:armor_stand,tag=bs.view.test.as]
assert run function #bs.view:at_aimed_entity.in {run:"execute if entity @s[type=minecraft:player] if entity @e[type=minecraft:armor_stand,distance=..0.01] run tag @s add bs.view.test.at",with:{selector:"tag=bs.view.test"}}
assert entity @s[tag=bs.view.test.at]
tag @s remove bs.view.test.at

# a block in front of it hides it
setblock ~4 ~1 ~5 minecraft:sponge
assert not run function #bs.view:at_aimed_entity.in {run:"say no",with:{max_distance:4}}
kill @e[type=minecraft:armor_stand,tag=bs.view.test]
