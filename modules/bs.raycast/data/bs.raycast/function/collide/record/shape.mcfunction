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

scoreboard players operation #raycast.btmin bs.data = #x bs.ctx
scoreboard players operation #raycast.tmin bs.data < #raycast.btmin bs.data

execute if score #z bs.ctx = #x bs.ctx run return run scoreboard players set #raycast.norm bs.data 2
execute if score #y bs.ctx = #x bs.ctx run return run scoreboard players set #raycast.norm bs.data 1
scoreboard players set #raycast.norm bs.data 0
