# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
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

execute store result score #u bs.ctx run data get storage bs:data raycast.record[-1].tmax
execute store result score #v bs.ctx run data get storage bs:data raycast.record[-1].flag
execute if score #v bs.ctx = #f bs.ctx if score #x bs.ctx <= #u bs.ctx run return run function bs.raycast:collide/record/slice/merge_right
data modify storage bs:ctx _.right prepend from storage bs:data raycast.record[-1]
data remove storage bs:data raycast.record[-1]
execute store result score #u bs.ctx run data get storage bs:data raycast.record[-1].tmin
execute if data storage bs:data raycast.record[-1] if score #x bs.ctx > #u bs.ctx run function bs.raycast:collide/record/slice/right
