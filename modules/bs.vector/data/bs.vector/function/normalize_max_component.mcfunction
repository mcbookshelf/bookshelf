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

$scoreboard players set #s bs.ctx $(scale)

scoreboard players operation $vector.normalize_max_component.factor bs.out = $vector.normalize_max_component.0 bs.in
execute if predicate {"condition":"minecraft:inverted","term":{"condition":"minecraft:any_of","terms":[{"condition":"minecraft:value_check","value":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.1"},"score":"bs.in"},"range":{"min":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.factor"},"score":"bs.out","scale":-1},"max":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.factor"},"score":"bs.out"}}},{"condition":"minecraft:value_check","value":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.1"},"score":"bs.in"},"range":{"min":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.factor"},"score":"bs.out"},"max":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.factor"},"score":"bs.out","scale":-1}}}]}} \
  run scoreboard players operation $vector.normalize_max_component.factor bs.out = $vector.normalize_max_component.1 bs.in
execute if predicate {"condition":"minecraft:inverted","term":{"condition":"minecraft:any_of","terms":[{"condition":"minecraft:value_check","value":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.2"},"score":"bs.in"},"range":{"min":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.factor"},"score":"bs.out","scale":-1},"max":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.factor"},"score":"bs.out"}}},{"condition":"minecraft:value_check","value":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.2"},"score":"bs.in"},"range":{"min":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.factor"},"score":"bs.out"},"max":{"type":"minecraft:score","target":{"type":"minecraft:fixed","name":"$vector.normalize_max_component.factor"},"score":"bs.out","scale":-1}}}]}} \
  run scoreboard players operation $vector.normalize_max_component.factor bs.out = $vector.normalize_max_component.2 bs.in
execute if score $vector.normalize_max_component.factor bs.out matches ..-1 run scoreboard players operation $vector.normalize_max_component.factor bs.out *= -1 bs.const

scoreboard players operation $vector.normalize_max_component.0 bs.out = $vector.normalize_max_component.0 bs.in
scoreboard players operation $vector.normalize_max_component.1 bs.out = $vector.normalize_max_component.1 bs.in
scoreboard players operation $vector.normalize_max_component.2 bs.out = $vector.normalize_max_component.2 bs.in

scoreboard players operation $vector.normalize_max_component.0 bs.out *= #s bs.ctx
scoreboard players operation $vector.normalize_max_component.1 bs.out *= #s bs.ctx
scoreboard players operation $vector.normalize_max_component.2 bs.out *= #s bs.ctx

scoreboard players operation $vector.normalize_max_component.0 bs.out /= $vector.normalize_max_component.factor bs.out
scoreboard players operation $vector.normalize_max_component.1 bs.out /= $vector.normalize_max_component.factor bs.out
scoreboard players operation $vector.normalize_max_component.2 bs.out /= $vector.normalize_max_component.factor bs.out
