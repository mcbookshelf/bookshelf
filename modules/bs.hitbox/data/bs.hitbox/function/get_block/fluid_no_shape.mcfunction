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

execute if predicate bs.hitbox:_get_block/same_fluid_above store result storage bs.hitbox:get_block out int 2 run return 1
data modify storage bs.hitbox:get_block out set value [[0.,0.,0.,1.,.8888888955116272,1.,2.]]
execute if block ~ ~ ~ #bs.hitbox:is_liquid store result storage bs.hitbox:get_block out[0][4] double 0.000000007450580596923828125 run compute block ~ ~ ~ integer bs.hitbox:_get_block/fluid
return 1
