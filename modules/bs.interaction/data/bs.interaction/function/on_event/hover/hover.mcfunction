# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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
execute store result storage bs:ctx y int 1 run scoreboard players get @s bs.interaction.id
execute as @n[type=minecraft:interaction,predicate=bs.interaction:check_id] run tag @s add bs.interaction.target
$execute unless predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"minecraft:player","looking_at":{"type":"minecraft:interaction","nbt":"{\"Tags\":[\"bs.interaction.target\"]}","distance":{"absolute":{"max":$(y)}}}}}} run return run function bs.interaction:on_event/hover_leave/hover_leave
execute as @n[type=minecraft:interaction,tag=bs.interaction.target,distance=..24] run function bs.interaction:on_event/hover/as_target
tag @s remove bs.interaction.source
