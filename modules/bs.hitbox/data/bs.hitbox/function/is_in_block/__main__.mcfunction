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

execute store result score #s bs.ctx run function bs.hitbox:utils/provide_blocks with storage bs.hitbox:is_in_block in
execute if score #s bs.ctx matches 0 run return fail
execute unless data storage bs.hitbox:get_block out[0] run return 1

execute store result score #n bs.ctx run data get storage bs.hitbox:get_block out
execute summon minecraft:marker run function bs.hitbox:utils/get_fract_pos
return run execute if predicate bs.hitbox:_is_in_block/inside
