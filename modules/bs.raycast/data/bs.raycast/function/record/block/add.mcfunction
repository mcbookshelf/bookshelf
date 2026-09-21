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

data modify storage bs:ctx _ set value {l:[],r:[],e:{flag:1}}
data modify storage bs:ctx _.e.flag set from storage bs:lambda hitbox.shape[-1][6]
data modify storage bs:ctx f set from storage bs:ctx _.e.flag
scoreboard players set #n bs.ctx 1
execute store result score #n bs.ctx run compute default integer {\
  type:"conditional",\
  condition:{type:"float_value_check",test:{type:"storage",storage:"bs:ctx",path:"z"},value:{type:"storage",storage:"bs:ctx",path:"x"}},\
  on_true:2,\
  on_false:{\
    type:"conditional",\
    condition:{type:"float_value_check",test:{type:"storage",storage:"bs:ctx",path:"y"},value:{type:"storage",storage:"bs:ctx",path:"x"}},\
    on_true:3\
  }\
}

execute unless predicate {type:"float_value_check",test:{max:{type:"storage",storage:"bs:data",path:"raycast.tb"}},value:{type:"storage",storage:"bs:ctx",path:"x"}} run function bs.raycast:record/block/slice_right
execute if data storage bs:data raycast.rb[-1] run function bs.raycast:record/block/slice_left

data modify storage bs:data raycast.tb set compute default float {type:"min",inputs:[{type:"storage",storage:"bs:data",path:"raycast.tb"},{type:"storage",storage:"bs:ctx",path:"x"}]}
data modify storage bs:data raycast.tm set compute default float {type:"min",inputs:[{type:"storage",storage:"bs:data",path:"raycast.tm"},{type:"storage",storage:"bs:data",path:"raycast.tb"}]}

data modify storage bs:ctx _.e.tmin set from storage bs:ctx x
data modify storage bs:ctx _.e.tmax set from storage bs:ctx i
execute store result storage bs:ctx _.e.norm int 1 run scoreboard players get #n bs.ctx

data modify storage bs:data raycast.rb append from storage bs:ctx _.l[]
data modify storage bs:data raycast.rb append from storage bs:ctx _.e
data modify storage bs:data raycast.rb append from storage bs:ctx _.r[]
