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

execute unless predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","looking_at":{"nbt":"{Tags:[\"bs.view.is_lookable\"]}"}}}} run return fail
execute if entity @n[tag=bs.view.is_lookable,tag=!bs.view.bi,sort=arbitrary] run function bs.view:looked_entity/setup
tag @n[tag=bs.view.is_lookable,sort=arbitrary,limit=255] add bs.view.selected
execute if score #view.looked_entity bs.data matches 1.. if predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","looking_at":{"nbt":"{Tags:[\"bs.view.b0\"]}"}}}} run tag @n[tag=bs.view.selected,tag=!bs.view.b0,sort=arbitrary,limit=255] remove bs.view.selected
execute if score #view.looked_entity bs.data matches 2.. if predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","looking_at":{"nbt":"{Tags:[\"bs.view.b1\"]}"}}}} run tag @n[tag=bs.view.selected,tag=!bs.view.b1,sort=arbitrary,limit=255] remove bs.view.selected
execute if score #view.looked_entity bs.data matches 4.. if predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","looking_at":{"nbt":"{Tags:[\"bs.view.b2\"]}"}}}} run tag @n[tag=bs.view.selected,tag=!bs.view.b2,sort=arbitrary,limit=255] remove bs.view.selected
execute if score #view.looked_entity bs.data matches 8.. if predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","looking_at":{"nbt":"{Tags:[\"bs.view.b3\"]}"}}}} run tag @n[tag=bs.view.selected,tag=!bs.view.b3,sort=arbitrary,limit=255] remove bs.view.selected
execute if score #view.looked_entity bs.data matches 16.. if predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","looking_at":{"nbt":"{Tags:[\"bs.view.b4\"]}"}}}} run tag @n[tag=bs.view.selected,tag=!bs.view.b4,sort=arbitrary,limit=255] remove bs.view.selected
execute if score #view.looked_entity bs.data matches 32.. if predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","looking_at":{"nbt":"{Tags:[\"bs.view.b5\"]}"}}}} run tag @n[tag=bs.view.selected,tag=!bs.view.b5,sort=arbitrary,limit=255] remove bs.view.selected
execute if score #view.looked_entity bs.data matches 64.. if predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","looking_at":{"nbt":"{Tags:[\"bs.view.b6\"]}"}}}} run tag @n[tag=bs.view.selected,tag=!bs.view.b6,sort=arbitrary,limit=255] remove bs.view.selected
execute if score #view.looked_entity bs.data matches 128.. if predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","looking_at":{"nbt":"{Tags:[\"bs.view.b7\"]}"}}}} run tag @n[tag=bs.view.selected,tag=!bs.view.b7,sort=arbitrary,limit=255] remove bs.view.selected
$execute as @n[tag=bs.view.is_lookable,tag=bs.view.selected,sort=arbitrary] run return run $(run)
