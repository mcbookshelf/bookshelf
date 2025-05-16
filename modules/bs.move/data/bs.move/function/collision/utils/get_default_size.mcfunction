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

function #bs.hitbox:get_entity
execute store result score #s bs.ctx run data get storage bs:out hitbox.scale 1000
execute store result score #move.hw bs.data run data get storage bs:out hitbox.width 5000
execute store result score #move.hh bs.data run data get storage bs:out hitbox.height 5000
execute store result score #move.hd bs.data run data get storage bs:out hitbox.depth 5000
scoreboard players operation #move.hw bs.data *= #s bs.ctx
scoreboard players operation #move.hh bs.data *= #s bs.ctx
scoreboard players operation #move.hd bs.data *= #s bs.ctx
