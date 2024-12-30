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

$execute unless predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"minecraft:player","looking_at":{"type":"minecraft:interaction","nbt":"{\"Tags\":[\"bs.interaction.is_hoverable\"]}","distance":{"absolute":{"max":$(y)}}}}}} run return fail

tag @s add bs.interaction.source
tag @n[type=minecraft:interaction,tag=bs.interaction.is_hoverable,distance=..24,limit=2147483647] add bs.interaction.target
function bs.interaction:on_event/hover_enter/get_target/filter
execute as @n[type=minecraft:interaction,tag=bs.interaction.target,distance=..24] run function bs.interaction:on_event/hover_enter/as_target
tag @s remove bs.interaction.source
