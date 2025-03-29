# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

# Check only the interaction that the player was looking at.
# If the player is not looking at any interaction, return the hover leave event and restart the whole cycle.

tag @s add bs.interaction.source
scoreboard players operation #h bs.ctx = @s bs.interaction.hover
$tag @n[type=minecraft:interaction,distance=..$(y),predicate=bs.interaction:hover_equal] add bs.interaction.target
execute unless predicate {condition:entity_properties,entity:this,predicate:{type_specific:{type:player,looking_at:{type:interaction,nbt:"{Tags:[bs.interaction.target]}"}}}} run return run function bs.interaction:on_event/hover_leave/hover_leave
execute as @n[type=minecraft:interaction,tag=bs.interaction.target,distance=..24] run function bs.interaction:on_event/hover/as_target
tag @s remove bs.interaction.source
