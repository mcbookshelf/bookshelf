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

execute if score @s bs.raycast.hit >= #raycast.entity bs.data run return run scoreboard players operation #raycast.other bs.data < @s bs.raycast.hit
scoreboard players operation #raycast.other bs.data = #raycast.entity bs.data
scoreboard players operation #raycast.entity bs.data = @s bs.raycast.hit
