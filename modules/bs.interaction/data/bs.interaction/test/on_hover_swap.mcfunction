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
# @dummy

summon minecraft:interaction ~4 ~1 ~5.5 {Tags:["ward.interaction.swap","ward.interaction.swap.1"],width:1f,height:2f}
summon minecraft:interaction ~5 ~1 ~5.5 {Tags:["ward.interaction.swap","ward.interaction.swap.2"],width:1f,height:2f}
execute as @e[type=minecraft:interaction,tag=ward.interaction.swap] run function #bs.interaction:on_hover_enter.in {run:"tag @s add ward.interaction.swap.hovered",executor:"target",with:{}}
execute as @e[type=minecraft:interaction,tag=ward.interaction.swap] run function #bs.interaction:on_hover_leave.in {run:"tag @s remove ward.interaction.swap.hovered",executor:"target",with:{}}

# Looking from one interaction to the next leaves the first and enters the second
tp @s ~4.5 ~1 ~4.5 45 0
await entity @n[type=minecraft:interaction,tag=ward.interaction.swap.1,tag=ward.interaction.swap.hovered]
tp @s ~4.5 ~1 ~4.5 -45 0
await entity @n[type=minecraft:interaction,tag=ward.interaction.swap.2,tag=ward.interaction.swap.hovered]
await not entity @n[type=minecraft:interaction,tag=ward.interaction.swap.1,tag=ward.interaction.swap.hovered]
