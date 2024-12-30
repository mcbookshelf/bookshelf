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

scoreboard players set $math.combine.n bs.in 42
scoreboard players set $math.combine.k bs.in 7
function #bs.math:combine
assert score $math.combine bs.out matches 26978328

scoreboard players set $math.combine.n bs.in 128
scoreboard players set $math.combine.k bs.in 3
function #bs.math:combine
assert score $math.combine bs.out matches 341376

scoreboard players set $math.combine.n bs.in 42
scoreboard players set $math.combine.k bs.in 9
function #bs.math:combine
assert score $math.combine bs.out matches 445891810
