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

execute store result score $xp.get_max_points bs.out run xp query @s levels
execute if score $xp.get_max_points bs.out matches 0..15 run return run function bs.xp:get/max_points/range_1
execute if score $xp.get_max_points bs.out matches 16..30 run return run function bs.xp:get/max_points/range_2
execute if score $xp.get_max_points bs.out matches 31.. run return run function bs.xp:get/max_points/range_3
