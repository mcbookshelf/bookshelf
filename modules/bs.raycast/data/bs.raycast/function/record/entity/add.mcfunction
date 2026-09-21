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

data modify storage bs:ctx _ set value {r:[],e:{norm:1}}
execute unless predicate {type:"float_value_check",test:{max:{type:"storage",storage:"bs:data",path:"raycast.te"}},value:{type:"storage",storage:"bs:ctx",path:"x"}} run function bs.raycast:record/entity/slice

data modify storage bs:data raycast.te set compute default float {type:"min",inputs:[{type:"storage",storage:"bs:data",path:"raycast.te"},{type:"storage",storage:"bs:ctx",path:"x"}]}
data modify storage bs:data raycast.tm set compute default float {type:"min",inputs:[{type:"storage",storage:"bs:data",path:"raycast.tm"},{type:"storage",storage:"bs:data",path:"raycast.te"}]}

execute unless score @s bs.raycast.id matches 1.. store result score @s bs.raycast.id run scoreboard players add #count bs.raycast.id 1
execute if entity @s[type=!#bs.hitbox:is_shaped,tag=!bs.hitbox.centered] run data modify storage bs:ctx b set compute default float {type:"sub",left:{type:"storage",storage:"bs:ctx",path:"b"},right:{type:"storage",storage:"bs:ctx",path:"h"}}

execute store result storage bs:ctx _.e.id int 1 run scoreboard players get @s bs.raycast.id
data modify storage bs:ctx _.e.tmin set from storage bs:ctx x
data modify storage bs:ctx _.e.tmax set from storage bs:ctx i
data modify storage bs:ctx _.e.x set from storage bs:ctx a
data modify storage bs:ctx _.e.y set from storage bs:ctx b
data modify storage bs:ctx _.e.z set from storage bs:ctx c

data modify storage bs:ctx _.e.norm set compute default integer {\
  type:"conditional",\
  condition:{type:"float_value_check",test:{type:"storage",storage:"bs:ctx",path:"z"},value:{type:"storage",storage:"bs:ctx",path:"x"}},\
  on_true:2,\
  on_false:{\
    type:"conditional",\
    condition:{type:"float_value_check",test:{type:"storage",storage:"bs:ctx",path:"y"},value:{type:"storage",storage:"bs:ctx",path:"x"}},\
    on_true:3\
  }\
}

data modify storage bs:data raycast.re append from storage bs:ctx _.e
data modify storage bs:data raycast.re append from storage bs:ctx _.r[]

execute store result score #raycast.id bs.data run data get storage bs:data raycast.re[-1].id

