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

$execute store result score #h bs.ctx run data remove entity @s data."bs.interaction".hover[$(filter)]
$execute store result score #i bs.ctx run data remove entity @s data."bs.interaction".hover_enter[$(filter)]
$execute store result score #o bs.ctx run data remove entity @s data."bs.interaction".hover_leave[$(filter)]
$execute store result score #l bs.ctx run data remove entity @s data."bs.interaction".left_click[$(filter)]
$execute store result score #r bs.ctx run data remove entity @s data."bs.interaction".right_click[$(filter)]
scoreboard players operation #c bs.ctx = #h bs.ctx
scoreboard players operation #c bs.ctx += #i bs.ctx
scoreboard players operation #c bs.ctx += #o bs.ctx
scoreboard players operation #c bs.ctx += #l bs.ctx
scoreboard players operation #c bs.ctx += #r bs.ctx
