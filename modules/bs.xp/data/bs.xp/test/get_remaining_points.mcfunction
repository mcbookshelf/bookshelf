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

xp set @s 5 levels
xp set @s 5 points
assert result 12 run function #bs.xp:get_remaining_points
assert result 12 run data get storage bs.xp:get_remaining_points out

xp set @s 21 levels
xp set @s 12 points
assert result 55 run function #bs.xp:get_remaining_points
assert result 55 run data get storage bs.xp:get_remaining_points out

xp set @s 42 levels
xp set @s 18 points
assert result 202 run function #bs.xp:get_remaining_points
assert result 202 run data get storage bs.xp:get_remaining_points out
