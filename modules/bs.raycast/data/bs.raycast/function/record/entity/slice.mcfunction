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

data modify storage bs:ctx _.r prepend from storage bs:data raycast.re[-1]
data remove storage bs:data raycast.re[-1]
execute if data storage bs:data raycast.re[-1] unless predicate {type:"float_value_check",test:{min:{type:"storage",storage:"bs:data",path:"raycast.re[-1].tmin"}},value:{type:"storage",storage:"bs:ctx",path:"x"}} run function bs.raycast:record/entity/slice

