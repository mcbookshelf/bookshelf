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

execute store result score #u bs.ctx run data get storage bs:data raycast.record[-1].tmin
execute store result score #v bs.ctx run data get storage bs:data raycast.record[-1].flag
execute if score #v bs.ctx = #f bs.ctx if score #i bs.ctx >= #u bs.ctx run return run function bs.raycast:collide/record/slice/merge_left
data modify storage bs:ctx _.left prepend from storage bs:data raycast.record[-1]
data remove storage bs:data raycast.record[-1]
execute if data storage bs:data raycast.record[-1] unless score #v bs.ctx = #f bs.ctx run function bs.raycast:collide/record/slice/left
