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

summon minecraft:armor_stand ~ ~ ~ {Tags:["bs.ward","bs.ward.1"],NoGravity:1b}
summon minecraft:armor_stand ~ ~1 ~ {Tags:["bs.ward","bs.ward.2"],NoGravity:1b}

execute as @e[type=minecraft:armor_stand,tag=bs.ward.2] at @e[type=minecraft:armor_stand,tag=bs.ward.1] run function #bs.link:create_link_ata
execute as @e[type=minecraft:armor_stand,tag=bs.ward.2] run function #bs.link:at_parent {run:"tag @n add bs.ward.check"}
assert entity @e[type=minecraft:armor_stand,tag=bs.ward.1,tag=bs.ward.check]
