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

scoreboard players set $math.atan2.y bs.in 420
scoreboard players set $math.atan2.x bs.in -700
function #bs.math:atan2
assert score $math.atan2 bs.out matches 14902..14904

scoreboard players set $math.atan2.y bs.in -826
scoreboard players set $math.atan2.x bs.in 200
function #bs.math:atan2
assert score $math.atan2 bs.out matches -7639..-7637
