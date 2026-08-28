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

data modify storage bs:ctx h set compute default {type:"sum",operands:[{type:"storage",storage:"bs:ctx",path:"h"},{type:"storage",storage:"bs:ctx",path:"f"}]}
execute store result score #h bs.ctx run data get storage bs:ctx h
execute if score #h bs.ctx matches ..-1 unless predicate {type:"entity_properties",entity:"this",predicate:{"type_specific/player":{gamemode:["creative","spectator"]}}} run return run kill @s

# Get add_multiplied_total to reduce health to the target value, it's applied last, so it won't mess with other modifiers
data modify storage bs:data health.div[0] set compute default {type:"sum",operands:[{type:"storage",storage:"bs:ctx",path:"h"},{type:"product",operands:[-1,{type:"storage",storage:"bs:ctx",path:"m"}]}]}
data modify storage bs:data health.div[-1] set from storage bs:ctx m
data modify entity B5-0-0-0-2 transformation set from storage bs:data health.div
data modify storage bs:ctx y set from entity B5-0-0-0-2 transformation.scale[0]
data modify storage bs:ctx y set compute default {type:"product",operands:[-1,{type:"storage",storage:"bs:ctx",path:"y"}]}

function bs.health:utils/apply_health with storage bs:ctx
