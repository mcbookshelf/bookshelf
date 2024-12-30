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

scoreboard players set #n bs.ctx 0
execute as @n[type=minecraft:interaction,tag=bs.interaction.target,distance=..24,limit=2147483647] run function bs.interaction:on_event/hover_enter/get_target/mask

execute store result score #s bs.ctx if predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"minecraft:player","looking_at":{"type":"minecraft:interaction","nbt":"{\"Tags\":[\"bs.interaction.mask\"]}","distance":{"absolute":{"max":24}}}}}}
execute if score #s bs.ctx matches 0 run tag @n[type=minecraft:interaction,tag=bs.interaction.target,tag=bs.interaction.mask,distance=..24,limit=2147483647] remove bs.interaction.target
execute if score #s bs.ctx matches 1 run tag @n[type=minecraft:interaction,tag=bs.interaction.target,tag=!bs.interaction.mask,distance=..24,limit=2147483647] remove bs.interaction.target

execute if score #n bs.ctx matches 3.. run function bs.interaction:on_event/hover_enter/get_target/filter
