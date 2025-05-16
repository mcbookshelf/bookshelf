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

scoreboard players operation @s bs.tmin = #x bs.ctx
scoreboard players operation #raycast.etmin bs.data < #x bs.ctx
scoreboard players operation #raycast.tmin bs.data < #raycast.etmin bs.data

tag @s remove bs.raycast.normx
tag @s remove bs.raycast.normy
tag @s remove bs.raycast.normz
execute if score #z bs.ctx = #x bs.ctx run return run tag @s add bs.raycast.normz
execute if score #y bs.ctx = #x bs.ctx run return run tag @s add bs.raycast.normy
tag @s add bs.raycast.normx
