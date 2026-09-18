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

return run execute store result storage bs.xp:get_required_points out int 1 run compute default integer {type:number_dispatcher,cases:[ \
  {condition:{type:int_value_check,value:{type:storage,storage:"bs.xp:",path:"levels"},test:{max:15}},value:{type:add,inputs:[{type:mul,inputs:[2,{type:storage,storage:"bs.xp:",path:"levels"}]},7]}}, \
  {condition:{type:int_value_check,value:{type:storage,storage:"bs.xp:",path:"levels"},test:{min:16,max:30}},value:{type:add,inputs:[{type:mul,inputs:[5,{type:storage,storage:"bs.xp:",path:"levels"}]},-38]}}, \
],default:{type:add,inputs:[{type:mul,inputs:[9,{type:storage,storage:"bs.xp:",path:"levels"}]},-158]}}
