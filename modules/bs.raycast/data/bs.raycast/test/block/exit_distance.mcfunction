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

fill ~-1 ~ ~-1 ~1 ~1 ~1 minecraft:air
setblock ~ ~ ~ minecraft:oak_stairs[facing=east]

execute positioned ~1.5 ~ ~.5 facing ~-.5 ~.52 ~ store result score #r bs.ctx run function #bs.raycast:run {with:{on_exit_point:"assert score $raycast.exit_distance bs.lambda matches 1387"}}
execute if score #r bs.ctx matches 0 run fail "Failed to detect a targeted block"
