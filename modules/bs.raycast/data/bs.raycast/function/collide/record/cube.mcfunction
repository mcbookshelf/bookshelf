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

execute store result score #raycast.btmin bs.data run scoreboard players operation #raycast.lx bs.data -= #raycast.dx bs.data
scoreboard players operation #raycast.ly bs.data -= #raycast.dy bs.data
scoreboard players operation #raycast.lz bs.data -= #raycast.dz bs.data
scoreboard players operation #raycast.btmin bs.data > #raycast.ly bs.data
scoreboard players operation #raycast.btmin bs.data > #raycast.lz bs.data
scoreboard players operation #raycast.tmin bs.data < #raycast.btmin bs.data

scoreboard players set #raycast.norm bs.data 0
execute if score #raycast.ly bs.data = #raycast.btmin bs.data run scoreboard players set #raycast.norm bs.data 1
execute if score #raycast.lz bs.data = #raycast.btmin bs.data run scoreboard players set #raycast.norm bs.data 2

scoreboard players operation #raycast.lx bs.data += #raycast.dx bs.data
scoreboard players operation #raycast.ly bs.data += #raycast.dy bs.data
scoreboard players operation #raycast.lz bs.data += #raycast.dz bs.data
