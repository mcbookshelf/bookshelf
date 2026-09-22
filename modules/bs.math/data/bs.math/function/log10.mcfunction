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
data modify storage bs:ctx y set value 0
data modify storage bs:ctx x set from storage bs:in math.log.x

execute unless predicate {type:"float_value_check",value:{type:"storage","storage":"bs:in",path:"math.log.x"},test:{min:1}} run function bs.math:log/loop_exp_neg
execute if predicate {type:"float_value_check",value:{type:"storage","storage":"bs:in",path:"math.log.x"},test:{min:1}} run function bs.math:log/loop_exp

data modify storage bs:ctx x set compute default float {type:"mul",inputs:["bs.math:log",{type:"pow",base:2,exponent:{type:"storage",storage:"bs:ctx",path:"y"}}]}
data modify storage bs:out math.log set compute default float {type:"div",left:{type:"pow",base:"bs.math:e",exponent:"bs.math:log"},right:"bs.math:ln10"}
