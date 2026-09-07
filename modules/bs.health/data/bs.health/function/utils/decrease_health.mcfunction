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

scoreboard players operation #h bs.ctx += @s bs.hmod
execute if score #h bs.ctx matches ..0 unless predicate {type:"entity_properties",entity:"this",predicate:{"type_specific/player":{gamemode:["creative","spectator"]}}} run kill @s

# Get add_multiplied_total to reduce health to the target value, it's applied last, so it won't mess with other modifiers
data modify storage bs:ctx y set compute default float {type:sub,left:{type:div,left:{type:from_int,input:{type:score,score:"bs.ctx",target:{type:fixed,name:"#h"}}},right:{type:from_int,input:{type:score,score:"bs.ctx",target:{type:fixed,name:"#m"}}}},right:1}
function bs.health:utils/apply_health with storage bs:ctx
