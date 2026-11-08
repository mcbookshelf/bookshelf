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

summon minecraft:interaction ~4.5 ~1 ~4.5 {Tags:["ward.interaction.left_click","ward.interaction.left_click.executor"],width:1f,height:2f}
tp @s ~4.5 ~1 ~4.5
execute as @n[type=minecraft:interaction,tag=ward.interaction.left_click] run function #bs.interaction:on_left_click.in {run:"tag @s add ward.interaction.left_click.source",executor:"source",with:{}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.left_click] run function #bs.interaction:on_left_click.in {run:"tag @s add ward.interaction.left_click.target",executor:"target",with:{}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.left_click] run function #bs.interaction:on_left_click.in {run:"tag @s add ward.interaction.left_click.interpreted",executor:"@n[tag=ward.interaction.left_click.executor]",with:{lazy:false}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.left_click] run function #bs.interaction:on_left_click.in {run:"tag @s add ward.interaction.left_click.lazy",executor:"@n[tag=ward.interaction.left_click.executor]",with:{}}

# The command runs as the source, the target, a resolved selector and a lazy selector
dummy @s attack @n[type=minecraft:interaction,tag=ward.interaction.left_click]
assert entity @s[tag=ward.interaction.left_click.source]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.left_click,tag=ward.interaction.left_click.target]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.left_click,tag=ward.interaction.left_click.interpreted]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.left_click,tag=ward.interaction.left_click.lazy]

# A resolved selector keeps its entity, a lazy one finds the new one
tag @e remove ward.interaction.left_click.source
tag @e remove ward.interaction.left_click.target
tag @e remove ward.interaction.left_click.interpreted
tag @e remove ward.interaction.left_click.lazy
tag @e remove ward.interaction.left_click.executor
tag @s add ward.interaction.left_click.executor
dummy @s attack @n[type=minecraft:interaction,tag=ward.interaction.left_click]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.left_click,tag=ward.interaction.left_click.interpreted]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.left_click,tag=ward.interaction.left_click.lazy]
assert entity @s[tag=ward.interaction.left_click.lazy]

# The current entity must be an interaction, and a resolved selector must find an entity
assert not run function #bs.interaction:on_left_click.in {run:"say ward",executor:"source",with:{}}
assert not run execute as @n[type=minecraft:interaction,tag=ward.interaction.left_click] run function #bs.interaction:on_left_click.in {run:"say ward",executor:"@n[type=minecraft:allay,tag=ward.interaction.left_click.none]",with:{lazy:false}}
