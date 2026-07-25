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

scoreboard players operation $vector.abs_max bs.out = $vector.abs_max.0 bs.in
execute if predicate {condition:"inverted",term:{condition:"any_of",terms:[{condition:"value_check",value:{type:"score",target:{type:"fixed",name:"$vector.abs_max.1"},score:"bs.in"},range:{min:{type:"score",target:{type:"fixed",name:"$vector.abs_max"},score:"bs.out","scale":-1},max:{type:"score",target:{type:"fixed",name:"$vector.abs_max"},score:"bs.out"}}},{condition:"value_check",value:{type:"score",target:{type:"fixed",name:"$vector.abs_max.1"},score:"bs.in"},range:{min:{type:"score",target:{type:"fixed",name:"$vector.abs_max"},score:"bs.out"},max:{type:"score",target:{type:"fixed",name:"$vector.abs_max"},score:"bs.out","scale":-1}}}]}} \
  run scoreboard players operation $vector.abs_max bs.out = $vector.abs_max.1 bs.in
execute if predicate {condition:"inverted",term:{condition:"any_of",terms:[{condition:"value_check",value:{type:"score",target:{type:"fixed",name:"$vector.abs_max.2"},score:"bs.in"},range:{min:{type:"score",target:{type:"fixed",name:"$vector.abs_max"},score:"bs.out","scale":-1},max:{type:"score",target:{type:"fixed",name:"$vector.abs_max"},score:"bs.out"}}},{condition:"value_check",value:{type:"score",target:{type:"fixed",name:"$vector.abs_max.2"},score:"bs.in"},range:{min:{type:"score",target:{type:"fixed",name:"$vector.abs_max"},score:"bs.out"},max:{type:"score",target:{type:"fixed",name:"$vector.abs_max"},score:"bs.out","scale":-1}}}]}} \
  run scoreboard players operation $vector.abs_max bs.out = $vector.abs_max.2 bs.in
return run scoreboard players get $vector.abs_max bs.out
