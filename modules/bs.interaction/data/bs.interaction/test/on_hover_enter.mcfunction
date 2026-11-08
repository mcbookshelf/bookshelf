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

summon minecraft:interaction ~4.5 ~1 ~3.5 {Tags:["ward.interaction.hover_enter","ward.interaction.hover_enter.executor"],width:1f,height:2f}
summon minecraft:interaction ~5.5 ~1 ~4.5 {Tags:["ward.interaction.hover_enter","ward.interaction.hover_enter.trap"],width:1f,height:2f}
summon minecraft:interaction ~3.5 ~1 ~4.5 {Tags:["ward.interaction.hover_enter","ward.interaction.hover_enter.trap"],width:1f,height:2f}
tp @s ~4.5 ~1 ~4.5 0 0
execute as @e[type=minecraft:interaction,tag=ward.interaction.hover_enter] run function #bs.interaction:on_hover_enter.in {run:"tag @s add ward.interaction.hover_enter.source",executor:"source",with:{}}
execute as @e[type=minecraft:interaction,tag=ward.interaction.hover_enter] run function #bs.interaction:on_hover_enter.in {run:"tag @s add ward.interaction.hover_enter.target",executor:"target",with:{}}
execute as @e[type=minecraft:interaction,tag=ward.interaction.hover_enter] run function #bs.interaction:on_hover_enter.in {run:"tag @s add ward.interaction.hover_enter.interpreted",executor:"@n[tag=ward.interaction.hover_enter.executor]",with:{lazy:false}}
execute as @e[type=minecraft:interaction,tag=ward.interaction.hover_enter] run function #bs.interaction:on_hover_enter.in {run:"tag @s add ward.interaction.hover_enter.lazy",executor:"@n[tag=ward.interaction.hover_enter.executor]",with:{}}

# The command does not run before the player starts looking at the interaction
await delay 2t
assert not entity @s[tag=ward.interaction.hover_enter.source]

# The command runs once, as the source, the target, a resolved selector and a lazy selector
tp @s ~4.5 ~1 ~4.5 180 0
await entity @s[tag=ward.interaction.hover_enter.source]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover_enter,tag=!ward.interaction.hover_enter.trap,tag=ward.interaction.hover_enter.target]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover_enter,tag=!ward.interaction.hover_enter.trap,tag=ward.interaction.hover_enter.interpreted]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover_enter,tag=!ward.interaction.hover_enter.trap,tag=ward.interaction.hover_enter.lazy]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.hover_enter.trap,tag=ward.interaction.hover_enter.target]
tag @e remove ward.interaction.hover_enter.source
tag @e remove ward.interaction.hover_enter.target
tag @e remove ward.interaction.hover_enter.interpreted
tag @e remove ward.interaction.hover_enter.lazy
await delay 2t
assert not entity @s[tag=ward.interaction.hover_enter.source]

# A resolved selector keeps its entity, a lazy one finds the new one
tag @e remove ward.interaction.hover_enter.executor
tag @s add ward.interaction.hover_enter.executor
tp @s ~4.5 ~1 ~4.5 0 0
await delay 2t
tag @e remove ward.interaction.hover_enter.source
tag @e remove ward.interaction.hover_enter.target
tag @e remove ward.interaction.hover_enter.interpreted
tag @e remove ward.interaction.hover_enter.lazy
tp @s ~4.5 ~1 ~4.5 180 0
await entity @s[tag=ward.interaction.hover_enter.source]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover_enter,tag=!ward.interaction.hover_enter.trap,tag=ward.interaction.hover_enter.interpreted]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.hover_enter,tag=!ward.interaction.hover_enter.trap,tag=ward.interaction.hover_enter.lazy]
assert entity @s[tag=ward.interaction.hover_enter.lazy]

# The current entity must be an interaction, and a resolved selector must find an entity
assert not run function #bs.interaction:on_hover_enter.in {run:"say ward",executor:"source",with:{}}
assert not run execute as @n[type=minecraft:interaction,tag=ward.interaction.hover_enter] run function #bs.interaction:on_hover_enter.in {run:"say ward",executor:"@n[type=minecraft:allay,tag=ward.interaction.hover_enter.none]",with:{lazy:false}}
