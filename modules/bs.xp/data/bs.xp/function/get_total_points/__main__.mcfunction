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

execute store result storage bs.xp: levels int 1 run xp query @s levels
execute store result storage bs.xp: points int 1 run xp query @s points

return run execute store result storage bs.xp:get_total_points out int 1 run compute default integer {type:add,inputs:[{type:storage,storage:"bs.xp:",path:"points"},{type:number_dispatcher,cases:[ \
  {condition:{type:int_value_check,value:{type:storage,storage:"bs.xp:",path:"levels"},test:{max:16}},value:{type:mul,inputs:[{type:storage,storage:"bs.xp:",path:"levels"},{type:add,inputs:[6,{type:storage,storage:"bs.xp:",path:"levels"}]}]}}, \
  {condition:{type:int_value_check,value:{type:storage,storage:"bs.xp:",path:"levels"},test:{min:17,max:31}},value:{type:add,inputs:[360,{type:div,left:{type:mul,inputs:[{type:storage,storage:"bs.xp:",path:"levels"},{type:add,inputs:[{type:mul,inputs:[{type:storage,storage:"bs.xp:",path:"levels"},5]},-81]}]},right:2}]}}, \
],default:{type:add,inputs:[2220,{type:div,left:{type:mul,inputs:[{type:storage,storage:"bs.xp:",path:"levels"},{type:add,inputs:[{type:mul,inputs:[{type:storage,storage:"bs.xp:",path:"levels"},9]},-325]}]},right:2}]}}]}
