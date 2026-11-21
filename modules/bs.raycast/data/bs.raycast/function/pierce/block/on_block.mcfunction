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

scoreboard players operation #raycast.hit bs.data = #raycast.bhit bs.data
scoreboard players set #raycast.bhit bs.data 2147483647
execute store result score #p bs.ctx run function bs.raycast:utils/on_block with storage bs.raycast: ray
execute if score #p bs.ctx matches 0 run return run function bs.raycast:pierce/stop
return 1
