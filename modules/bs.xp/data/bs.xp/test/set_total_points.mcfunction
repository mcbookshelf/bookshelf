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

# @dummy

function #bs.xp:set_total_points.in {points:8}
assert result 1 run xp query @s levels
assert result 1 run xp query @s points

data modify storage bs.xp:set_total_points in set value {points:500}
function #bs.xp:set_total_points
assert result 19 run xp query @s levels
assert result 7 run xp query @s points

data modify storage bs.xp:set_total_points in set value {points:2000}
function #bs.xp:set_total_points
assert result 34 run xp query @s levels
assert result 103 run xp query @s points
