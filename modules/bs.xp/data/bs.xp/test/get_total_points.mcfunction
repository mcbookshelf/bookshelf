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

xp set @s 42 levels
assert result 3333 run function #bs.xp:get_total_points
assert result 3333 run data get storage bs.xp:get_total_points out

xp add @s -2500 points
assert result 833 run function #bs.xp:get_total_points
assert result 833 run data get storage bs.xp:get_total_points out

xp add @s -700 points
assert result 133 run function #bs.xp:get_total_points
assert result 133 run data get storage bs.xp:get_total_points out
