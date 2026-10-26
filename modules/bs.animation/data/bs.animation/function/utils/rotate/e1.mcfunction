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

execute unless data storage bs.animation: stack[-1]._[0].l run return run function bs.animation:utils/halt/end

data modify storage bs.animation: stack[-1]._[0].t set compute default float bs.animation:internal/ce
data modify storage bs.animation: stack[-1]._[0].p set from storage bs.animation: stack[-1]._[0].p0
data modify storage bs.animation: stack[-1]._[0].d set from storage bs.animation: stack[-1]._[0].d0
data modify storage bs.animation: stack[-1]._[0].i set value 0
execute if predicate {type:"float_value_check",value:{type:storage,storage:"bs.animation:",path:"stack[-1]._[0].t"},test:{min:1.0}} run function bs.animation:utils/rotate/l1
