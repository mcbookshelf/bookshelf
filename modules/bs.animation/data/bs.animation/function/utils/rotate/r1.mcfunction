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

data modify storage bs.animation: stack[-1]._[0].i set compute default integer {type:sub,left:{type:storage,storage:"bs.animation:",path:"stack[-1]._[0].i"},right:1}
execute if predicate {type:"int_value_check",value:{type:storage,storage:"bs.animation:",path:"stack[-1]._[0].i"},test:{max:-1}} run return run function bs.animation:utils/rotate/s1

data modify storage bs.animation: stack[-1]._[0].p prepend from storage bs.animation: stack[-1]._[0].p[-1]
data remove storage bs.animation: stack[-1]._[0].p[-1]
execute if data storage bs.animation: stack[-1]._[0].d[0] run data modify storage bs.animation: stack[-1]._[0].d prepend from storage bs.animation: stack[-1]._[0].d[-1]
execute if data storage bs.animation: stack[-1]._[0].d[0] run data remove storage bs.animation: stack[-1]._[0].d[-1]

data modify storage bs.animation: stack[-1]._[0].t set compute default float bs.animation:internal/cr
execute unless predicate {type:"float_value_check",value:{type:storage,storage:"bs.animation:",path:"stack[-1]._[0].t"},test:{min:0.0}} run function bs.animation:utils/rotate/r1
