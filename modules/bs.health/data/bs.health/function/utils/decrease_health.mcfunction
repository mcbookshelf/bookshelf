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

data modify storage bs:ctx x set compute default float {type:"add",inputs:[{type:"storage",storage:"bs:ctx",path:"h"},{type:"storage",storage:"bs:ctx",path:"f"}]}
execute if predicate {type:"float_value_check",value:{type:"storage",storage:"bs:ctx",path:"h"},test:{max:0}} unless predicate {type:"entity_properties",entity:"this",predicate:{"type_specific/player":{gamemode:["creative","spectator"]}}} run return run kill @s

# Get add_multiplied_total to reduce health to the target value, it's applied last, so it won't mess with other modifiers
data modify storage bs:ctx y set compute default float {type:"add",inputs:[-1f,{type:"div",left:{type:"storage",path:"h",storage:"bs:ctx"},right:{type:"storage",path:"m",storage:"bs:ctx"}}]}
function bs.health:utils/apply_health with storage bs:ctx
