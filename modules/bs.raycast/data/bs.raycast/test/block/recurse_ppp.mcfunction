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

setblock ~1 ~ ~1 minecraft:bookshelf
execute positioned ~.5 ~ ~.5 facing ~.51 ~.99 ~1.49 run function #bs.raycast:run {with:{}}
execute unless data storage bs:out raycast.targeted_block run fail "Failed to detect a targeted block"
execute positioned ~.5 ~ ~.5 facing ~1.49 ~.99 ~.51 run function #bs.raycast:run {with:{}}
execute unless data storage bs:out raycast.targeted_block run fail "Failed to detect a targeted block"
