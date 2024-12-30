# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
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
execute positioned ~1.5 ~ ~.5 facing ~-.5 ~.52 ~ run function #bs.raycast:run {with:{}}
execute unless data storage bs:out raycast.targeted_block run fail "Failed to detect a targeted block"
execute positioned ~-.5 ~ ~.5 facing ~.5 ~.52 ~ run function #bs.raycast:run {with:{}}
execute if data storage bs:out raycast.targeted_block run fail "Should not detect a targeted block"

setblock ~ ~ ~ minecraft:oak_stairs[facing=west]
execute positioned ~-.5 ~ ~.5 facing ~.5 ~.52 ~ run function #bs.raycast:run {with:{}}
execute unless data storage bs:out raycast.targeted_block run fail "Failed to detect a targeted block"
execute positioned ~1.5 ~ ~.5 facing ~-.5 ~.52 ~ run function #bs.raycast:run {with:{}}
execute if data storage bs:out raycast.targeted_block run fail "Should not detect a targeted block"
