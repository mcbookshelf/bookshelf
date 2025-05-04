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

scoreboard players operation #h bs.ctx += @s bs.hmod
execute if score #h bs.ctx matches ..0 unless predicate {"condition":"minecraft:entity_properties","entity":"this","predicate":{"type_specific":{"type":"minecraft:player","gamemode":["creative","spectator"]}}} run kill @s

execute store result storage bs:data health.div[-1] float 1 run scoreboard players get #m bs.ctx
execute store result storage bs:data health.div[0] float 1 run scoreboard players operation #h bs.ctx -= #m bs.ctx
data modify entity B5-0-0-0-2 transformation set from storage bs:data health.div

execute store result storage bs:ctx y double .000000001 run data get entity B5-0-0-0-2 transformation.scale[0] -1000000000
function bs.health:utils/apply_health with storage bs:ctx
