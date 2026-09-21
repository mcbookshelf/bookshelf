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

tag @s add bs.raycast.checked

execute if entity @s[scores={bs.width=0..,bs.height=0..,bs.depth=0..}] run return run function bs.raycast:check/entity/custom

# get hitbox dimensions (width, depth, height)
function #bs.hitbox:get_entity
execute if predicate {type:"any_of",terms:[{type:"float_value_check",test:{max:0},value:{type:"storage",storage:"bs:out",path:"hitbox.width"}},{type:"float_value_check",test:{max:0},value:{type:"storage",storage:"bs:out",path:"hitbox.height"}},{type:"float_value_check",test:{max:0},value:{type:"storage",storage:"bs:out",path:"hitbox.depth"}}]} run return 0
data modify storage bs:ctx w set compute default float {type:"mul",inputs:[{type:"mul",inputs:[0.5,{type:"storage",storage:"bs:out",path:"hitbox.width"}]},{type:"storage",storage:"bs:out",path:"hitbox.scale"}]}
data modify storage bs:ctx h set compute default float {type:"mul",inputs:[{type:"mul",inputs:[0.5,{type:"storage",storage:"bs:out",path:"hitbox.height"}]},{type:"storage",storage:"bs:out",path:"hitbox.scale"}]}
data modify storage bs:ctx d set compute default float {type:"mul",inputs:[{type:"mul",inputs:[0.5,{type:"storage",storage:"bs:out",path:"hitbox.depth"}]},{type:"storage",storage:"bs:out",path:"hitbox.scale"}]}

# run size-based collision check
execute if entity @s[type=#bs.hitbox:is_shaped] run return run function bs.raycast:check/entity/aabb
data modify storage bs:data raycast.ry set compute default float {type:"add",inputs:[{type:"storage",storage:"bs:data",path:"raycast.ry"},{type:"storage",storage:"bs:ctx",path:"h"}]}
function bs.raycast:check/entity/aabb
data modify storage bs:data raycast.ry set compute default float {type:"sub",left:{type:"storage",storage:"bs:data",path:"raycast.ry"},right:{type:"storage",storage:"bs:ctx",path:"h"}}
