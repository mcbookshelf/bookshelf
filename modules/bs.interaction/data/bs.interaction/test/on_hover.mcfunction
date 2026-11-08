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

summon minecraft:interaction ~4.5 ~1 ~3.5 {Tags:["ward.interaction.hover","ward.interaction.hover.executor"],width:1f,height:2f}
summon minecraft:interaction ~5.5 ~1 ~4.5 {Tags:["ward.interaction.hover","ward.interaction.hover.trap"],width:1f,height:2f}
summon minecraft:interaction ~3.5 ~1 ~4.5 {Tags:["ward.interaction.hover","ward.interaction.hover.trap"],width:1f,height:2f}
tp @s ~4.5 ~1 ~4.5 0 0
execute as @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap] run function #bs.interaction:on_hover.in {run:"tag @s add ward.interaction.hover.source",executor:"source",with:{}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap] run function #bs.interaction:on_hover.in {run:"tag @s add ward.interaction.hover.target",executor:"target",with:{}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap] run function #bs.interaction:on_hover.in {run:"tag @s add ward.interaction.hover.interpreted",executor:"@n[tag=ward.interaction.hover.executor]",with:{lazy:false}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap] run function #bs.interaction:on_hover.in {run:"tag @s add ward.interaction.hover.lazy",executor:"@n[tag=ward.interaction.hover.executor]",with:{}}

# The command does not run before the interaction is looked at
await delay 2t
assert not entity @s[tag=ward.interaction.hover.source]

# The command runs as the source, the target, a resolved selector and a lazy selector
tp @s ~4.5 ~1 ~4.5 180 0
await entity @s[tag=ward.interaction.hover.source]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap,tag=ward.interaction.hover.target]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap,tag=ward.interaction.hover.interpreted]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap,tag=ward.interaction.hover.lazy]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.hover.trap,tag=ward.interaction.hover.target]

# The command runs every tick
tag @e remove ward.interaction.hover.source
tag @e remove ward.interaction.hover.target
tag @e remove ward.interaction.hover.interpreted
tag @e remove ward.interaction.hover.lazy
await entity @s[tag=ward.interaction.hover.source]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap,tag=ward.interaction.hover.target]

# A resolved selector keeps its entity, a lazy one finds the new one
tag @e remove ward.interaction.hover.source
tag @e remove ward.interaction.hover.target
tag @e remove ward.interaction.hover.interpreted
tag @e remove ward.interaction.hover.lazy
tag @e remove ward.interaction.hover.executor
tag @s add ward.interaction.hover.executor
await entity @s[tag=ward.interaction.hover.lazy]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap,tag=ward.interaction.hover.interpreted]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.hover,tag=!ward.interaction.hover.trap,tag=ward.interaction.hover.lazy]

# The command stops when the player looks away
tp @s ~4.5 ~1 ~4.5 0 0
await delay 2t
tag @e remove ward.interaction.hover.source
tag @e remove ward.interaction.hover.target
tag @e remove ward.interaction.hover.interpreted
tag @e remove ward.interaction.hover.lazy
await delay 2t
assert not entity @s[tag=ward.interaction.hover.source]

# The current entity must be an interaction, and a resolved selector must find an entity
assert not run function #bs.interaction:on_hover.in {run:"say ward",executor:"source",with:{}}
assert not run execute as @n[type=minecraft:interaction,tag=ward.interaction.hover] run function #bs.interaction:on_hover.in {run:"say ward",executor:"@n[type=minecraft:allay,tag=ward.interaction.hover.none]",with:{lazy:false}}
