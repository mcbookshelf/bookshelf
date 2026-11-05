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

# the dummy looks at the first armor stand, not the second: as it, the command keeps the position of the function
tp @s ~4.5 ~ ~4.5 0 0
summon minecraft:armor_stand ~4.5 ~ ~6.5 {NoGravity:1b,Tags:["bs.view.is_lookable","bs.view.test.front"]}
summon minecraft:armor_stand ~6.5 ~ ~6.5 {NoGravity:1b,Tags:["bs.view.is_lookable","bs.view.test.side"]}
summon minecraft:marker ~1 ~ ~1 {Tags:["bs.view.test.here"]}
assert run execute positioned ~1 ~ ~1 run function #bs.view:as_looked_entity.in {run:"execute if entity @s[type=minecraft:armor_stand] if entity @e[type=minecraft:marker,tag=bs.view.test.here,distance=..0.01] run tag @s add bs.view.test.as"}
kill @e[type=minecraft:marker,tag=bs.view.test.here]
assert entity @e[type=minecraft:armor_stand,tag=bs.view.test.front,tag=bs.view.test.as]
assert not entity @e[type=minecraft:armor_stand,tag=bs.view.test.side,tag=bs.view.test.as]
assert run function #bs.view:at_looked_entity.in {run:"execute if entity @e[type=minecraft:armor_stand,tag=bs.view.test.front,distance=..0.01] run tag @s add bs.view.test.at"}
assert entity @s[tag=bs.view.test.at]
tag @s remove bs.view.test.at

# looking away, at nothing
tp @s ~4.5 ~ ~4.5 180 0
assert not run function #bs.view:as_looked_entity.in {run:"say no"}
kill @e[type=minecraft:armor_stand,tag=bs.view.is_lookable]
