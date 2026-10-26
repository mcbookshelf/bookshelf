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

data modify storage bs.animation: stack[-1]._[0].i set compute default integer {type:add,inputs:[{type:storage,storage:"bs.animation:",path:"stack[-1]._[0].i"},1]}
execute if predicate {type:"int_value_check",value:{type:storage,storage:"bs.animation:",path:"stack[-1]._[0].i"},test:{min:{type:storage,storage:"bs.animation:",path:"stack[-1]._[0].n"}}} run return run function bs.animation:utils/rotate/e2

data modify storage bs.animation: stack[-1]._[0].p append from storage bs.animation: stack[-1]._[0].p[0]
data remove storage bs.animation: stack[-1]._[0].p[0]
data modify storage bs.animation: stack[-1]._[0].p append from storage bs.animation: stack[-1]._[0].p[0]
data remove storage bs.animation: stack[-1]._[0].p[0]
execute if data storage bs.animation: stack[-1]._[0].d[0] run data modify storage bs.animation: stack[-1]._[0].d append from storage bs.animation: stack[-1]._[0].d[0]
execute if data storage bs.animation: stack[-1]._[0].d[0] run data remove storage bs.animation: stack[-1]._[0].d[0]

data modify storage bs.animation: stack[-1]._[0].t set compute default float bs.animation:internal/cl
execute if predicate {type:"float_value_check",value:{type:storage,storage:"bs.animation:",path:"stack[-1]._[0].t"},test:{min:1.0}} run function bs.animation:utils/rotate/l2
