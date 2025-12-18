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

execute if data storage bs:ctx _.pose.head run function bs.animation:reset/pose/head
execute if data storage bs:ctx _.pose.body run function bs.animation:reset/pose/body
execute if data storage bs:ctx _.pose.left_arm run function bs.animation:reset/pose/left_arm
execute if data storage bs:ctx _.pose.left_leg run function bs.animation:reset/pose/left_leg
execute if data storage bs:ctx _.pose.right_arm run function bs.animation:reset/pose/right_arm
execute if data storage bs:ctx _.pose.right_leg run function bs.animation:reset/pose/right_leg
