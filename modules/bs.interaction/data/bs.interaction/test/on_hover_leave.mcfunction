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

summon minecraft:interaction ~4.5 ~1 ~5.5 {Tags:["ward.interaction.hover_leave","ward.interaction.hover_leave.executor"],width:1f,height:2f}
summon minecraft:interaction ~5.5 ~1 ~4.5 {Tags:["ward.interaction.hover_leave","ward.interaction.hover_leave.trap"],width:1f,height:2f}
summon minecraft:interaction ~3.5 ~1 ~4.5 {Tags:["ward.interaction.hover_leave","ward.interaction.hover_leave.trap"],width:1f,height:2f}
tp @s ~4.5 ~1 ~4.5 0 0
execute as @e[type=minecraft:interaction,tag=ward.interaction.hover_leave] run function #bs.interaction:on_hover_leave.in {run:"tag @s add ward.interaction.hover_leave.source",executor:"source",with:{}}
execute as @e[type=minecraft:interaction,tag=ward.interaction.hover_leave] run function #bs.interaction:on_hover_leave.in {run:"tag @s add ward.interaction.hover_leave.target",executor:"target",with:{}}
execute as @e[type=minecraft:interaction,tag=ward.interaction.hover_leave] run function #bs.interaction:on_hover_leave.in {run:"tag @s add ward.interaction.hover_leave.interpreted",executor:"@n[tag=ward.interaction.hover_leave.executor]",with:{lazy:false}}
execute as @e[type=minecraft:interaction,tag=ward.interaction.hover_leave] run function #bs.interaction:on_hover_leave.in {run:"tag @s add ward.interaction.hover_leave.lazy",executor:"@n[tag=ward.interaction.hover_leave.executor]",with:{}}

# The command does not run before the player stops looking at the interaction
await delay 2t
assert not entity @s[tag=ward.interaction.hover_leave.source]

# The command runs once, as the source, the target, a resolved selector and a lazy selector
tp @s ~4.5 ~1 ~4.5 180 0
await entity @s[tag=ward.interaction.hover_leave.source]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover_leave,tag=!ward.interaction.hover_leave.trap,tag=ward.interaction.hover_leave.target]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover_leave,tag=!ward.interaction.hover_leave.trap,tag=ward.interaction.hover_leave.interpreted]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover_leave,tag=!ward.interaction.hover_leave.trap,tag=ward.interaction.hover_leave.lazy]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.hover_leave.trap,tag=ward.interaction.hover_leave.target]
tag @e remove ward.interaction.hover_leave.source
tag @e remove ward.interaction.hover_leave.target
tag @e remove ward.interaction.hover_leave.interpreted
tag @e remove ward.interaction.hover_leave.lazy
await delay 2t
assert not entity @s[tag=ward.interaction.hover_leave.source]

# A resolved selector keeps its entity, a lazy one finds the new one
tag @e remove ward.interaction.hover_leave.executor
tag @s add ward.interaction.hover_leave.executor
tp @s ~4.5 ~1 ~4.5 0 0
await delay 2t
tag @e remove ward.interaction.hover_leave.source
tag @e remove ward.interaction.hover_leave.target
tag @e remove ward.interaction.hover_leave.interpreted
tag @e remove ward.interaction.hover_leave.lazy
tp @s ~4.5 ~1 ~4.5 180 0
await entity @s[tag=ward.interaction.hover_leave.source]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover_leave,tag=!ward.interaction.hover_leave.trap,tag=ward.interaction.hover_leave.interpreted]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.hover_leave,tag=!ward.interaction.hover_leave.trap,tag=ward.interaction.hover_leave.lazy]
assert entity @s[tag=ward.interaction.hover_leave.lazy]

# The current entity must be an interaction, and a resolved selector must find an entity
assert not run function #bs.interaction:on_hover_leave.in {run:"say ward",executor:"source",with:{}}
assert not run execute as @n[type=minecraft:interaction,tag=ward.interaction.hover_leave] run function #bs.interaction:on_hover_leave.in {run:"say ward",executor:"@n[type=minecraft:allay,tag=ward.interaction.hover_leave.none]",with:{lazy:false}}
