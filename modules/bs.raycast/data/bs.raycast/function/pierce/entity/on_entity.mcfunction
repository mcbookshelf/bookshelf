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

scoreboard players operation #raycast.hit bs.data = @s bs.raycast.hit
execute if score @s bs.raycast.shapes matches ..-1 store result score #c bs.ctx run compute default integer bs.raycast:_pierce/e/flags
execute if score @s bs.raycast.shapes matches ..-1 store result score #raycast.hit bs.data run compute default integer bs.raycast:_pierce/e/hit
execute at @s store result score #p bs.ctx run function bs.raycast:utils/on_entity with storage bs.raycast: ray
execute if score #p bs.ctx matches 0 run return run function bs.raycast:pierce/stop
return 1
