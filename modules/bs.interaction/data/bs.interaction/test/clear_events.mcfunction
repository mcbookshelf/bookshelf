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

summon minecraft:interaction ~.5 ~ ~.5 {Tags:["ward.interaction.clear"],width:1f,height:2f}
execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:on_left_click.in {run:"say ward",executor:"target",with:{id:"ward.a"}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:on_left_click.in {run:"say ward",executor:"target",with:{id:"ward.b"}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:on_left_click.in {run:"say ward",executor:"target",with:{}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:on_right_click.in {run:"say ward",executor:"target",with:{id:"ward.a"}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:on_hover.in {run:"say ward",executor:"target",with:{id:"ward.a"}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:on_hover_enter.in {run:"say ward",executor:"target",with:{id:"ward.b"}}
execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:on_hover_leave.in {run:"say ward",executor:"target",with:{id:"ward.b"}}

# A type and an id clear the matching events only
assert result 1 run execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:clear_events.in {with:{type:"left_click",id:"ward.a"}}
assert result 0 run execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:clear_events.in {with:{type:"left_click",id:"ward.a"}}
assert entity @n[type=minecraft:interaction,tag=ward.interaction.clear,tag=bs.interaction.listen_left_click]

# An id clears its events of every type
assert result 2 run execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:clear_events.in {with:{id:"ward.a"}}
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.clear,tag=bs.interaction.listen_right_click]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.clear,tag=bs.interaction.listen_hover]
assert entity @n[type=minecraft:interaction,tag=ward.interaction.clear,tag=bs.interaction.is_hoverable]

# A type clears its events of every id
assert result 2 run execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:clear_events.in {with:{type:"left_click"}}
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.clear,tag=bs.interaction.listen_left_click]

# Nothing clears every event, and the interaction is no longer hoverable
assert result 2 run execute as @n[type=minecraft:interaction,tag=ward.interaction.clear] run function #bs.interaction:clear_events.in {with:{}}
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.clear,tag=bs.interaction.listen_hover_enter]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.clear,tag=bs.interaction.listen_hover_leave]
assert not entity @n[type=minecraft:interaction,tag=ward.interaction.clear,tag=bs.interaction.is_hoverable]
assert not score @n[type=minecraft:interaction,tag=ward.interaction.clear] bs.interaction.hover matches -2147483648..
