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

data remove storage bs:lambda hitbox
$execute store result score $raycast.hit_flag bs.lambda run $(blocks)
execute unless data storage bs:lambda hitbox run return run execute if score $raycast.hit_flag bs.lambda matches 1.. run function bs.raycast:react/cube


execute if predicate bs.raycast:internal/positive_ux run data modify storage bs:data raycast.lx set compute default float bs.raycast:internal/decrement_lx
execute if predicate bs.raycast:internal/positive_uy run data modify storage bs:data raycast.ly set compute default float bs.raycast:internal/decrement_ly
execute if predicate bs.raycast:internal/positive_uz run data modify storage bs:data raycast.lz set compute default float bs.raycast:internal/decrement_lz
execute if data storage bs:lambda hitbox.shape[-1] run function bs.raycast:check/block/aabb
execute if predicate bs.raycast:internal/positive_ux run data modify storage bs:data raycast.lx set compute default float bs.raycast:internal/increment_lx
execute if predicate bs.raycast:internal/positive_uy run data modify storage bs:data raycast.ly set compute default float bs.raycast:internal/increment_ly
execute if predicate bs.raycast:internal/positive_uz run data modify storage bs:data raycast.lz set compute default float bs.raycast:internal/increment_lz
